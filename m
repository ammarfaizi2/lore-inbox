Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEG1x>; Fri, 5 Jan 2001 01:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEG1n>; Fri, 5 Jan 2001 01:27:43 -0500
Received: from 209.102.21.2 ([209.102.21.2]:29711 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129183AbRAEG10>;
	Fri, 5 Jan 2001 01:27:26 -0500
Message-ID: <3A5538DE.92066D9A@goingware.com>
Date: Fri, 05 Jan 2001 03:00:46 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-prerelease-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How is each of your setups, ie, what is compiled in kernel and what is 
> a module ? My guess is: 
> - ACPI+APM in kernel: ACPI wins 
> - APM in kernel, ACPI module; APM starts, blocks ACPI 
> - and so on.... 

Nope.  If they're both in the kernel, APM wins.

When I built with both ACPI and APM, and then APM ran first.  ACPI started up in
the kernel, commented that APM was already there, and exited.

Many folks have given me tips on getting power off to work, I'll screw around to
see if I can get it to go.  But I guess the fact that ACPI exits if APM is
enabled is a real bug.

I know it's hip, cool and efficient to use modules but I often start by
hardwiring things into the kernel because I may not have stuff set up right yet
to load the modules after getting the new kernel.  Just saying Y instead of M
often makes things work without further trouble.

CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set


-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
