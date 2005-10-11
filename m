Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVJKWEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVJKWEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVJKWEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:04:40 -0400
Received: from fmr22.intel.com ([143.183.121.14]:38823 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750714AbVJKWEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:04:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5CEAF.A7A807ED"
Subject: [PATCH] vmx cpu feature detection
Date: Tue, 11 Oct 2005 15:03:47 -0700
Message-ID: <E305A4AFB7947540BC487567B5449BA80826746C@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] vmx cpu feature detection
thread-index: AcXOr6dVXAbnKMyQSW6pClznQEbejA==
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>
X-OriginalArrivalTime: 11 Oct 2005 22:04:13.0169 (UTC) FILETIME=[B6D13610:01C5CEAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5CEAF.A7A807ED
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew,
  The attached is the patch enabling detection of the VMX cpu feature.=20

# HG changeset patch
# User Nitin A Kamble <nitin.a.kamble@intel.com>
# Node ID 33c697a2e9a73dc02333d2a699569e9830adbe38
# Parent  85f12afa556a8e22cd6e963704f6abe7d0df3aeb
addition of "vmx" in the /proc/cpuinfo.

If VMX feature is available in the CPU, this patch will make it visible
in the /proc/cpuinfo with the cpuid detection.

Signed-Off-By: Nitin A Kamble <nitin.a.kamble@intel.com>

diff -r 85f12afa556a8e22cd6e963704f6abe7d0df3aeb -r
33c697a2e9a73dc02333d2a699569e9830adbe38 arch/i386/kernel/cpu/proc.c
--- a/arch/i386/kernel/cpu/proc.c	Mon Oct 10 17:39:26 2005
+++ b/arch/i386/kernel/cpu/proc.c	Tue Oct 11 20:19:37 2005
@@ -44,7 +44,7 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
=20
 		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL,
"est",
+		"pni", NULL, NULL, "monitor", "ds_cpl", "vmx", NULL,
"est",
 		"tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
diff -r 85f12afa556a8e22cd6e963704f6abe7d0df3aeb -r
33c697a2e9a73dc02333d2a699569e9830adbe38 arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c	Mon Oct 10 17:39:26 2005
+++ b/arch/x86_64/kernel/setup.c	Tue Oct 11 20:19:37 2005
@@ -1213,7 +1213,7 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
=20
 		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL,
"est",
+		"pni", NULL, NULL, "monitor", "ds_cpl", "vmx", NULL,
"est",
 		"tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,


Thanks & Regards,
Nitin
------------------------------------------------------------------------
-----------
Open Source Technology Center, Intel Corp


------_=_NextPart_001_01C5CEAF.A7A807ED
Content-Type: application/octet-stream;
	name="vmx_cpuid.patch"
Content-Transfer-Encoding: base64
Content-Description: vmx_cpuid.patch
Content-Disposition: attachment;
	filename="vmx_cpuid.patch"

RXhwb3J0aW5nIHBhdGNoOgojIEhHIGNoYW5nZXNldCBwYXRjaAojIFVzZXIgTml0aW4gQSBLYW1i
bGUgPG5pdGluLmEua2FtYmxlQGludGVsLmNvbT4KIyBOb2RlIElEIDMzYzY5N2EyZTlhNzNkYzAy
MzMzZDJhNjk5NTY5ZTk4MzBhZGJlMzgKIyBQYXJlbnQgIDg1ZjEyYWZhNTU2YThlMjJjZDZlOTYz
NzA0ZjZhYmU3ZDBkZjNhZWIKYWRkaXRpb24gb2YgInZteCIgaW4gdGhlIC9wcm9jL2NwdWluZm8u
CgpJZiBWTVggZmVhdHVyZSBpcyBhdmFpbGFibGUgaW4gdGhlIENQVSwgdGhpcyBwYXRjaCB3aWxs
IG1ha2UgaXQgdmlzaWJsZSBpbiB0aGUgL3Byb2MvY3B1aW5mbyB3aXRoIHRoZSBjcHVpZCBkZXRl
Y3Rpb24uCgpTaWduZWQtT2ZmLUJ5OiBOaXRpbiBBIEthbWJsZSA8bml0aW4uYS5rYW1ibGVAaW50
ZWwuY29tPgoKZGlmZiAtciA4NWYxMmFmYTU1NmE4ZTIyY2Q2ZTk2MzcwNGY2YWJlN2QwZGYzYWVi
IC1yIDMzYzY5N2EyZTlhNzNkYzAyMzMzZDJhNjk5NTY5ZTk4MzBhZGJlMzggYXJjaC9pMzg2L2tl
cm5lbC9jcHUvcHJvYy5jCi0tLSBhL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L3Byb2MuYwlNb24gT2N0
IDEwIDE3OjM5OjI2IDIwMDUKKysrIGIvYXJjaC9pMzg2L2tlcm5lbC9jcHUvcHJvYy5jCVR1ZSBP
Y3QgMTEgMjA6MTk6MzcgMjAwNQpAQCAtNDQsNyArNDQsNyBAQAogCQlOVUxMLCBOVUxMLCBOVUxM
LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMLAogCiAJCS8qIEludGVsLWRlZmluZWQgKCMy
KSAqLwotCQkicG5pIiwgTlVMTCwgTlVMTCwgIm1vbml0b3IiLCAiZHNfY3BsIiwgTlVMTCwgTlVM
TCwgImVzdCIsCisJCSJwbmkiLCBOVUxMLCBOVUxMLCAibW9uaXRvciIsICJkc19jcGwiLCAidm14
IiwgTlVMTCwgImVzdCIsCiAJCSJ0bTIiLCBOVUxMLCAiY2lkIiwgTlVMTCwgTlVMTCwgImN4MTYi
LCAieHRwciIsIE5VTEwsCiAJCU5VTEwsIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwsIE5V
TEwsIE5VTEwsCiAJCU5VTEwsIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwsIE5V
TEwsCmRpZmYgLXIgODVmMTJhZmE1NTZhOGUyMmNkNmU5NjM3MDRmNmFiZTdkMGRmM2FlYiAtciAz
M2M2OTdhMmU5YTczZGMwMjMzM2QyYTY5OTU2OWU5ODMwYWRiZTM4IGFyY2gveDg2XzY0L2tlcm5l
bC9zZXR1cC5jCi0tLSBhL2FyY2gveDg2XzY0L2tlcm5lbC9zZXR1cC5jCU1vbiBPY3QgMTAgMTc6
Mzk6MjYgMjAwNQorKysgYi9hcmNoL3g4Nl82NC9rZXJuZWwvc2V0dXAuYwlUdWUgT2N0IDExIDIw
OjE5OjM3IDIwMDUKQEAgLTEyMTMsNyArMTIxMyw3IEBACiAJCU5VTEwsIE5VTEwsIE5VTEwsIE5V
TEwsIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwsCiAKIAkJLyogSW50ZWwtZGVmaW5lZCAoIzIpICov
Ci0JCSJwbmkiLCBOVUxMLCBOVUxMLCAibW9uaXRvciIsICJkc19jcGwiLCBOVUxMLCBOVUxMLCAi
ZXN0IiwKKwkJInBuaSIsIE5VTEwsIE5VTEwsICJtb25pdG9yIiwgImRzX2NwbCIsICJ2bXgiLCBO
VUxMLCAiZXN0IiwKIAkJInRtMiIsIE5VTEwsICJjaWQiLCBOVUxMLCBOVUxMLCAiY3gxNiIsICJ4
dHByIiwgTlVMTCwKIAkJTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwg
TlVMTCwKIAkJTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwK

------_=_NextPart_001_01C5CEAF.A7A807ED--
