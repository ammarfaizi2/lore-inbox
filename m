Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSD0NCR>; Sat, 27 Apr 2002 09:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313702AbSD0NCQ>; Sat, 27 Apr 2002 09:02:16 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:22028 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313698AbSD0NCQ>; Sat, 27 Apr 2002 09:02:16 -0400
Date: Sat, 27 Apr 2002 15:02:06 +0200
From: tomas szepe <kala@pinerecords.com>
To: dmacbanay@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: ACPI in 2.5 kills kbd on Via-ACPI systems [Re: kernel 2.5.10 problems]
Message-ID: <20020427150206.A30695@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a (up 5 days, 7:39)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. When ACPI support is installed the kernel gives a "Keyboard not found"
> error when booting and I have to push the reset switch to reboot. This
> problem has also been mentioned before but I don't think anyone has related
> it to the ACPI support.

You're right! I tried to point out before that my system had ignored the
keyboard since about the time of 2.5.7/2.5.8, but it didn't occur to me that
the problem could be ACPI related. Indeed, after compiling 2.5.10-dj1 (2.5.10
vanilla barfs an oops at me upon boot) w/ ACPI support turned off, I found
the system perfectly responsive again -- both mouse and keyboard work.

Thus I dare assume it's highly probable that input support has been broken
for VIA chipset-based systems by the recent ACPI changes in 2.5.x.

Cheers,
Tomas Szepe

<.config> # -- the affected .config excerpt --
	CONFIG_ACPI=y
	CONFIG_ACPI_BOOT=y
	CONFIG_ACPI_BUS=y
	CONFIG_ACPI_EC=y
	CONFIG_ACPI_INTERPRETER=y
	CONFIG_ACPI_PCI=y
	CONFIG_ACPI_POWER=y
	CONFIG_ACPI_SLEEP=y
	CONFIG_ACPI_SYSTEM=y
	# CONFIG_ACPI_AC is not set
	# CONFIG_ACPI_BATTERY is not set
	CONFIG_ACPI_BUTTON=y
	CONFIG_ACPI_FAN=y
	CONFIG_ACPI_PROCESSOR=y
	CONFIG_ACPI_THERMAL=y
	# CONFIG_ACPI_DEBUG is not set
</.config>

-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          
