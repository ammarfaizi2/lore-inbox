Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030584AbVKQBqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbVKQBqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbVKQBqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:46:00 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:25005 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1030584AbVKQBp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:45:59 -0500
Date: Thu, 17 Nov 2005 02:45:58 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X and intelfb fight over videomode
Message-ID: <20051117014558.GA30088@hardeman.nu>
References: <20051117000144.GA29144@hardeman.nu> <437BD8D9.9030904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <437BD8D9.9030904@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 09:11:53AM +0800, Antonino A. Daplas wrote:
>David Härdeman wrote:
>> intelfb: Changing the video mode is not supported.

>Try booting with video=intelfb:1024x768-16@60,mtrr=0. Do not include
>the vga=0x318 option.  This prevents intelfb from changing the videomode.

It seems that intelfb can't change it no matter what....booting with 
video=intelfb:1024x768-16@60,mtrr=0 gives me the usual vga console and 
no framebuffer. The following is printed during boot:

[...]
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G chipsets
intelfb: Version 0.9.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
intelfb: 00:02.0: Intel(R) 852GM, aperture size 128MB, stolen memory 8060kB
intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
intelfb: Video mode must be programmed at boot time.
[...]

On the other hand, the vga=0x318 gives a 1024x768 console (and the vc 
<-> X fight) with the following messages during boot:

[...]
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G chipsets
intelfb: Version 0.9.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
intelfb: 00:02.0: Intel(R) 852GM, aperture size 128MB, stolen memory 8060kB
intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
intelfb: Initial video mode is 1024x768-32@60.
intelfb: Changing the video mode is not supported.
Console: switching to colour frame buffer device 128x48
[...]

(I tried X in 1024x768-32bpp after seeing the messages from the vga=... 
boot but the problems remained)

Suggestions?


//David
