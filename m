Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267753AbSLSX00>; Thu, 19 Dec 2002 18:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267754AbSLSX00>; Thu, 19 Dec 2002 18:26:26 -0500
Received: from pop.gmx.de ([213.165.65.60]:65316 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267753AbSLSX0Y>;
	Thu, 19 Dec 2002 18:26:24 -0500
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.52: agp, drm, i810 problem
Date: Fri, 20 Dec 2002 00:34:12 +0100
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200212200034.16969.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

I am running 2.5.52 (I must say that it is the best kernel I ever had, first 
time acpi and sony jog dial are working, great)

But I have some agp problems at the moment:

$ modprobe i810
FATAL: Error inserting i810 
(/lib/modules/2.5.52/kernel/drivers/char/drm/i810.ko): Cannot allocate memory

[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0x00000000, data=0x0
Call Trace:
 [<c0120852>] check_timer_failed+0x42/0x50
 [<c0120c87>] del_timer+0x17/0x80
 [<c4969005>] i810_takedown+0x45/0x3b0 [i810]
 [<c496d516>] i810_stub_unregister+0x36/0x3d [i810]
 [<c49460e6>] 0xc49460e6
 [<c4970120>] +0xa60/0x2940 [i810]
 [<c4970102>] +0xa42/0x2940 [i810]
 [<c012a732>] sys_init_module+0xfe/0x178
 [<c0108cd7>] syscall_call+0x7/0xb

Here is some output of lspci:

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory 
Controller Hub (rev 11)
        Subsystem: Sony Corporation: Unknown device 80de
        Flags: bus master, fast devsel, latency 0
        Capabilities: [88] #09 [f205]

00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics 
Controller] (rev 11) (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 80de
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 9
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Memory at f4000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 2


I tried the i810 drm driver as module and compiled in part.


thanks
have fun
Felix
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Ald4S0DOrvdnsewRApnqAKCAM3Way11XvYh4MO/eBTPEwiKnjACdGC93
sS7eDI5YzZabkFWTb7H8mVs=
=D+qr
-----END PGP SIGNATURE-----

