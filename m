Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263904AbUECT3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbUECT3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 15:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbUECT3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 15:29:54 -0400
Received: from gprs214-205.eurotel.cz ([160.218.214.205]:6272 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263904AbUECT3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 15:29:52 -0400
Date: Mon, 3 May 2004 21:29:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: Hamie <hamish@travellingkiwi.com>, linux-kernel@vger.kernel.org
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
Message-ID: <20040503192940.GA3531@elf.ucw.cz>
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <20040503123150.GA1188@openzaurus.ucw.cz> <40965DAA.4040504@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40965DAA.4040504@pointblue.com.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Use echo 4 > /proc/acpi/sleep, and vanilla kernels.
> >
> >			
> >
> What If it happends that I have T22 Thinkpad, and it doesn't work with 
> ACPI in 2.6 (causes problems with network cards for some reason, long 
> and not yet fixed bug in ACPI), and I don't have /proc/acpi. How can I 
> use swsusp than ?

I added entry to FAQ:

Q: My machine doesn't work with ACPI. How can I use swsusp than ?

A: Do reboot() syscall with right parameters. Warning: glibc gets in
its way, so check with strace:

reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 0xd000fce2)

Ouch, and when you code that trivial program, send me source, I lost
mine.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
