Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTI1Rdu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbTI1Rdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:33:50 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:35853 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262640AbTI1Rdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:33:47 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: CONFIG_I8042
Date: Mon, 29 Sep 2003 01:31:42 +0800
User-Agent: KMail/1.5.2
References: <20030928160314.A1428@flint.arm.linux.org.uk> <20030928161059.B1428@flint.arm.linux.org.uk>
In-Reply-To: <20030928161059.B1428@flint.arm.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309290131.42619.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 September 2003 23:10, Russell King wrote:

> Correction - it is due to this change:
> 
> | --- 1.7/drivers/input/keyboard/Kconfig  Fri Sep 19 12:51:31 2003
> | +++ 1.8/drivers/input/keyboard/Kconfig  Sun Sep 21 03:44:11 2003
> | @@ -13,9 +13,9 @@
> | 
> |  config KEYBOARD_ATKBD
> |         tristate "AT keyboard support" if EMBEDDED || !X86
> | -       default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
> | -       default m
> | -       depends on INPUT && INPUT_KEYBOARD && SERIO
> | +       default y
> | +       depends on INPUT && INPUT_KEYBOARD
> | +       select SERIO_I8042
> |         help
> |           Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
> |           you'll need this, unless you have a different type keyboard (USB, ADB
> 

Could there be another menu to select system type when x86

-Standard-PC EMBEDDED=0 X86=1, MMU=1, VID16=1, SBUS=0, GENERIC_ISA_DMA=1

  Use this for ease of configuration in most PC applications.

-Custom-PC EMBEDDED=0 X86=0, MMU=1, VID16=1, SBUS=0, GENERIC_ISA_DMA=1

  Use this in specialized PC applications to enable less
  frequently used configuration options.
  Beware that this requires more intricate knowledge of PC 
  hardware and the kernel subsystems

-Embedded EMBEDDED=1 X86=0, MMU=user, VID16=user, SBUS=user, GENERIC_ISA_DMA=user 

  Use this option when running the kernel on an embedded system to
  maximize configuration capability. This option is generally unsuitable
  in PC applications.

Regards
Michael

