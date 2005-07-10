Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVGJSNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVGJSNm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVGJSNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:13:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41100 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262005AbVGJSNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:13:37 -0400
Date: Sun, 10 Jul 2005 20:13:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [40/48] Suspend2 2.1.9.8 for 2.6.12: 616-prepare_image.patch
Message-ID: <20050710181343.GF10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164431308@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164431308@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -ruNp 617-proc.patch-old/kernel/power/suspend2_core/proc.c 617-proc.patch-new/kernel/power/suspend2_core/proc.c
> --- 617-proc.patch-old/kernel/power/suspend2_core/proc.c	1970-01-01 10:00:00.000000000 +1000
> +++ 617-proc.patch-new/kernel/power/suspend2_core/proc.c	2005-07-04 23:14:19.000000000 +1000
> @@ -0,0 +1,336 @@
> +/*
> + * /kernel/power/proc.c
> + *
> + * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
> + *
> + * This file is released under the GPLv2.
> + *
> + * This file contains support for proc entries for tuning Software Suspend.
> + *
> + * We have a generic handler that deals with the most common cases, and
> + * hooks for special handlers to use.
> + *
> + * Versions:
> + * 1: /proc/sys/kernel/suspend the only tuning interface
> + * 2: Initial version of this file
> + * 3: Removed kernel debugger parameter.
> + *    Added checkpage parameter (for checking checksum of a page over time).
> + * 4: Added entry for maximum granularity in splash screen progress bar.
> + *    (Progress bar is slow, but the right setting will vary with disk &
> + *    processor speed and the user's tastes).
> + * 5: Added enable_escape to control ability to cancel aborting by pressing
> + *    ESC key.
> + * 6: Removed checksumming and checkpage parameter. Made all debugging proc
> + *    entries dependant upon debugging being compiled in.
> + *    Meaning of some flags also changed in this version.
> + * 7: Added header_locations entry to simplify getting the resume= parameter for
> + *    swapfiles easy and swapfile entry for automatically doing swapon/off from
> + *    swapfiles as well as partitions.
> + * 8: Added option for marking process pages as pageset 2 (processes_pageset2).
> + * 9: Added option for keep image mode.
> + *    Enumeration patch from Michael Frank applied.
> + * 10: Various corrections to when options are disabled/enabled;
> + *     Added option for specifying expected compression.
> + * 11: Added option for freezer testing. Debug only.
> + * 12: Removed test entries no_async_[read|write], processes_pageset2 and
> + *     NoPageset2.
> + * 13: Make default_console_level available when debugging disabled, but limited
> + *     to 0 or 1.
> + * 14: Rewrite to allow for dynamic registration of proc entries and smooth the
> + *     transition to kobjects in 2.6.
> + * 15: Add setting resume2 parameter without rebooting (still need to run lilo
> + *     though!). Add support for generic string handling and switch resume2 to use
> + *     it.
> + * 16: Switched to cryptoapi, adding entries for selecting encryptor and compressor.

Pretty please, can we support just one version?
										Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
