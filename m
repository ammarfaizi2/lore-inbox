Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUJNTH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUJNTH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUJNTFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:05:11 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:31971 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S267350AbUJNTDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:03:23 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Thu, 14 Oct 2004 12:02:36 -0700
MIME-Version: 1.0
Subject: Generic VESA framebuffer driver and Video card BOOT?
CC: linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org
Message-ID: <416E6ADC.3007.294DF20D@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am writing this email to guage the interest in having code contributed 
to the main stream Linux kernel that would support the user of a generic, 
full featured VESA framebuffer driver that works on any CPU architecture 
along with a generic Video card BOOT or POST mechanism.

We have been working on a project under contract to ATI that involves 
porting a version of our SNAPBoot BIOS emulator solution to the PowerPC 
Linux kernel. The SNAPBoot code supports initialising a graphics card 
using an x86 BIOS image on any platform (currently tesed on x86, x86-64 
and PowerPC). Initially SNAPBoot was developed to work across multiple 
operating systems and CPU architectures from user space, but the desire 
to use it to initialise the graphics card on embedded PowerPC kernels 
prompted us to port a version of it for use within the Linux kernel. The 
version we have ported for use in the kernel can be used to initialise 
the graphics card for use with any accelerated framebuffer console 
driver, such as the radeonfb driver which we are currently using it with.

Note that the SNAPBoot code uses the x86emu BIOS emulator project as the 
core CPU emulation technology, and project we have been actively involved 
with for many years since the licensing on the project was changed to 
MIT/BSD style licensing and incorporated into the XFree86 project. We 
have built code on top of x86emu to provide generic support for 
initialising graphics cards on multiple platforms as well as supporting 
initialisation of modern NonVGA graphics cards (like the ATI Radeon 
family) without needing access to real VGA resources such as VGA I/O 
ports and physical memory at 0xA0000-0xBFFFF.

More importantly we have used SNAPBoot to port our generic VESA SNAP 
display driver to work on multiple operating systems and platforms, 
including both x86-64 and PowerPC platforms. Using this driver you can 
use any graphics card in the machine and it will support all the features 
provided by the graphics cards VESA BIOS, including support for refresh 
rate control on cards that support VBE 3.0 services. We have been 
actively testing both the SNAPBoot capability and the BIOS emulator on 
many platforms and graphics cards, and the latest version work flawlessly 
on just about every graphics card we have tested.

What this means is that it should be possible to build a new version of 
the VESA framebuffer console driver for the Linux kernel that will have 
these important features:

1. Be able to switch display modes on the fly, supporting all modes 
enumerated by the Video BIOS.

2. Be able to support refresh rate control on graphics cards that support 
the VBE 3.0 services.

3. Be able to support 8-bit and 32-bit display modes on any graphics card 
on big endian machines (16-bit is not possible unless software rendering 
code is written to enable endian swapping in software, which may be 
possible).

So what we would like to find out is how much interest there might be in 
both an updated VESA framebuffer console driver as well as the code for 
the Video card BOOT process being contributed to the maintstream kernel. 
If there is interest, we would start out by first contributing the core 
emulator and Video BOOT code, and then work on building a better VESA 
framebuffer console driver. 

So what do you guys think? 

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


