Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280387AbRLLOfp>; Wed, 12 Dec 2001 09:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280448AbRLLOff>; Wed, 12 Dec 2001 09:35:35 -0500
Received: from [195.63.194.11] ([195.63.194.11]:14855 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280387AbRLLOfR>; Wed, 12 Dec 2001 09:35:17 -0500
Message-ID: <3C1768BD.96F0CC47@evision-ventures.com>
Date: Wed, 12 Dec 2001 15:25:01 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: fridtjof@fbunet.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Repost: ASUS APM Problem (ASUS L8400L & ASUS P2B-F)
In-Reply-To: <20011209175547.GD7707@charite.de>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fridtjof@fbunet.de wrote:
> 
> Type of Computers:
> 
> * ASUS L8400L, x86 based laptop system, see
>   http://www.magicdevices.de/notebooks/asus/l_8400_k-1133_tl.html
>   for details
> 
> * ASUS P2B-F Board, x86 based desktop system
> 
> Common problem of both the desktop PC and the laptop:
> 
> $ cat /proc/apm
> 1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?
>     

   cat /proc/apm 
1.15 1.2 0x03 0x01 0x03 0x09 100% -1 ?

Looks fine!

 dmesg | grep apm
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)


> $ dmesg | grep apm
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
> 
> Kernels where this occurs:
> 
> * Kernel 2.4.16
> * RedHat Kernel 2.4.9-13.

  uname -a
Linux kozaczek 2.4.16-2 #1 ¶ro lis 28 16:55:12 CET 2001 i686 unknown
[root@kozaczek t1lib]# 


> Kernel Config concerning APM and ACPI:
> 
> $ egrep -i "(APM|ACPI)" .config
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_RTC_IS_GMT=y
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
>  

egrep -i "(APM|ACPI)" /usr/src/linux/configs/kernel-2.4.16-i686.config 
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
root@kozaczek t1lib]# 

> Anybody know why APM doesn't work with products from ASUS?
> Is this a known bug?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
  
Subsystem: Asustek Computer, Inc.: Unknown device 1434

The "Unknown device is a 8600A series notbook 
and *eveything* on it works fine on linux, even the
AC'97 sound as well as the windows modem.

So it generally isn'y true that producst from ASUS don't
work under linux....
