Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUHDQNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUHDQNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267331AbUHDQNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:13:15 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:49673 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267343AbUHDQHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:07:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C47A3D.1DC4DDCA"
Subject: RE: [PATCH] ppc32: fix mktree utility in 64-bit cross-compileenvironment
Date: Wed, 4 Aug 2004 11:07:17 -0500
Message-ID: <8C91B010B3B7994C88A266E1A72184D306E13AFA@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ppc32: fix mktree utility in 64-bit cross-compileenvironment
Thread-Index: AcR6OqGzsnNjPAaBRimF1y0xRoMFbQAAjreA
From: "Zink, Dan" <dan.zink@hp.com>
To: "Hollis Blanchard" <hollisb@us.ibm.com>
Cc: <akpm@osdl.org>, <linuxppc-dev@lists.linuxppc.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 16:07:39.0297 (UTC) FILETIME=[2A35A910:01C47A3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C47A3D.1DC4DDCA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> On Tue, 2004-08-03 at 17:01, Zink, Dan wrote:
> > --- arch/ppc/boot/utils/mktree.c.old	2004-08-03=20
> 16:31:09.568992888
> > -0500
> > +++ arch/ppc/boot/utils/mktree.c	2004-08-03 16:32:26.773256056
> > -0500
> > @@ -15,19 +15,20 @@
> >  #include <sys/stat.h>
> >  #include <unistd.h>
> >  #include <netinet/in.h>
> > +#include <asm/types.h>
>=20
> You'll notice we don't include any other <asm/*> headers;=20
> this tool can be built standalone.
>=20
> Is there a reason not to use <stdint.h> and uint32_t?
>=20

No reason.  If that's the way you prefer, here is a new patch.

Dan

------_=_NextPart_001_01C47A3D.1DC4DDCA
Content-Type: application/octet-stream;
	name="ppcfix.patch"
Content-Transfer-Encoding: base64
Content-Description: ppcfix.patch
Content-Disposition: attachment;
	filename="ppcfix.patch"

LS0tIGFyY2gvcHBjL2Jvb3QvdXRpbHMvbWt0cmVlLmMub2xkCTIwMDQtMDgtMDMgMTY6MzE6MDku
NTY4OTkyODg4IC0wNTAwCisrKyBhcmNoL3BwYy9ib290L3V0aWxzL21rdHJlZS5jCTIwMDQtMDgt
MDQgMTE6MDY6MzkuNzk5MDUxMzI4IC0wNTAwCkBAIC0xNSwxOSArMTUsMjAgQEAKICNpbmNsdWRl
IDxzeXMvc3RhdC5oPgogI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPG5ldGluZXQvaW4u
aD4KKyNpbmNsdWRlIDxzdGRpbnQuaD4KIAogLyogVGhpcyBnZXRzIHRhY2tlZCBvbiB0aGUgZnJv
bnQgb2YgdGhlIGltYWdlLiAgVGhlcmUgYXJlIGFsc28gYSBmZXcKICAqIGJ5dGVzIGFsbG9jYXRl
ZCBhZnRlciB0aGUgX3N0YXJ0IGxhYmVsIHVzZWQgYnkgdGhlIGJvb3Qgcm9tIChzZWUKICAqIGhl
YWQuUyBmb3IgZGV0YWlscykuCiAgKi8KIHR5cGVkZWYgc3RydWN0IGJvb3RfYmxvY2sgewotCXVu
c2lnbmVkIGxvbmcgYmJfbWFnaWM7CQkvKiAweDAwNTI1MDRGICovCi0JdW5zaWduZWQgbG9uZyBi
Yl9kZXN0OwkJLyogVGFyZ2V0IGFkZHJlc3Mgb2YgdGhlIGltYWdlICovCi0JdW5zaWduZWQgbG9u
ZyBiYl9udW1fNTEyYmxvY2tzOwkvKiBTaXplLCByb3VuZGVkLXVwLCBpbiA1MTIgYnl0ZSBibGtz
ICovCi0JdW5zaWduZWQgbG9uZyBiYl9kZWJ1Z19mbGFnOwkvKiBSdW4gZGVidWdnZXIgb3IgaW1h
Z2UgYWZ0ZXIgbG9hZCAqLwotCXVuc2lnbmVkIGxvbmcgYmJfZW50cnlfcG9pbnQ7CS8qIFRoZSBp
bWFnZSBhZGRyZXNzIHRvIHN0YXJ0ICovCi0JdW5zaWduZWQgbG9uZyBiYl9jaGVja3N1bTsJLyog
MzIgYml0IGNoZWNrc3VtIGluY2x1ZGluZyBoZWFkZXIgKi8KLQl1bnNpZ25lZCBsb25nIHJlc2Vy
dmVkWzJdOworCXVpbnQzMl90IGJiX21hZ2ljOwkJLyogMHgwMDUyNTA0RiAqLworCXVpbnQzMl90
IGJiX2Rlc3Q7CQkvKiBUYXJnZXQgYWRkcmVzcyBvZiB0aGUgaW1hZ2UgKi8KKwl1aW50MzJfdCBi
Yl9udW1fNTEyYmxvY2tzOwkvKiBTaXplLCByb3VuZGVkLXVwLCBpbiA1MTIgYnl0ZSBibGtzICov
CisJdWludDMyX3QgYmJfZGVidWdfZmxhZzsJLyogUnVuIGRlYnVnZ2VyIG9yIGltYWdlIGFmdGVy
IGxvYWQgKi8KKwl1aW50MzJfdCBiYl9lbnRyeV9wb2ludDsJLyogVGhlIGltYWdlIGFkZHJlc3Mg
dG8gc3RhcnQgKi8KKwl1aW50MzJfdCBiYl9jaGVja3N1bTsJLyogMzIgYml0IGNoZWNrc3VtIGlu
Y2x1ZGluZyBoZWFkZXIgKi8KKwl1aW50MzJfdCByZXNlcnZlZFsyXTsKIH0gYm9vdF9ibG9ja190
OwogCiAjZGVmaW5lIElNR0JMSwk1MTIK

------_=_NextPart_001_01C47A3D.1DC4DDCA--
