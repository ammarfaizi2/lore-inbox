Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUHEWOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUHEWOi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267900AbUHEWMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:12:37 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:24585 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S268003AbUHEWGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:06:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C47B38.74B70D1B"
Subject: RE: [PATCH 2.6.8-rc2] sata_nv.c
Date: Thu, 5 Aug 2004 15:06:27 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F9623@hqemmail02.nvidia.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.8-rc2] sata_nv.c
Thread-Index: AcR7NtVe4DdfDUL8QGS+Sfg6gqYWVgAAPcbw
From: "Andrew Chew" <achew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
X-OriginalArrivalTime: 05 Aug 2004 22:06:28.0208 (UTC) FILETIME=[74DA8700:01C47B38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C47B38.74B70D1B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Andrew Chew wrote:
> > A minor change to libata-core.c needs to accompany this=20
> patch.  This=20
> > is in regards to the function ata_pci_remove_one(), where the
> > host_set->ops->host_stop(host_set) needs to occur before the=20
> > iounmap(host_set->mmio_base).  This is because sata_nv's host_stop=20
> > callback needs access to the iomapped region.

Jeff Garzik wrote:
> Do you want to send a separate patch for this?  I don't see=20
> that change=20
> in the attached patch.

Attached patch.

------_=_NextPart_001_01C47B38.74B70D1B
Content-Type: application/octet-stream;
	name="libata-core_2-6.diff"
Content-Transfer-Encoding: base64
Content-Description: libata-core_2-6.diff
Content-Disposition: attachment;
	filename="libata-core_2-6.diff"

LS0tIGxpbnV4LTIuNi44LXJjMi9kcml2ZXJzL3Njc2kvbGliYXRhLWNvcmUuYwkyMDA0LTA4LTA1
IDE0OjE3OjMwLjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgvZHJpdmVycy9zY3NpL2xpYmF0YS1j
b3JlLmMJMjAwNC0wNy0yNyAxNDo0MjowNi4wMDAwMDAwMDAgLTA3MDAKQEAgLTMyNTEsMTAgKzMy
NTEsMTAgQEAKIAl9CiAKIAlmcmVlX2lycShob3N0X3NldC0+aXJxLCBob3N0X3NldCk7Ci0JaWYg
KGhvc3Rfc2V0LT5tbWlvX2Jhc2UpCi0JCWlvdW5tYXAoaG9zdF9zZXQtPm1taW9fYmFzZSk7CiAJ
aWYgKGhvc3Rfc2V0LT5vcHMtPmhvc3Rfc3RvcCkKIAkJaG9zdF9zZXQtPm9wcy0+aG9zdF9zdG9w
KGhvc3Rfc2V0KTsKKwlpZiAoaG9zdF9zZXQtPm1taW9fYmFzZSkKKwkJaW91bm1hcChob3N0X3Nl
dC0+bW1pb19iYXNlKTsKIAogCWZvciAoaSA9IDA7IGkgPCBob3N0X3NldC0+bl9wb3J0czsgaSsr
KSB7CiAJCWFwID0gaG9zdF9zZXQtPnBvcnRzW2ldOwo=

------_=_NextPart_001_01C47B38.74B70D1B--
