Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUGOMSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUGOMSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 08:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUGOMSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 08:18:40 -0400
Received: from gprs214-103.eurotel.cz ([160.218.214.103]:5252 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266181AbUGOMSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 08:18:38 -0400
Date: Thu, 15 Jul 2004 14:18:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsuspend not working
Message-ID: <20040715121825.GC22260@elf.ucw.cz>
References: <20040715121042.GB9873@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715121042.GB9873@lps.ens.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I booted with " root=/dev/hda2 resume=/dev/hda5 init=/bin/sh". No initrd,
> of course. Once I had a prompt, I mounted /proc and echoed 4 to
> /proc/acpi/sleep. The screen blinked and 3 seconds later I was back at my
> shell. The computer did not suspend. One very bad thing happened: in the
> process, the fan controller was reset. It means that the fan went full
> speed, while before it was in a low speed/low noise mode set up by the
> bios. I know I cannot bring it back to the low speed/low noise setting
> from linux, I must reboot the computer. But anyway, the computer did not
> suspend.
> 
> Here are the kernel messages I got:
> -----------------------------------------
> dsmthdat-0462 [36] ds_method_data_get_val: Uninitialized Local[0] at node df72f10c
> Freeing memory: .....|
> PM: Attempting to suspend to disk.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You are not really using swsusp. You are using pmdisk. Fix your
kernel config.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
