Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280402AbRLEVwG>; Wed, 5 Dec 2001 16:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281568AbRLEVv5>; Wed, 5 Dec 2001 16:51:57 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:28166 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280402AbRLEVvq>; Wed, 5 Dec 2001 16:51:46 -0500
Date: Wed, 5 Dec 2001 21:31:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: mj@ucw.cz
Subject: Re: pci=biosirq... Is the machien having fun with me?
Message-ID: <20011205213127.A116@elf.ucw.cz>
In-Reply-To: <20011205211410.A117@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011205211410.A117@elf.ucw.cz>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On hp omnibook xe3, Sound is working poorly. Its maestro3 *plays*, but
> repeats portions.... No wonder.... It probably did not receive correct
> irq (while playing music!):
> 
> root@amd:~# cat /proc/interrupts
>            CPU0
>   0:      14014          XT-PIC  timer
>   1:       1134          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:          0          XT-PIC  Allegro
>   9:          1          XT-PIC  acpi
>  10:        111          XT-PIC  pcnet_cs
>  11:          8          XT-PIC  Texas Instruments PCI1420, Texas Instruments PCI1420 (#2)
>  12:        420          XT-PIC  PS/2 Mouse
>  14:      28392          XT-PIC  ide0
>  15:          8          XT-PIC  ide1
> NMI:          0
> ERR:          0
> root@amd:~#
> 
> So I did as adviced, appended pci=biosirq to commandline:

Okay, that message was pretty confusing. I had to select PCI_GOANY=y
for pci=biosirq to be recognized...

But /proc/interrupts still looks the same, and sound is still funny.

pavel@amd:~$ cat /proc/interrupts
           CPU0
  0:      16893          XT-PIC  timer
  1:        930          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  Allegro
  9:          1          XT-PIC  acpi
 10:        172          XT-PIC  pcnet_cs
 11:          8          XT-PIC  Texas Instruments PCI1420, Texas Instruments PCI1420 (#2)
 12:          6          XT-PIC  PS/2 Mouse
 14:      36712          XT-PIC  ide0
 15:          8          XT-PIC  ide1
NMI:          0
ERR:          0
pavel@amd:~$

What else should I try?
							Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
