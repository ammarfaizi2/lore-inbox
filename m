Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbULJCWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbULJCWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 21:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbULJCWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 21:22:13 -0500
Received: from fmr18.intel.com ([134.134.136.17]:2970 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261651AbULJCWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 21:22:08 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4DE5F.0687DF92"
Subject: [Patch]Memory leak in sysfs
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 10 Dec 2004 10:21:58 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013CA02@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch]Memory leak in sysfs
Thread-Index: AcTeXwYz1BCLnBccTlKLu+GwWRdZKg==
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>
X-OriginalArrivalTime: 10 Dec 2004 02:21:59.0218 (UTC) FILETIME=[06E58120:01C4DE5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4DE5F.0687DF92
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Some stress testes show there is a memory leak in the latest kernel.
I found the memory leak is in sysfs.
Here is a patch against 2.6.10-rc2-mm4 to fix that.

Signed-off-by: Zou Nan hai <Nanhai.Zou@intel.com>

------_=_NextPart_001_01C4DE5F.0687DF92
Content-Type: application/octet-stream;
	name="sysfs-memleak-fix.patch"
Content-Transfer-Encoding: base64
Content-Description: sysfs-memleak-fix.patch
Content-Disposition: attachment;
	filename="sysfs-memleak-fix.patch"

ZGlmZiAtTnJhdXAgYS9mcy9zeXNmcy9kaXIuYyBiL2ZzL3N5c2ZzL2Rpci5jCi0tLSBhL2ZzL3N5
c2ZzL2Rpci5jCTIwMDQtMTItMDYgMTM6MDQ6NTYuMDAwMDAwMDAwICswODAwCisrKyBiL2ZzL3N5
c2ZzL2Rpci5jCTIwMDQtMTItMDcgMTY6NDk6MzYuMDAwMDAwMDAwICswODAwCkBAIC0zNDksNiAr
MzQ5LDcgQEAgc3RhdGljIGludCBzeXNmc19kaXJfY2xvc2Uoc3RydWN0IGlub2RlIAogCiAJZG93
bigmZGVudHJ5LT5kX2lub2RlLT5pX3NlbSk7CiAJbGlzdF9kZWxfaW5pdCgmY3Vyc29yLT5zX3Np
YmxpbmcpOworCXN5c2ZzX3B1dChjdXJzb3IpOwogCXVwKCZkZW50cnktPmRfaW5vZGUtPmlfc2Vt
KTsKIAogCXJldHVybiAwOwo=

------_=_NextPart_001_01C4DE5F.0687DF92--
