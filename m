Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267924AbUBRTav (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267955AbUBRTau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:30:50 -0500
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:64701 "EHLO
	garfield") by vger.kernel.org with ESMTP id S267924AbUBRT3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:29:10 -0500
Message-ID: <4033BD0A.8050609@free.fr>
Date: Wed, 18 Feb 2004 20:29:14 +0100
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031015 Debian/1.4-0jds2
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.3-mm1] error reporting
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to compile 2.6.3-mm1, and here is what I got :

[...]

   CC      arch/i386/kernel/doublefault.o
   CC      arch/i386/kernel/entry_trampoline.o
   CC      arch/i386/kernel/acpi/boot.o
arch/i386/kernel/acpi/boot.c: In function `acpi_apic_setup':
arch/i386/kernel/acpi/boot.c:460: warning: unused variable `result'
   LD      arch/i386/kernel/acpi/built-in.o
   CC      arch/i386/kernel/cpu/common.o
   CC      arch/i386/kernel/cpu/proc.o

[...]

   CLUT224 drivers/video/logo/logo_sun_clut224.c
   CLUT224 drivers/video/logo/logo_superh_clut224.c
   CC      drivers/video/riva/fbdev.o
drivers/video/riva/fbdev.c: In function `rivafb_cursor':
drivers/video/riva/fbdev.c:1533: warning: implicit declaration of 
function `move_buf_aligned'
   CC      drivers/video/riva/riva_hw.o
   CC      drivers/video/riva/nv_driver.o
   LD      drivers/video/riva/rivafb.o

[...]

   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x84747): In function `rivafb_cursor':
: undefined reference to « move_buf_aligned »
drivers/built-in.o(.text+0x8475d): In function `rivafb_cursor':
: undefined reference to « move_buf_aligned »
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/usr/src/linux-2.6.3'
make: *** [stamp-build] Error 2


.config : http://fabian.fenaut.free.fr/config-2.6.3-mm1
complete compile log: http://fabian.fenaut.free.fr/compile_error-2.6.3-mm1


I thought there had been a patch for this, but I can't find it...

Thanks for your help !

--
Fabian

