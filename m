Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUBEV4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266907AbUBEV4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:56:17 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:8972
	"EHLO muru.com") by vger.kernel.org with ESMTP id S266905AbUBEV4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:56:11 -0500
Date: Thu, 5 Feb 2004 13:56:20 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040205215620.GC9757@atomide.com>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz> <20040205181704.GC7658@atomide.com> <20040205184841.GB590@elf.ucw.cz> <20040205213303.GA9757@atomide.com> <20040205213837.GF1541@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205213837.GF1541@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [040205 13:39]:
> 
> Well, I wanted some way to detect exactly this broken machine. You
> might want to simply put == 8 there.. but proper solution is DMI blacklist. 

Or just use the current running values for max speed. That will fail if the
system boots at lower speeds on battery though. And the BIOS checks will
fail on buggy BIOSes and when upgrading the CPU. So maybe use both checks?

> 
> > What do you think about using module options maxfid and maxvid?
> 
> Well, the original BIOS has not only maximum values wrong, but also
> 1600MHz wrong, as far as I can tell...

Outch! I did not know that...

Are the middle values needed? What if you only use the min and max 
fid/vid values, and always recalculate the stepping tables from those 
values?

> Something like /proc/frequencies file would be needed where you could
> 
> echo "0 0xa; 0x8 0x6; 0xa 0x2" > /proc/frequencies to override. You
> need to override all of them, not just top one.

Maybe not, if the stepping table would get recalculated on init?

Tony
