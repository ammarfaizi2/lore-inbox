Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbULSRes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbULSRes (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 12:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbULSRes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 12:34:48 -0500
Received: from gprs215-234.eurotel.cz ([160.218.215.234]:16768 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261315AbULSReq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 12:34:46 -0500
Date: Sun, 19 Dec 2004 18:34:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc3-mm1: swsusp
Message-ID: <20041219173433.GA1130@elf.ucw.cz>
References: <200412181852.31942.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412181852.31942.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I must say I'm really impressed with the progress that swsusp made since I 
> tried it last time (close to 2.6.10-rc1 as I recall).  Now I've been using it 
> for a couple of days on 2.6.10-rc3-mm1 and It's never refused to suspend the 
> machine because of the lack of (contiguous) memory which happened very often 
> before, and it seems to be much faster.  Using it my notebook has
> reached 

Hmmm, unfortunately I did not changes in that area. Perhaps memory
managment was fixed/improved?

> Still, unfortunately, today it crashed on suspend and I wasn't able to get any 
> useful information related to the crash, because swsusp apparently does not 
> send some of its messages to the serial console.  In particular, anything 
> from within the critical section is not printed there and that's why I think 
> (I'm not sure though) that the crash occured in the critical section.  Could 
> you tell me please if it's possible to make all of the swsusp messages appear 
> on the serial console and, if so, how to do this (I've already tried "dmesg 
> -n 8" and "echo 9 > /proc/sysrq-trigger" but none of them helps)?

Using regular vga console and digital camera seems to be popular way
to get dumps. I'm not sure why swsusp critical section interferes with
serial, perhaps serial console support has to "know" about serial
console and not suspend it during suspend() call?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
