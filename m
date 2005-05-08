Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVEHBL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVEHBL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 21:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVEHBL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 21:11:26 -0400
Received: from fmr20.intel.com ([134.134.136.19]:61654 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262775AbVEHBLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 21:11:22 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5536A.D7A3A4E6"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: [patch] ide proc destroy error
Date: Sun, 8 May 2005 09:06:35 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E8402053E29@pdsmsx404>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] ide proc destroy error
Thread-Index: AcVTai4pGT7/m/zUSL62T7vc/b+X/w==
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 May 2005 01:11:20.0186 (UTC) FILETIME=[D7C94DA0:01C5536A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5536A.D7A3A4E6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Kernel 2.6 has an ide proc destroy error. Run #modprobe ide-core and
#rmmod ide-core, then kernel will dump stack information like below.

Here is the patch against 2.6.12-rc3.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>


**********Log******************
Badness in remove_proc_entry at fs/proc/generic.c:693

Call Trace:
 [<a0000001000117e0>] show_stack+0x80/0xa0
                                sp=3De0000003e05dfbe0 =
bsp=3De0000003e05d0ea8
 [<a0000001000120b0>] dump_stack+0x30/0x60
                                sp=3De0000003e05dfdb0 =
bsp=3De0000003e05d0e90
 [<a000000100183090>] remove_proc_entry+0x530/0x540
                                sp=3De0000003e05dfdb0 =
bsp=3De0000003e05d0e20
 [<a000000221cbd280>] proc_ide_destroy+0x120/0x140 [ide_core]
                                sp=3De0000003e05dfdc0 =
bsp=3De0000003e05d0df0
 [<a000000221ca65f0>] cleanup_module+0x50/0xa0 [ide_core]
                                sp=3De0000003e05dfdc0 =
bsp=3De0000003e05d0dd0
 [<a0000001000a9e10>] sys_delete_module+0x390/0x580
                                sp=3De0000003e05dfdc0 =
bsp=3De0000003e05d0d50
 [<a00000010000af40>] ia64_ret_from_syscall+0x0/0x20
                                sp=3De0000003e05dfe30 =
bsp=3De0000003e05d0d50
 [<a000000000010640>] _stext+0xffffffff00010640/0x400
                                sp=3De0000003e05e0000 =
bsp=3De0000003e05d0d50

 <<ide_proc_error_2.6.12_rc3.patch>>=20

------_=_NextPart_001_01C5536A.D7A3A4E6
Content-Type: application/octet-stream;
	name="ide_proc_error_2.6.12_rc3.patch"
Content-Transfer-Encoding: base64
Content-Description: ide_proc_error_2.6.12_rc3.patch
Content-Disposition: attachment;
	filename="ide_proc_error_2.6.12_rc3.patch"

ZGlmZiAtTnJhdXAgbGludXgtMi42LjEyLXJjMy9kcml2ZXJzL2lkZS9pZGUtcHJvYy5jIGxpbnV4
LTIuNi4xMi1yYzNfZml4L2RyaXZlcnMvaWRlL2lkZS1wcm9jLmMKLS0tIGxpbnV4LTIuNi4xMi1y
YzMvZHJpdmVycy9pZGUvaWRlLXByb2MuYwkyMDA1LTA0LTIxIDA5OjI0OjU2LjAwMDAwMDAwMCAt
MDcwMAorKysgbGludXgtMi42LjEyLXJjM19maXgvZHJpdmVycy9pZGUvaWRlLXByb2MuYwkyMDA1
LTA0LTMwIDAzOjAyOjM1LjAwMDAwMDAwMCAtMDcwMApAQCAtNTE2LDYgKzUxNiw2IEBAIHZvaWQg
cHJvY19pZGVfY3JlYXRlKHZvaWQpCiAKIHZvaWQgcHJvY19pZGVfZGVzdHJveSh2b2lkKQogewot
CXJlbW92ZV9wcm9jX2VudHJ5KCJpZGUvZHJpdmVycyIsIHByb2NfaWRlX3Jvb3QpOworCXJlbW92
ZV9wcm9jX2VudHJ5KCJkcml2ZXJzIiwgcHJvY19pZGVfcm9vdCk7CiAJcmVtb3ZlX3Byb2NfZW50
cnkoImlkZSIsIE5VTEwpOwogfQo=

------_=_NextPart_001_01C5536A.D7A3A4E6--
