Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRLLOWx>; Wed, 12 Dec 2001 09:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280190AbRLLOWn>; Wed, 12 Dec 2001 09:22:43 -0500
Received: from hauptpostamt.charite.de ([193.175.73.10]:19926 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S280132AbRLLOW0>; Wed, 12 Dec 2001 09:22:26 -0500
From: fridtjof@fbunet.de
To: linux-kernel@vger.kernel.org
Subject: Repost: ASUS APM Problem (ASUS L8400L & ASUS P2B-F)
Message-ID: <20011209175547.GD7707@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Date: Wed, 12 Dec 2001 09:22:43 -0500

Type of Computers: 

* ASUS L8400L, x86 based laptop system, see
  http://www.magicdevices.de/notebooks/asus/l_8400_k-1133_tl.html
  for details

* ASUS P2B-F Board, x86 based desktop system

Common problem of both the desktop PC and the laptop:

$ cat /proc/apm
1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?
                             ^^^^^^^^
$ dmesg | grep apm
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)

Kernels where this occurs:

* Kernel 2.4.16 
* RedHat Kernel 2.4.9-13.

Kernel Config concerning APM and ACPI:

$ egrep -i "(APM|ACPI)" .config
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

Anybody know why APM doesn't work with products from ASUS?
Is this a known bug?
