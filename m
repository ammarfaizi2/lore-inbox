Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267694AbUBTCKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267689AbUBTCKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:10:34 -0500
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:42250 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S267691AbUBTCI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:08:29 -0500
Subject: [PATCH] : Megaraid patch for 2.6 4/5
From: Paul Wagland <paul@wagland.net>
To: Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@HansenPartnership.com, atulm@lsil.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rzKbwm/vt8Gjs0/uZ4ev"
Message-Id: <1077242903.12567.90.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 03:08:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rzKbwm/vt8Gjs0/uZ4ev
Content-Type: multipart/mixed; boundary="=-My4ZJefUDYqqgrb3+ZqJ"


--=-My4ZJefUDYqqgrb3+ZqJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

This updates some dmesg comments in the 2.6 driver, to make them more
textually consistent.

diff --recursive --ignore-all-space --unified linux-2.6.2.o/drivers/scsi/me=
garaid.c linux-2.6.2.megaraid/drivers/scsi/megaraid.c
--- linux-2.6.2.o/drivers/scsi/megaraid.c	2004-02-20 01:32:30.000000000 +01=
00
+++ linux-2.6.2.megaraid/drivers/scsi/megaraid.c	2004-02-20 01:32:34.000000=
000 +0100
@@ -4587,7 +4587,7 @@
 	subsysvid =3D pdev->subsystem_vendor;
 	subsysid =3D pdev->subsystem_device;
=20
-	printk(KERN_NOTICE "megaraid: found 0x%4.04x:0x%4.04x:bus %d:",
+	printk(KERN_NOTICE "megaraid: notified of 0x%4.04x:0x%4.04x:bus %d:",
 		id->vendor, id->device, pci_bus);
=20
 	printk("slot %d:func %d\n",
@@ -4602,7 +4602,7 @@
 		flag |=3D BOARD_MEMMAP;
=20
 		if (!request_mem_region(mega_baseport, 128, "megaraid")) {
-			printk(KERN_WARNING "megaraid: mem region busy!\n");
+			printk(KERN_WARNING "megaraid: mem region busy\n");
 			goto out_disable_device;
 		}
=20
@@ -4629,7 +4629,7 @@
 	memset(adapter, 0, sizeof(adapter_t));
=20
 	printk(KERN_NOTICE
-		"scsi%d:Found MegaRAID controller at 0x%lx, IRQ:%d\n",
+		"scsi%d: found MegaRAID controller at 0x%lx, IRQ:%d\n",
 		host->host_no, mega_baseport, irq);
=20
 	adapter->base =3D mega_baseport;
@@ -4665,13 +4665,13 @@
 	adapter->mega_buffer =3D pci_alloc_consistent(adapter->dev,
 		MEGA_BUFFER_SIZE, &adapter->buf_dma_handle);
 	if (!adapter->mega_buffer) {
-		printk(KERN_WARNING "megaraid: out of RAM.\n");
+		printk(KERN_WARNING "megaraid: out of RAM\n");
 		goto out_host_put;
 	}
=20
 	adapter->scb_list =3D kmalloc(sizeof(scb_t) * MAX_COMMANDS, GFP_KERNEL);
 	if (!adapter->scb_list) {
-		printk(KERN_WARNING "megaraid: out of RAM.\n");
+		printk(KERN_WARNING "megaraid: out of RAM\n");
 		goto out_free_cmd_buffer;
 	}
=20
@@ -4679,7 +4679,7 @@
 				megaraid_isr_memmapped : megaraid_isr_iomapped,
 					SA_SHIRQ, "megaraid", adapter)) {
 		printk(KERN_WARNING
-			"megaraid: Couldn't register IRQ %d!\n", irq);
+			"megaraid: couldn't register IRQ %d\n", irq);
 		goto out_free_scb_list;
 	}
=20


--=-My4ZJefUDYqqgrb3+ZqJ
Content-Disposition: attachment; filename=4-megaraid.dmesg.patch
Content-Type: text/x-patch; name=4-megaraid.dmesg.patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLXJlY3Vyc2l2ZSAtLWlnbm9yZS1hbGwtc3BhY2UgLS11bmlmaWVkIGxpbnV4LTIuNi4y
Lm8vZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMgbGludXgtMi42LjIubWVnYXJhaWQvZHJpdmVycy9z
Y3NpL21lZ2FyYWlkLmMNCi0tLSBsaW51eC0yLjYuMi5vL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC5j
CTIwMDQtMDItMjAgMDE6MzI6MzAuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjIubWVn
YXJhaWQvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMJMjAwNC0wMi0yMCAwMTozMjozNC4wMDAwMDAw
MDAgKzAxMDANCkBAIC00NTg3LDcgKzQ1ODcsNyBAQA0KIAlzdWJzeXN2aWQgPSBwZGV2LT5zdWJz
eXN0ZW1fdmVuZG9yOw0KIAlzdWJzeXNpZCA9IHBkZXYtPnN1YnN5c3RlbV9kZXZpY2U7DQogDQot
CXByaW50ayhLRVJOX05PVElDRSAibWVnYXJhaWQ6IGZvdW5kIDB4JTQuMDR4OjB4JTQuMDR4OmJ1
cyAlZDoiLA0KKwlwcmludGsoS0VSTl9OT1RJQ0UgIm1lZ2FyYWlkOiBub3RpZmllZCBvZiAweCU0
LjA0eDoweCU0LjA0eDpidXMgJWQ6IiwNCiAJCWlkLT52ZW5kb3IsIGlkLT5kZXZpY2UsIHBjaV9i
dXMpOw0KIA0KIAlwcmludGsoInNsb3QgJWQ6ZnVuYyAlZFxuIiwNCkBAIC00NjAyLDcgKzQ2MDIs
NyBAQA0KIAkJZmxhZyB8PSBCT0FSRF9NRU1NQVA7DQogDQogCQlpZiAoIXJlcXVlc3RfbWVtX3Jl
Z2lvbihtZWdhX2Jhc2Vwb3J0LCAxMjgsICJtZWdhcmFpZCIpKSB7DQotCQkJcHJpbnRrKEtFUk5f
V0FSTklORyAibWVnYXJhaWQ6IG1lbSByZWdpb24gYnVzeSFcbiIpOw0KKwkJCXByaW50ayhLRVJO
X1dBUk5JTkcgIm1lZ2FyYWlkOiBtZW0gcmVnaW9uIGJ1c3lcbiIpOw0KIAkJCWdvdG8gb3V0X2Rp
c2FibGVfZGV2aWNlOw0KIAkJfQ0KIA0KQEAgLTQ2MjksNyArNDYyOSw3IEBADQogCW1lbXNldChh
ZGFwdGVyLCAwLCBzaXplb2YoYWRhcHRlcl90KSk7DQogDQogCXByaW50ayhLRVJOX05PVElDRQ0K
LQkJInNjc2klZDpGb3VuZCBNZWdhUkFJRCBjb250cm9sbGVyIGF0IDB4JWx4LCBJUlE6JWRcbiIs
DQorCQkic2NzaSVkOiBmb3VuZCBNZWdhUkFJRCBjb250cm9sbGVyIGF0IDB4JWx4LCBJUlE6JWRc
biIsDQogCQlob3N0LT5ob3N0X25vLCBtZWdhX2Jhc2Vwb3J0LCBpcnEpOw0KIA0KIAlhZGFwdGVy
LT5iYXNlID0gbWVnYV9iYXNlcG9ydDsNCkBAIC00NjY1LDEzICs0NjY1LDEzIEBADQogCWFkYXB0
ZXItPm1lZ2FfYnVmZmVyID0gcGNpX2FsbG9jX2NvbnNpc3RlbnQoYWRhcHRlci0+ZGV2LA0KIAkJ
TUVHQV9CVUZGRVJfU0laRSwgJmFkYXB0ZXItPmJ1Zl9kbWFfaGFuZGxlKTsNCiAJaWYgKCFhZGFw
dGVyLT5tZWdhX2J1ZmZlcikgew0KLQkJcHJpbnRrKEtFUk5fV0FSTklORyAibWVnYXJhaWQ6IG91
dCBvZiBSQU0uXG4iKTsNCisJCXByaW50ayhLRVJOX1dBUk5JTkcgIm1lZ2FyYWlkOiBvdXQgb2Yg
UkFNXG4iKTsNCiAJCWdvdG8gb3V0X2hvc3RfcHV0Ow0KIAl9DQogDQogCWFkYXB0ZXItPnNjYl9s
aXN0ID0ga21hbGxvYyhzaXplb2Yoc2NiX3QpICogTUFYX0NPTU1BTkRTLCBHRlBfS0VSTkVMKTsN
CiAJaWYgKCFhZGFwdGVyLT5zY2JfbGlzdCkgew0KLQkJcHJpbnRrKEtFUk5fV0FSTklORyAibWVn
YXJhaWQ6IG91dCBvZiBSQU0uXG4iKTsNCisJCXByaW50ayhLRVJOX1dBUk5JTkcgIm1lZ2FyYWlk
OiBvdXQgb2YgUkFNXG4iKTsNCiAJCWdvdG8gb3V0X2ZyZWVfY21kX2J1ZmZlcjsNCiAJfQ0KIA0K
QEAgLTQ2NzksNyArNDY3OSw3IEBADQogCQkJCW1lZ2FyYWlkX2lzcl9tZW1tYXBwZWQgOiBtZWdh
cmFpZF9pc3JfaW9tYXBwZWQsDQogCQkJCQlTQV9TSElSUSwgIm1lZ2FyYWlkIiwgYWRhcHRlcikp
IHsNCiAJCXByaW50ayhLRVJOX1dBUk5JTkcNCi0JCQkibWVnYXJhaWQ6IENvdWxkbid0IHJlZ2lz
dGVyIElSUSAlZCFcbiIsIGlycSk7DQorCQkJIm1lZ2FyYWlkOiBjb3VsZG4ndCByZWdpc3RlciBJ
UlEgJWRcbiIsIGlycSk7DQogCQlnb3RvIG91dF9mcmVlX3NjYl9saXN0Ow0KIAl9DQogDQo=

--=-My4ZJefUDYqqgrb3+ZqJ--

--=-rzKbwm/vt8Gjs0/uZ4ev
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBANWwXtch0EvEFvxURAsEOAJ9FrIrIySrsuL2rnqYay6PhM1k8uQCbBAfl
/3bq8UljOBtKH6g6r/3Ug+U=
=aYxP
-----END PGP SIGNATURE-----

--=-rzKbwm/vt8Gjs0/uZ4ev--

