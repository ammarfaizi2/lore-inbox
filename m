Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266815AbUBRAvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267000AbUBRAva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:51:30 -0500
Received: from fmr06.intel.com ([134.134.136.7]:20139 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266815AbUBRAp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:45:57 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3F5B8.8AF40FFC"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Limit hash table size
Date: Tue, 17 Feb 2004 16:45:45 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB501F2AAE1@scsmsx401.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Limit hash table size
Thread-Index: AcP1rPz/B4fpIreiS+yKtuVaKwtRRAAA7bRgAAHkacA=
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 18 Feb 2004 00:45:46.0675 (UTC) FILETIME=[8BEB5830:01C3F5B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3F5B8.8AF40FFC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Updates to Documentation/kernel-parameters.txt for the 4 new boot time
parameters.

- Ken


-----Original Message-----
From: Chen, Kenneth W=20
Sent: Tuesday, February 17, 2004 4:17 PM
To: 'Andrew Morton'
Cc: linux-kernel@vger.kernel.org; linux-ia64@vger.kernel.org
Subject: RE: Limit hash table size

> I think it would be better to leave things as they are,
> with a boot option to scale the tables down.

OK, here is one that adds boot time parameters only and leave everything
else untouched.

> The below patch addresses the inode and dentry caches.
> Need to think a bit more about the networking ones.

Don't know what happened to my mailer, the mailing list archive shows
complete patch including the network part.  Hope this time you receive
the whole thing.

------_=_NextPart_001_01C3F5B8.8AF40FFC
Content-Type: application/octet-stream;
	name="knl_param.patch"
Content-Transfer-Encoding: base64
Content-Description: knl_param.patch
Content-Disposition: attachment;
	filename="knl_param.patch"

ZGlmZiAtTnVyIGxpbnV4LTIuNi4zLXJjNC9Eb2N1bWVudGF0aW9uL2tlcm5lbC1wYXJhbWV0ZXJz
LnR4dCBsaW51eC0yLjYuMy1yYzQuaGFzaC9Eb2N1bWVudGF0aW9uL2tlcm5lbC1wYXJhbWV0ZXJz
LnR4dAotLS0gbGludXgtMi42LjMtcmM0L0RvY3VtZW50YXRpb24va2VybmVsLXBhcmFtZXRlcnMu
dHh0CTIwMDQtMDItMTYgMTg6MjM6NDQuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjYuMy1y
YzQuaGFzaC9Eb2N1bWVudGF0aW9uL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAkyMDA0LTAyLTE3IDE2
OjQxOjU4LjAwMDAwMDAwMCAtMDgwMApAQCAtMjkyLDYgKzI5Miw5IEBACiAKIAlkZXZmcz0JCVtE
RVZGU10KIAkJCVNlZSBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2RldmZzL2Jvb3Qtb3B0aW9u
cy4KKworCWRoYXNoX2VudHJpZXM9CVtLTkxdCisJCQlTZXQgbnVtYmVyIG9mIGhhc2ggYnVja2V0
cyBmb3IgZGVudHJ5IGNhY2hlLgogIAogCWRpZ2k9CQlbSFcsU0VSSUFMXQogCQkJSU8gcGFyYW1l
dGVycyArIGVuYWJsZS9kaXNhYmxlIGNvbW1hbmQuCkBAIC00MjQsNiArNDI3LDkgQEAKIAlpZGxl
PQkJW0hXXQogCQkJRm9ybWF0OiBpZGxlPXBvbGwgb3IgaWRsZT1oYWx0CiAgCisJaWhhc2hfZW50
cmllcz0JW0tOTF0KKwkJCVNldCBudW1iZXIgb2YgaGFzaCBidWNrZXRzIGZvciBpbm9kZSBjYWNo
ZS4KKwogCWluMjAwMD0JCVtIVyxTQ1NJXQogCQkJU2VlIGhlYWRlciBvZiBkcml2ZXJzL3Njc2kv
aW4yMDAwLmMuCiAKQEAgLTg3Myw2ICs4NzksOSBAQAogCiAJcmVzdW1lPQkJW1NXU1VTUF0gU3Bl
Y2lmeSB0aGUgcGFydGl0aW9uIGRldmljZSBmb3Igc29mdHdhcmUgc3VzcGVuc2lvbgogCisJcmhh
c2hfZW50cmllcz0JW0tOTCxORVRdCisJCQlTZXQgbnVtYmVyIG9mIGhhc2ggYnVja2V0cyBmb3Ig
cm91dGUgY2FjaGUKKyAKIAlyaXNjb204PQlbSFcsU0VSSUFMXQogCQkJRm9ybWF0OiA8aW9fYm9h
cmQxPlssPGlvX2JvYXJkMj5bLC4uLjxpb19ib2FyZE4+XV0KIApAQCAtMTEzNSw2ICsxMTQ0LDkg
QEAKIAl0Z2Z4XzI9CQlTZWUgRG9jdW1lbnRhdGlvbi9pbnB1dC9qb3lzdGljay1wYXJwb3J0LnR4
dC4KIAl0Z2Z4XzM9CiAKKwl0aGFzaF9lbnRyaWVzPQlbS05MLE5FVF0KKwkJCVNldCBudW1iZXIg
b2YgaGFzaCBidWNrZXRzIGZvciBUQ1AgY29ubmVjdGlvbgorCiAJdGlwYXI9CQlbSFddCiAJCQlT
ZWUgaGVhZGVyIG9mIGRyaXZlcnMvY2hhci90aXBhci5jLgogCg==

------_=_NextPart_001_01C3F5B8.8AF40FFC--
