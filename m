Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUCZVZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbUCZVX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:23:57 -0500
Received: from 228.17.30.61.isp.tfn.net.tw ([61.30.17.228]:23672 "EHLO
	cm-msg-02.cmedia.com.tw") by vger.kernel.org with ESMTP
	id S261317AbUCZVXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:23:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C41378.88FB1758"
Subject: RE: cmpci 6.64 released
Date: Sat, 27 Mar 2004 05:23:08 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D3F7@cm-msg-02.cmedia.com.tw>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: cmpci.c
Thread-Index: AcPoPln518nTM2OeR7+CNxqaVKXWNQn7zVPjANKiOec=
From: =?big5?B?Qy5MLiBUaWVuIC0gpdCp08Kn?= <cltien@cmedia.com.tw>
To: <linux-kernel@vger.kernel.org>, <linux-audio-dev@music.columbia.edu>
Cc: =?big5?B?pqyrSLhzstUtuvSttiBTdXBwb3J0IKtIvWM=?= 
	<support@cmedia.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C41378.88FB1758
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable


Hi,

I update the 46.diff, which is used to patch cmpci.c to support kernel =
2.6.

The synchronize_irq() has one parameter in kernel 2.6 and none in kernel =
2.4, however, it still compile well on a i386 kernel 2.6, I discover it =
on an IA64 system.

Sincerely,
ChenLi Tien

-----Original Message-----
From:	C.L. Tien - =A5=D0=A9=D3=C2=A7
Sent:	2004/3/22 [=ACP=B4=C1=A4@] =A4U=A4=C8 12:24
To:	linux-kernel@vger.kernel.org; linux-audio-dev@music.columbia.edu
Cc:	=A6=AC=ABH=B8s=B2=D5-=BA=F4=AD=B6 Support =ABH=BDc
Subject:	ANN: cmpci 6.64 released
Hi,

I made many changes for cmpci.c since last release. Changes are made as =
follows:

1. Fix the S/PDIF out programming bug appeared in 6.16.
2. Support 8338 4-channel playback.
3. S/PDIF loop can be used after AC3 playback.

4. Legacy devices (FM, MPU401 and gameport) are served by other modules.
   Now the code is thinner.
5. Remove parameters setting from kernel configure menu, they can be
   set easily when loading the module.
6. Add spdif_out to output 44.1K/48K 16-bit stereo to S/PDIF out.
7. Add hw_copy to duplicate audio of front speakers to surround =
speakers.
8. Change code to minimum patch for kernel 2.6.

The attached cmpci.c in cmpci-6.64.tar.bz2 is the updated driver, and =
46.diff is the patch file that needed for kernel 2.6.

The cmpci-patch-2.4.25.tar.bz2 and cmpci-patch-2.6.4.tar.bz2 are patches =
for kernel 2.4.25/2.6.4 tree patch, they are needed to support legacy =
devices, otherwise you may ignore them.

The cmi8738.tar.bz2 contains CMI8738, which is modified from CMI8338. It =
describe the parameters cmi8738 can support.

Please feedback if you have any question, I will post to kernel =
maintaner if no serious problem with it.

Sincerely,
ChenLi Tien






------_=_NextPart_001_01C41378.88FB1758
Content-Type: application/octet-stream;
	name="46.diff"
Content-Transfer-Encoding: base64
Content-Description: 46.diff
Content-Disposition: attachment;
	filename="46.diff"

LS0tIGNtcGNpLmMJTW9uIE1hciAyMiAxMjowNzowMiAyMDA0CisrKyAyLjYuNC9jbXBjaS5jCUZy
aSBNYXIgMjYgMTU6Mjc6MzIgMjAwNApAQCAtMTUyNSw3ICsxNTI1LDcgQEAKIAl9CiB9CiAKLXN0
YXRpYyB2b2lkIGNtX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQsIHN0cnVjdCBwdF9y
ZWdzICpyZWdzKQorc3RhdGljIGlycXJldHVybl90IGNtX2ludGVycnVwdChpbnQgaXJxLCB2b2lk
ICpkZXZfaWQsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQogewogICAgICAgICBzdHJ1Y3QgY21fc3Rh
dGUgKnMgPSAoc3RydWN0IGNtX3N0YXRlICopZGV2X2lkOwogCXVuc2lnbmVkIGludCBpbnRzcmMs
IGludHN0YXQ7CkBAIC0xNTM0LDcgKzE1MzQsNyBAQAogCS8qIGZhc3RwYXRoIG91dCwgdG8gZWFz
ZSBpbnRlcnJ1cHQgc2hhcmluZyAqLwogCWludHNyYyA9IGlubChzLT5pb2Jhc2UgKyBDT0RFQ19D
TUlfSU5UX1NUQVRVUyk7CiAJaWYgKCEoaW50c3JjICYgMHg4MDAwMDAwMCkpCi0JCXJldHVybjsK
KwkJcmV0dXJuIElSUV9OT05FOwogCXNwaW5fbG9jaygmcy0+bG9jayk7CiAJaW50c3RhdCA9IGlu
YihzLT5pb2Jhc2UgKyBDT0RFQ19DTUlfSU5UX0hMRENMUiArIDIpOwogCS8qIGFja25vd2xlZGdl
IGludGVycnVwdCAqLwpAQCAtMTU1NCw2ICsxNTU0LDcgQEAKIAkJCWluYihzLT5pb21pZGkpOy8v
IGR1bW15IHJlYWQKIAl9CiAjZW5kaWYKKwlyZXR1cm4gSVJRX0hBTkRMRUQ7CiB9CiAKIC8qIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSAqLwpAQCAtMjIwNyw3ICsyMjA4LDcgQEAKIAlpZiAoc2l6ZSA+IChQQUdFX1NJ
WkUgPDwgZGItPmJ1Zm9yZGVyKSkKIAkJZ290byBvdXQ7CiAJcmV0ID0gLUVJTlZBTDsKLQlpZiAo
cmVtYXBfcGFnZV9yYW5nZSh2bWEtPnZtX3N0YXJ0LCB2aXJ0X3RvX3BoeXMoZGItPnJhd2J1Ziks
IHNpemUsIHZtYS0+dm1fcGFnZV9wcm90KSkKKwlpZiAocmVtYXBfcGFnZV9yYW5nZSh2bWEsIHZt
YS0+dm1fc3RhcnQsIHZpcnRfdG9fcGh5cyhkYi0+cmF3YnVmKSwgc2l6ZSwgdm1hLT52bV9wYWdl
X3Byb3QpKQogCQlnb3RvIG91dDsKIAlkYi0+bWFwcGVkID0gMTsKIAlyZXQgPSAwOwpAQCAtMjI1
NiwxNCArMjI1NywxNCBAQAogICAgICAgICBjYXNlIFNORENUTF9EU1BfUkVTRVQ6CiAJCWlmIChm
aWxlLT5mX21vZGUgJiBGTU9ERV9XUklURSkgewogCQkJc3RvcF9kYWMocyk7Ci0JCQlzeW5jaHJv
bml6ZV9pcnEoKTsKKwkJCXN5bmNocm9uaXplX2lycShzLT5pcnEpOwogCQkJcy0+ZG1hX2RhYy5z
d3B0ciA9IHMtPmRtYV9kYWMuaHdwdHIgPSBzLT5kbWFfZGFjLmNvdW50ID0gcy0+ZG1hX2RhYy50
b3RhbF9ieXRlcyA9IDA7CiAJCQlpZiAocy0+c3RhdHVzICYgRE9fRFVBTF9EQUMpCiAJCQkJcy0+
ZG1hX2FkYy5zd3B0ciA9IHMtPmRtYV9hZGMuaHdwdHIgPSBzLT5kbWFfYWRjLmNvdW50ID0gcy0+
ZG1hX2FkYy50b3RhbF9ieXRlcyA9IDA7CiAJCX0KIAkJaWYgKGZpbGUtPmZfbW9kZSAmIEZNT0RF
X1JFQUQpIHsKIAkJCXN0b3BfYWRjKHMpOwotCQkJc3luY2hyb25pemVfaXJxKCk7CisJCQlzeW5j
aHJvbml6ZV9pcnEocy0+aXJxKTsKIAkJCXMtPmRtYV9hZGMuc3dwdHIgPSBzLT5kbWFfYWRjLmh3
cHRyID0gcy0+ZG1hX2FkYy5jb3VudCA9IHMtPmRtYV9hZGMudG90YWxfYnl0ZXMgPSAwOwogCQl9
CiAJCXJldHVybiAwOwpAQCAtMzE3NSw3ICszMTc2LDcgQEAKIAlzZXRfc3BkaWZfbG9vcChzLCAw
KTsKIAlsaXN0X2RlbCgmcy0+ZGV2cyk7CiAJb3V0YigwLCBzLT5pb2Jhc2UgKyBDT0RFQ19DTUlf
SU5UX0hMRENMUiArIDIpOyAgLyogZGlzYWJsZSBpbnRzICovCi0Jc3luY2hyb25pemVfaXJxKCk7
CisJc3luY2hyb25pemVfaXJxKHMtPmlycSk7CiAJb3V0YigwLCBzLT5pb2Jhc2UgKyBDT0RFQ19D
TUlfRlVOQ1RSTDAgKyAyKTsgLyogZGlzYWJsZSBjaGFubmVscyAqLwogCWZyZWVfaXJxKHMtPmly
cSwgcyk7CiAK

------_=_NextPart_001_01C41378.88FB1758--
