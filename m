Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267314AbRGTUSs>; Fri, 20 Jul 2001 16:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267317AbRGTUSi>; Fri, 20 Jul 2001 16:18:38 -0400
Received: from [24.229.53.66] ([24.229.53.66]:45348 "HELO
	bbserver1.backbonesecurity.com") by vger.kernel.org with SMTP
	id <S267314AbRGTUSU>; Fri, 20 Jul 2001 16:18:20 -0400
Subject: RE: Simple LKM & copy_from_user question (followup)
Date: Fri, 20 Jul 2001 16:26:43 -0400
Message-ID: <94FD5825A793194CBF039E6673E9AFE00B64A0@bbserver1.backbonesecurity.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C1115A.4A8AC0D0"
Thread-Topic: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
Thread-Index: AcERMy0/oD0x/32uQPW6VtNUB8F6cQAABV3gAAjkUCA=
content-class: urn:content-classes:message
From: "David CM Weber" <dweber@backbonesecurity.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.

------_=_NextPart_001_01C1115A.4A8AC0D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Attached is the file I"m having problems with.  I'm compiling it w/=20

gcc -O3 -c main.c

Thanks in advance,


Dave Weber
Backbone Security, Inc.
570-422-7900





> -----Original Message-----
> From: David CM Weber=20
> Sent: Friday, July 20, 2001 12:45 PM
> To: linux-kernel@vger.kernel.org
> Subject: Simple LKM & copy_from_user question
>=20
>=20
> Hello all.  I've been lurking for a while, and I have a quick=20
> question.
> I'm in the process of writing my first LKM to mess with the
> sys_socketcall function.  I'm looking at the original one for=20
> guidance,
> and it makes a call to copy_from_user() to get some=20
> socket-related data.
>=20
> So, to use copy_from_user(), I've gathered that I need to #include
> <asm/uaccess.h>, so I do so. =20
>=20
> After including this file, I'm getting the following errors:
>=20
>=20
> .../linux/timer.h:21: field 'vec' has incomplete type
>=20
> .../asm/uaccess.h::63: dereferencing pointer to incomplete type
>=20
>=20
> (This is not a full list of the error message that it's reporting)
>=20
> Am I not setting a define correctly?=20
>=20
> I'm using Redhat 7.1, on an Intel P3 system.  It's the latest stable
> release (2.4.x ??) of the kernel.
>=20
>=20
>=20
> If you need more information, please let me know.  This has been
> troubling me for several days now..
>=20
>=20
> Thanks,
>=20
>=20
> Dave Weber
> Backbone Security, Inc.
> 570-422-7900
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

------_=_NextPart_001_01C1115A.4A8AC0D0
Content-Type: application/octet-stream;
	name="main.c"
Content-Transfer-Encoding: base64
Content-Description: main.c
Content-Disposition: attachment;
	filename="main.c"

I2RlZmluZSBNT0RVTEUgLy8gdGhpcyBpcyBhIExLTQojaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
IC8vIGZvciBNb2R1bGUgYWNjZXNzCi8vI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPiAvLyBGb3Ig
a2VybmVsIGFjY2VzcwojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4gLy8gZm9yIHRoZSBTWVNfc29j
a2V0Y2FsbCB2YWx1ZQoKI2luY2x1ZGUgPGxpbnV4L25ldC5oPiAvLyBGb3IgdGhlIHZhcmlvdXMg
c3lzX3NvY2tldGNhbGwgcGFyYW1ldGVycwovLyNpbmNsdWRlIDxhc20vdW5pc3RkLmg+CiNpbmNs
dWRlIDxhc20vZXJybm8uaD4gLy8gRm9yIHRoZSBlcnJvciByZXR1cm4gdmFsdWVzCiNpbmNsdWRl
IDxhc20vdWFjY2Vzcy5oPiAvLyBmb3IgY29weV9mcm9tX3VzZXIKCgoKLy8gRGVmaW5lIGEgZGVi
dWcgcHJpbnQgc3RhdGVtZW50CiNkZWZpbmUgQkJQUklOVChhKSBwcmludGsoIiVzKCVpKTogJXNc
biIsIF9fRklMRV9fLCBfX0xJTkVfXywgYSkKIAovLyBUeXBlIGRlZmluZSBhIGJ5dGUgLT4gdW5z
aWduZWQgY2hhcgp0eXBlZGVmIHVuc2lnbmVkIGNoYXIgYnl0ZTsKCi8vIE91ciBmcmllbmRseSBu
ZWlnaGJvcmhvb2Qgc3lzdGVtIGNhbGwgdGFibGUKZXh0ZXJuIHZvaWQqIHN5c19jYWxsX3RhYmxl
W107CgovLyBUYWtlbiBmcm9tIHNvY2tldC5jCi8vIEFyZ3VtZW50IGxpc3Qgc2l6ZXMgZm9yIHN5
c19zb2NrZXRjYWxsCiNkZWZpbmUgQUwoeCkgKCh4KSAqIHNpemVvZih1bnNpZ25lZCBsb25nKSkK
c3RhdGljIHVuc2lnbmVkIGNoYXIgbmFyZ3NbMThdPXtBTCgwKSxBTCgzKSxBTCgzKSxBTCgzKSxB
TCgyKSxBTCgzKSwKCQkJCUFMKDMpLEFMKDMpLEFMKDQpLEFMKDQpLEFMKDQpLEFMKDYpLAoJCQkJ
QUwoNiksQUwoMiksQUwoNSksQUwoNSksQUwoMyksQUwoMyl9OwoKCi8vIENyZWF0ZSBvdXIgb3Jn
aW5hbCBmdW5jdGlvbiBwb2ludGVyCmludCAoKm9yaWdpbmFsX3NvY2tldGNhbGwpKGludCBjYWxs
LCB1bnNpZ25lZCBsb25nICphcmdzKTsKCi8vIE91ciBmdW5jdGlvbidzIGFkdmFuY2UgZGVjbGFy
YXRpb24KaW50IG15X3NvY2tldGNhbGwoaW50IGNhbGwsIHVuc2lnbmVkIGxvbmcgKmFyZ3MpOwoK
aW50IGluaXRfbW9kdWxlKHZvaWQpCnsKCUJCUFJJTlQoIkxvYWRpbmcgU29ja2V0IExLTSIpOwoK
CS8vIFNhdmUgdGhlIG9yaWdpbmFsIGxvY2F0aW9uCQoJb3JpZ2luYWxfc29ja2V0Y2FsbCA9IHN5
c19jYWxsX3RhYmxlW1NZU19zb2NrZXRjYWxsXTsKCgkvLyBSZXBsYWNlIHRoZSB0YWJsZSBlbnRy
eSB3aXRoIG91ciBzb2NrZXRjYWxsCglzeXNfY2FsbF90YWJsZVtTWVNfc29ja2V0Y2FsbF0gPSBt
eV9zb2NrZXRjYWxsOyAKCglyZXR1cm4gMDsKfQoKLy8gVGhpcyBpcyBydW4gd2hlbiB0aGUgbW9k
dWxlIGlzIHVubG9hZGVkCnZvaWQgY2xlYW51cF9tb2R1bGUodm9pZCkKewoJLy9HbyBiYWNrIHRv
IHRoZSBvcmlnbmFsIHNvY2tldGNhbGwKCXN5c19jYWxsX3RhYmxlW1NZU19zb2NrZXRjYWxsXSA9
IG9yaWdpbmFsX3NvY2tldGNhbGw7CgoJQkJQUklOVCgiVW5sb2FkaW5nIFNvY2tldCBMS00iKTsK
fQoKCmludCBteV9zb2NrZXRjYWxsKGludCBjYWxsLCB1bnNpZ25lZCBsb25nICphcmdzKQp7Cgl1
bnNpZ25lZCBsb25nIGFbNl07Cgl1bnNpZ25lZCBsb25nIGEwLGExOwoKCWludCBlcnI7CgoJaWYo
Y2FsbCA8IDEgfHwgY2FsbCA+IFNZU19SRUNWTVNHKQoJCXJldHVybiAtRUlOVkFMOwoKCS8vIGNv
cHlfZnJvbV91c2VyIHNob3VsZCBiZSBTTVAgc2FmZS4KCWlmIChjb3B5X2Zyb21fdXNlcihhLCBh
cmdzLCBuYXJnc1tjYWxsXSkpCgkJcmV0dXJuIC1FRkFVTFQ7CgkJCglhMD1hWzBdOwoJYTE9YVsx
XTsKCgoJLy8gQ2FsbCB0aGUgb3JpZ2luYWwgZnVuY3Rpb24KCXJldHVybihvcmlnaW5hbF9zb2Nr
ZXRjYWxsKGNhbGwsIGFyZ3MpKTsKfQo=

------_=_NextPart_001_01C1115A.4A8AC0D0--
