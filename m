Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267030AbUBFBPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 20:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267045AbUBFBPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 20:15:11 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:62220
	"EHLO muru.com") by vger.kernel.org with ESMTP id S267030AbUBFBPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 20:15:01 -0500
Date: Thu, 5 Feb 2004 17:15:10 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040206011509.GE10268@atomide.com>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz> <20040205181704.GC7658@atomide.com> <20040205184841.GB590@elf.ucw.cz> <20040205213303.GA9757@atomide.com> <20040205213837.GF1541@elf.ucw.cz> <20040205215620.GC9757@atomide.com> <20040206002806.GB1736@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206002806.GB1736@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [040205 16:28]:
> Hi!
> 
> > > Well, I wanted some way to detect exactly this broken machine. You
> > > might want to simply put == 8 there.. but proper solution is DMI blacklist. 
> > 
> > Or just use the current running values for max speed. That will fail if the
> > system boots at lower speeds on battery though. And the BIOS checks will
> > fail on buggy BIOSes and when upgrading the CPU. So maybe use both checks?
> 
> Well... for your own kernel hack it any way you want.
> 
> For public consumtion... I guess DMI blacklist and assume user did not
> exchange cpus... We could cross-check /proc/cpuinfo.

Yeah, I don't care as long as it works good :)

> > > > What do you think about using module options maxfid and maxvid?
> > > 
> > > Well, the original BIOS has not only maximum values wrong, but also
> > > 1600MHz wrong, as far as I can tell...
> > 
> > Outch! I did not know that...
> > 
> > Are the middle values needed? What if you only use the min and max 
> > fid/vid values, and always recalculate the stepping tables from those 
> > values?
> 
> Well, 1600MHz operation is very nice, as it has significantly less
> power consumption but pretty much same performance. It also does not
> start CPU fan most of the time :-).  

Yes, 1600MHz would be nice, I agree.

But I meant calculating all the valid values inbetween min and max without
relying on getting those values from the BIOS.

Then you would only need to find out the min and max values, and not
care about bugs in the BIOS table inbetween min and max.

I guess the code already does that to figure out how many steps are needed
to change between min and max?

Tony
