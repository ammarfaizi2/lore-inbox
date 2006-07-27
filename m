Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWG0P0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWG0P0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWG0P0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:26:45 -0400
Received: from mail.ccur.com ([66.10.65.12]:63911 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S932561AbWG0P0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:26:44 -0400
Subject: [PATCH] documentation: Documentation/initrd.txt
From: Tom Horsley <tom.horsley@ccur.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-Jeu4XbmCaw/9IIhEI5fE"
Date: Thu, 27 Jul 2006 11:26:43 -0400
Message-Id: <1154014003.5166.30.camel@tweety>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jeu4XbmCaw/9IIhEI5fE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

From: Thomas Horsley <tom.horsley@ccur.com>

I spent a long time the other day trying to examine an initrd
image on a fedora core 5 system because the initrd.txt file
is apparently obsolete. Here is a patch which I hope
will reduce future confusion for others.

Signed-off-by: Thomas Horsley <tom.horsley@ccur.com>

---

I'm resubmitting this according to the SubmittingPatches
guidelines. This was made from the 2.6.17.7 tree, but
I don't think initrd.txt has changed much in any of the
trees. I know I'm not supposed to send an attachment, but
I see evolution has already screwed up my cut and paste
attempt and who knows what will happen by the time it
goes through exchange, so I'm adding the patch as an
attachment as well.

--- Documentation/initrd.txt	2006-07-27 08:49:30.000000000 -0400
+++ Documentation/initrd.txt	2006-07-27 09:02:04.000000000 -0400
@@ -73,6 +73,22 @@
     initrd is mounted as root, and the normal boot procedure is
followed,
     with the RAM disk still mounted as root.
 
+Compressed cpio images
+----------------------
+
+Recent kernels have support for populating a ramdisk from a compressed
cpio
+archive, on such systems, the creation of a ramdisk image doesn't need
to
+involve special block devices or loopbacks, you merely create a
directory on
+disk with the desired initrd content, cd to that directory, and run (as
an
+example):
+
+find . | cpio --quiet -c -o | gzip -9 -n > /boot/imagefile.img
+
+Examining the contents of an existing image file is just as simple:
+
+mkdir /tmp/imagefile
+cd /tmp/imagefile
+gzip -cd /boot/imagefile.img | cpio -imd --quiet
 
 Installation
 ------------


--=-Jeu4XbmCaw/9IIhEI5fE
Content-Disposition: attachment; filename=initrd-doc-patch
Content-Type: text/plain; name=initrd-doc-patch; charset=us-ascii
Content-Transfer-Encoding: base64

LS0tIERvY3VtZW50YXRpb24vaW5pdHJkLnR4dAkyMDA2LTA3LTI3IDA4OjQ5OjMwLjAwMDAwMDAw
MCAtMDQwMA0KKysrIERvY3VtZW50YXRpb24vaW5pdHJkLnR4dAkyMDA2LTA3LTI3IDA5OjAyOjA0
LjAwMDAwMDAwMCAtMDQwMA0KQEAgLTczLDYgKzczLDIyIEBADQogICAgIGluaXRyZCBpcyBtb3Vu
dGVkIGFzIHJvb3QsIGFuZCB0aGUgbm9ybWFsIGJvb3QgcHJvY2VkdXJlIGlzIGZvbGxvd2VkLA0K
ICAgICB3aXRoIHRoZSBSQU0gZGlzayBzdGlsbCBtb3VudGVkIGFzIHJvb3QuDQogDQorQ29tcHJl
c3NlZCBjcGlvIGltYWdlcw0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCisNCitSZWNlbnQga2Vy
bmVscyBoYXZlIHN1cHBvcnQgZm9yIHBvcHVsYXRpbmcgYSByYW1kaXNrIGZyb20gYSBjb21wcmVz
c2VkIGNwaW8NCithcmNoaXZlLCBvbiBzdWNoIHN5c3RlbXMsIHRoZSBjcmVhdGlvbiBvZiBhIHJh
bWRpc2sgaW1hZ2UgZG9lc24ndCBuZWVkIHRvDQoraW52b2x2ZSBzcGVjaWFsIGJsb2NrIGRldmlj
ZXMgb3IgbG9vcGJhY2tzLCB5b3UgbWVyZWx5IGNyZWF0ZSBhIGRpcmVjdG9yeSBvbg0KK2Rpc2sg
d2l0aCB0aGUgZGVzaXJlZCBpbml0cmQgY29udGVudCwgY2QgdG8gdGhhdCBkaXJlY3RvcnksIGFu
ZCBydW4gKGFzIGFuDQorZXhhbXBsZSk6DQorDQorZmluZCAuIHwgY3BpbyAtLXF1aWV0IC1jIC1v
IHwgZ3ppcCAtOSAtbiA+IC9ib290L2ltYWdlZmlsZS5pbWcNCisNCitFeGFtaW5pbmcgdGhlIGNv
bnRlbnRzIG9mIGFuIGV4aXN0aW5nIGltYWdlIGZpbGUgaXMganVzdCBhcyBzaW1wbGU6DQorDQor
bWtkaXIgL3RtcC9pbWFnZWZpbGUNCitjZCAvdG1wL2ltYWdlZmlsZQ0KK2d6aXAgLWNkIC9ib290
L2ltYWdlZmlsZS5pbWcgfCBjcGlvIC1pbWQgLS1xdWlldA0KIA0KIEluc3RhbGxhdGlvbg0KIC0t
LS0tLS0tLS0tLQ0K


--=-Jeu4XbmCaw/9IIhEI5fE--
