Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbULFNfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbULFNfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 08:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbULFNfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 08:35:15 -0500
Received: from gprs214-164.eurotel.cz ([160.218.214.164]:50816 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261199AbULFNfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 08:35:10 -0500
Date: Mon, 6 Dec 2004 14:34:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: wakeup_pmode_return jmp failing?
Message-ID: <20041206133455.GA1213@elf.ucw.cz>
References: <41B084B4.1050402@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B084B4.1050402@sun.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Not sure who to direct this to.  I've been trying to get acpi s3 to work
> on my pentium M laptop (tecra m2).  Without the nvidia driver loaded, I
> can echo 3 > /proc/acpi/sleep and the machine does indeed suspend (power
> light throbs and all).  However, when I try to wake up the thing, it
> would flash the bios screen and throw me back to grub.
> 
> I've been investigating the code at arch/i386/kernel/acpi/wakeup.S, and
> have discovered that if I place a busy wait directory before the ljmpl
> to wakeup_pmode_return, that I indeed do see 'Lin' on the screen instead
> of the bios screen.
> 
> The joke is, if I place a busy wait first thing after the
> wakeup_pmode_return label, it never gets executed and I get a regular boot.
> 
> It would appear as though the jump from 16bit code into the 32bit code
> is failing and the bios is kicking in with a regular startup.

See archives of linux-acpi lists.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
