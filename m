Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVCBWON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVCBWON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVCBWLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:11:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9617 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262501AbVCBWJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:09:22 -0500
Date: Wed, 2 Mar 2005 23:05:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: paul.devriendt@amd.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Message-ID: <20050302220537.GD1616@elf.ucw.cz>
References: <200502252237.04110.rjw@sisk.pl> <20050227170253.GH1441@elf.ucw.cz> <200502271919.45767.rjw@sisk.pl> <200503022250.12823.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503022250.12823.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It sounds to me like we run at 2GHz from batteries at resume time, and
> > > that causes bad things (tm),
> [-- snip --]
> 
> It seems that we write to the BIOS while moving the image, at least on my box,
> which is quite not correct, IMO.
...
> At the same time, from powernow-k8, I got this:
> 
> powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
> powernow-k8: found PSB header at 0xffff8100000fbb10
> 
> where ffff8100000fbb10 is the (virtual) address containing the PSB header
> (ie a part of the BIOS).  Hence, the PSB gets overwritten during resume (as
> well as some other BIOS stuff, it seems).
> 
> IMO this may lead to unexpected results, like the mysterious reboots during
> resume.

Well, I always thought that ROM-BIOS is expected to
be... well... read-only? Can you really write to your BIOS? [I know
about Flash-BIOSen, but they are certainly not writable by "normal"
write.] Plus we should overwrite it with same values...

Anyway, IMO bios should be marked as reserved (and we should not be
touching reserved pages). Can you verify that your BIOS is properly
marked reserved? [Ccing l-k, this might be interesting.]
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
