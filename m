Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267092AbUBFA2Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267102AbUBFA2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:28:24 -0500
Received: from gprs146-127.eurotel.cz ([160.218.146.127]:47233 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267092AbUBFA2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:28:17 -0500
Date: Fri, 6 Feb 2004 01:28:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040206002806.GB1736@elf.ucw.cz>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz> <20040205181704.GC7658@atomide.com> <20040205184841.GB590@elf.ucw.cz> <20040205213303.GA9757@atomide.com> <20040205213837.GF1541@elf.ucw.cz> <20040205215620.GC9757@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205215620.GC9757@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I wanted some way to detect exactly this broken machine. You
> > might want to simply put == 8 there.. but proper solution is DMI blacklist. 
> 
> Or just use the current running values for max speed. That will fail if the
> system boots at lower speeds on battery though. And the BIOS checks will
> fail on buggy BIOSes and when upgrading the CPU. So maybe use both checks?

Well... for your own kernel hack it any way you want.

For public consumtion... I guess DMI blacklist and assume user did not
exchange cpus... We could cross-check /proc/cpuinfo.

> > > What do you think about using module options maxfid and maxvid?
> > 
> > Well, the original BIOS has not only maximum values wrong, but also
> > 1600MHz wrong, as far as I can tell...
> 
> Outch! I did not know that...
> 
> Are the middle values needed? What if you only use the min and max 
> fid/vid values, and always recalculate the stepping tables from those 
> values?

Well, 1600MHz operation is very nice, as it has significantly less
power consumption but pretty much same performance. It also does not
start CPU fan most of the time :-).  

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
