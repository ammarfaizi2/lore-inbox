Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRIMA2I>; Wed, 12 Sep 2001 20:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272638AbRIMA17>; Wed, 12 Sep 2001 20:27:59 -0400
Received: from 63-151-64-156.hsacorp.net ([63.151.64.156]:53509 "EHLO
	boojiboy.eorbit.net") by vger.kernel.org with ESMTP
	id <S272620AbRIMA1k>; Wed, 12 Sep 2001 20:27:40 -0400
From: chris@boojiboy.eorbit.net
Message-Id: <200109130124.SAA22845@boojiboy.eorbit.net>
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Sep 2001 18:24:18 -0700 (PDT)
Cc: J.A.K.Mouw@ITS.TUDelft.NL, bmacy@macykids.net
In-Reply-To: <20010913011606.H20118@arthur.ubicom.tudelft.nl> from "Erik Mouw" at Sep 13, 2001 01:16:06 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When my bios is set ACPI=NO, and APM is compiled in:
> > A 'shutdown -r' hangs after the "Restarting System" message.  
> > Depressing the power switch cause a power off.
> 
> Try "Use real mode APM BIOS call to power off".

With 2.4.9-ac9 'shutdown -r' does not work.  The
halt '-h' flag does work.  '-r' hangs at "Restarting System."

I set my machine bios to acpi=no, and also acpi=yes the same 
hang occurred both times.

Here is the APM config:

CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y


Here is the pertinent dmesg stuff:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ecc00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
No local APIC present or hardware disabled
Kernel command line: auto BOOT_IMAGE=linux ro root=302
Initializing RT netlink socket
Compaq 12XL125 machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
