Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVBJTd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVBJTd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVBJTd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:33:56 -0500
Received: from gprs214-161.eurotel.cz ([160.218.214.161]:58263 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261349AbVBJTcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:32:53 -0500
Date: Thu, 10 Feb 2005 20:31:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]   Samsung P35, S3, black screen (radeon))
Message-ID: <20050210193123.GC1391@elf.ucw.cz>
References: <1107695583.14847.167.camel@localhost.localdomain> <420BB267.8060108@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420BB267.8060108@tmr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Rumors say that notebooks no longer have video bios at C000h:0; rumors
> >>say that video BIOS on notebooks is simply integrated into main system
> >>BIOS. I personaly do not know if rumors are true, but PCs are ugly
> >>machines....
> >>							
> >
> >
> >A small number of laptop systems are known to pull this trick. There are
> >other problems too - the video bios boot may make other assumptions
> >about access to PCI space, configuration, interrupts, timers etc.
> >
> >Some systems (intel notably) appear to expect you to use the bios
> >save/restore video state not re-POST.
> 
> Isn't that what it's there for? In any context other than save/restore I 
> wouldn't think using the BIOS was a good approach. But this is a special 
> case, and if there's a BIOS function which does the right thing, it 
> would seem to be easier to assume that the BIOS works than that the 
> driver can do every operation for a clean restart.
> 
> The problem is that while POST leaves the video in a known state, it may 
> not the known state you want, nor is it a given that you can get from 
> there to where you were on suspend. PC hardware isn't always that 
> dependable.

Eh? POST leaves video in 80x25 text mode, and we know how to handle
that mode just fine... Historically that's what we ran our consoles
at, so X can handle it etc.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
