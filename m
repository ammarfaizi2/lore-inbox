Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTILUaf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTILUaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:30:35 -0400
Received: from [212.95.164.66] ([212.95.164.66]:9482 "HELO ns.unixsol.org")
	by vger.kernel.org with SMTP id S261884AbTILUaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:30:24 -0400
Message-ID: <3F622CDD.9010600@unixsol.org>
Date: Fri, 12 Sep 2003 23:30:21 +0300
From: Georgi Chorbadzhiyski <gf@unixsol.org>
Organization: Unix Solutions Ltd. (http://unixsol.org)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030811
X-Accept-Language: en, en-us, bg
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [bug] Some files in 2.6 archive are with 640 perms
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
some files in the 2.6 archive are with 640 permission when they
really should be 644.

Here is the list of files:
-rw-r----- linux-2.6.0-test5/Documentation/scsi/ChangeLog.megaraid
-rw-r----- linux-2.6.0-test5/arch/arm/common/amba.c
-rw-r----- linux-2.6.0-test5/arch/arm/common/icst525.c
-rw-r----- linux-2.6.0-test5/arch/arm/common/platform.c
-rw-r----- linux-2.6.0-test5/arch/arm/mach-integrator/Kconfig
-rw-r----- linux-2.6.0-test5/arch/arm/mach-integrator/impd1.c
-rw-r----- linux-2.6.0-test5/arch/arm/mm/mmu.c
-rw-r----- linux-2.6.0-test5/drivers/char/agp/isoch.c
-rw-r----- linux-2.6.0-test5/drivers/input/joystick/grip_mp.c
-rw-r----- linux-2.6.0-test5/drivers/net/arm/ether00.c
-rw-r----- linux-2.6.0-test5/include/asm-arm/arch-integrator/impd1.h
-rw-r----- linux-2.6.0-test5/include/asm-arm/hardware/amba.h
-rw-r----- linux-2.6.0-test5/include/asm-arm/hardware/icst525.h
-rw-r----- linux-2.6.0-test5/include/asm-arm/sections.h
-rw-r----- linux-2.6.0-test5/include/asm-arm/traps.h
-rw-r----- linux-2.6.0-test5/include/video/neomagic.h

Can you run

   bk chmod 644 \
     Documentation/scsi/ChangeLog.megaraid \
     arch/arm/common/amba.c \
     arch/arm/common/icst525.c \
     arch/arm/common/platform.c \
     arch/arm/mach-integrator/Kconfig \
     arch/arm/mach-integrator/impd1.c \
     arch/arm/mm/mmu.c \
     drivers/char/agp/isoch.c \
     drivers/input/joystick/grip_mp.c \
     drivers/net/arm/ether00.c \
     include/asm-arm/arch-integrator/impd1.h \
     include/asm-arm/hardware/amba.h \
     include/asm-arm/hardware/icst525.h \
     include/asm-arm/sections.h \
     include/asm-arm/traps.h \
     include/video/neomagic.h

to fix this. Thanks!

-- 
Georgi Chorbadzhiyski
http://georgi.cybcom.net/
http://georgi.unixsol.org/

