Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbRAEVAk>; Fri, 5 Jan 2001 16:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130112AbRAEVAa>; Fri, 5 Jan 2001 16:00:30 -0500
Received: from jelerak.scrye.com ([207.174.18.194]:42254 "HELO scrye.com")
	by vger.kernel.org with SMTP id <S129775AbRAEVAW>;
	Fri, 5 Jan 2001 16:00:22 -0500
Message-ID: <20010105210016.1778.qmail@scrye.com>
Date: Fri, 5 Jan 2001 14:00:16 -0700 (MST)
From: Kevin Fenzi <kevin@scrye.com>
To: linux-kernel@vger.kernel.org
Subject: X and 2.4.0 problem (video bios probing?)
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there. Having been running the 2.4.0-test kernels on my laptop, I
quickly upgraded to 2.4.0 when it came out. A problem quickly arose: 

X won't start. 

Under 2.4.0-test12 it works fine. 

Under 2.4.0 it exits after trying to load the int10 module...

from 2.4.0-test12 (and all others):

(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
        compiled for 4.0.1a, module version = 1.0.0
        ABI class: XFree86 Video Driver, version 0.2
(II) ATI(0): Primary V_BIOS segment is: 0xc000
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
        compiled for 4.0.1a, module version = 1.0.0
        ABI class: XFree86 Video Driver, version 0.2
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
        compiled for 4.0.1a, module version = 1.0.0
        ABI class: XFree86 Video Driver, version 0.2
(II) ATI(0): VESA Bios detected
(II) ATI(0): VESA VBE Version 2.0
(II) ATI(0): VESA VBE Total Mem: 8128 kB
(II) ATI(0): VESA VBE OEM: ATI MACH64
(II) ATI(0): VESA VBE OEM Software Rev: 1.0
(II) ATI(0): VESA VBE OEM Vendor: ATI Technologies Inc.
(II) ATI(0): VESA VBE OEM Product: MACH64RM
(II) ATI(0): VESA VBE OEM Product Rev: 01.00
(II) ATI(0): VESA VBE DDC supported
(II) ATI(0): VESA VBE DDC Level none
(II) ATI(0): VESA VBE DDC transfer in appr. 2 sec.
(==) ATI(0): Chipset:  "ati".
(--) ATI(0): ATI 3D Rage Mobility graphics controller detected.
(--) ATI(0): Chip type 4C4D "LM", version 4, foundry TSMC, class 0, revision 0x01.
(--) ATI(0): AGP bus interface detected;  block I/O base is 0x2000.
(--) ATI(0): ATI Mach64 adapter detected.
(--) ATI(0): Internal RAMDAC (subtype 1) detected.
(--) ATI(0): 1400x1050 panel (ID 6) detected.
(--) ATI(0): Panel model IBM ITSX93.
(--) ATI(0): Panel clock is 107.859 MHz.

under 2.4.0 (final):

(II) Setting vga for screen 0.
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
        compiled for 4.0.1a, module version = 1.0.0
        ABI class: XFree86 Video Driver, version 0.2
(EE) ATI(0): Unable to initialise int10 interface.
(II) UnloadModule: "ati"
(II) UnloadModule: "int10"
(II) Unloading /usr/X11R6/lib/modules/linux/libint10.a
(EE) Screen(s) found, but none have a usable configuration.

Fatal server error:
no screens found

Things I have ruled out:

- Compiled with redhat 7's gcc 2.96 snapshot, and also with kgcc. No
diffrence. 

- did a cat /proc/pci, lspci, and cat /proc/inturrupts and compaired
2.4.0 and 2.4.0-test12 and they were identical. 

- Without changing anything besides the kernel X works. If I am in
2.4.0-test12 it's fine, if I am in 2.4.0 (final) it fails. 

Further debugging, requests for logs, patches, or ideas are welcome. 

This laptop is a dell inspiron 5000 (not 5000e). It has worked just
fine with X until now. It's a redhat 7 + all errata. It has
XFree86-4.0.1a on it. 

thanks for any suggestions. 

kevin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
