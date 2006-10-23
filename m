Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWJWVA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWJWVA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWJWVA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:00:26 -0400
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:1630 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751462AbWJWVAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:00:24 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity
 in phys flat mode
Date: Mon, 23 Oct 2006 13:00:23 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D747@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity
 in phys flat mode
Thread-Index: Acb2z6yh7kkkVcL9RS2Pl+w1VN4u7AADThVw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Andi Kleen" <ak@muc.de>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
X-OriginalArrivalTime: 23 Oct 2006 20:00:24.0521 (UTC)
 FILETIME=[E0BB3B90:01C6F6DD]
X-WSS-ID: 6923C0D21X4116890-01-01
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_001_01C6F6DD.E040B4D2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F6DD.E040B4D2
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

From: ebiederm@xmission.com [mailto:ebiederm@xmission.com]=20

>Beyond that I have a few nits to pick with the patch.
>- We duplicate the code that claims a new vector which makes
>  maintenance a pain.
>- The comments are specific to phys_flat but the code is not.
>- The test for being able to use the old_vector in the new domain
>  should be: ...[old_vector] =3D=3D vector || ...[old_vector] =3D=3D -1

Please attached one. This one need to after your patch about irq.

YH


------_=_NextPart_001_01C6F6DD.E040B4D2
Content-Type: application/octet-stream;
 name=io_apic_reuse_vector.diff
Content-Transfer-Encoding: base64
Content-Description: io_apic_reuse_vector.diff
Content-Disposition: attachment;
 filename=io_apic_reuse_vector.diff

LS0tIGFyY2gveDg2XzY0L2tlcm5lbC9pb19hcGljX2VyaWMuYwkyMDA2LTEwLTIzIDExOjU2OjM2
LjAwMDAwMDAwMCAtMDcwMAorKysgYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMuYwkyMDA2LTEw
LTIzIDExOjIyOjMxLjAwMDAwMDAwMCAtMDcwMApAQCAtNjEzLDggKzYxMyw5IEBACiAJICogMHg4
MCwgYmVjYXVzZSBpbnQgMHg4MCBpcyBobSwga2luZCBvZiBpbXBvcnRhbnRpc2guIDspCiAJICov
CiAJc3RhdGljIGludCBjdXJyZW50X3ZlY3RvciA9IEZJUlNUX0RFVklDRV9WRUNUT1IsIGN1cnJl
bnRfb2Zmc2V0ID0gMDsKLQlpbnQgb2xkX3ZlY3RvciA9IC0xOwotCWludCBjcHU7CisJaW50IHZl
Y3RvciA9IC0xLCBvbGRfdmVjdG9yID0gLTE7CisJY3B1bWFza190IGRvbWFpbiwgbmV3X21hc2s7
CisJaW50IGNwdSwgbmV3X2NwdTsKIAogCUJVR19PTigodW5zaWduZWQpaXJxID49IE5SX0lSUV9W
RUNUT1JTKTsKIApAQCAtNjI4LDEyICs2MjksMjkgQEAKIAkJaWYgKCFjcHVzX2VtcHR5KCpyZXN1
bHQpKQogCQkJcmV0dXJuIG9sZF92ZWN0b3I7CiAKKwkJLyogdHJ5IHRvIHJldXNlIHZlY3RvciAq
LworCQlmb3JfZWFjaF9jcHVfbWFzayhjcHUsIG1hc2spIHsKKwkJCWludCBjYW5fcmVzdWUgPSAx
OworCQkJZG9tYWluID0gdmVjdG9yX2FsbG9jYXRpb25fZG9tYWluKGNwdSk7CisJCQljcHVzX2Fu
ZChuZXdfbWFzaywgZG9tYWluLCBjcHVfb25saW5lX21hcCk7CisJCQlmb3JfZWFjaF9jcHVfbWFz
ayhuZXdfY3B1LCBuZXdfbWFzaykgeworCQkJCWludCBvbGRfaXJxOworCQkJCW9sZF9pcnEgPSBw
ZXJfY3B1KHZlY3Rvcl9pcnEsIG5ld19jcHUpW29sZF92ZWN0b3JdOworCQkJCWlmICggKG9sZF9p
cnEgIT0gaXJxKSAmJiAob2xkX2lycSAhPSAtMSkpIHsKKwkJCQkJY2FuX3Jlc3VlID0gMDsKKwkJ
CQkJYnJlYWs7CisJCQkJfQorCQkJfQorCisJCQlpZighY2FuX3Jlc3VlKSBjb250aW51ZTsKKwor
CQkJdmVjdG9yID0gb2xkX3ZlY3RvcjsKKwkJCWdvdG8gZm91bmRfb25lOwkKKwkJfQogCX0KIAog
CWZvcl9lYWNoX2NwdV9tYXNrKGNwdSwgbWFzaykgewotCQljcHVtYXNrX3QgZG9tYWluLCBuZXdf
bWFzazsKLQkJaW50IG5ld19jcHU7Ci0JCWludCB2ZWN0b3IsIG9mZnNldDsKKwkJaW50IG9mZnNl
dDsKIAogCQlkb21haW4gPSB2ZWN0b3JfYWxsb2NhdGlvbl9kb21haW4oY3B1KTsKIAkJY3B1c19h
bmQobmV3X21hc2ssIGRvbWFpbiwgY3B1X29ubGluZV9tYXApOwpAQCAtNjU3LDIxICs2NzUsMjcg
QEAKIAkJLyogRm91bmQgb25lISAqLwogCQljdXJyZW50X3ZlY3RvciA9IHZlY3RvcjsKIAkJY3Vy
cmVudF9vZmZzZXQgPSBvZmZzZXQ7Ci0JCWlmIChvbGRfdmVjdG9yID49IDApIHsKLQkJCWNwdW1h
c2tfdCBvbGRfbWFzazsKLQkJCWludCBvbGRfY3B1OwotCQkJY3B1c19hbmQob2xkX21hc2ssIGly
cV9kb21haW5baXJxXSwgY3B1X29ubGluZV9tYXApOwotCQkJZm9yX2VhY2hfY3B1X21hc2sob2xk
X2NwdSwgb2xkX21hc2spCi0JCQkJcGVyX2NwdSh2ZWN0b3JfaXJxLCBvbGRfY3B1KVtvbGRfdmVj
dG9yXSA9IC0xOwotCQl9Ci0JCWZvcl9lYWNoX2NwdV9tYXNrKG5ld19jcHUsIG5ld19tYXNrKQot
CQkJcGVyX2NwdSh2ZWN0b3JfaXJxLCBuZXdfY3B1KVt2ZWN0b3JdID0gaXJxOwotCQlpcnFfdmVj
dG9yW2lycV0gPSB2ZWN0b3I7Ci0JCWlycV9kb21haW5baXJxXSA9IGRvbWFpbjsKLQkJY3B1c19h
bmQoKnJlc3VsdCwgZG9tYWluLCBtYXNrKTsKLQkJcmV0dXJuIHZlY3RvcjsKKwkJCisJCWdvdG8g
Zm91bmRfb25lOwogCX0KKwogCXJldHVybiAtRU5PU1BDOworCitmb3VuZF9vbmU6CisJaWYgKG9s
ZF92ZWN0b3IgPj0gMCkgeworCQljcHVtYXNrX3Qgb2xkX21hc2s7CisJCWludCBvbGRfY3B1Owor
CQljcHVzX2FuZChvbGRfbWFzaywgaXJxX2RvbWFpbltpcnFdLCBjcHVfb25saW5lX21hcCk7CisJ
CWZvcl9lYWNoX2NwdV9tYXNrKG9sZF9jcHUsIG9sZF9tYXNrKQorCQkJcGVyX2NwdSh2ZWN0b3Jf
aXJxLCBvbGRfY3B1KVtvbGRfdmVjdG9yXSA9IC0xOworCX0KKwlmb3JfZWFjaF9jcHVfbWFzayhu
ZXdfY3B1LCBuZXdfbWFzaykKKwkJcGVyX2NwdSh2ZWN0b3JfaXJxLCBuZXdfY3B1KVt2ZWN0b3Jd
ID0gaXJxOworCWlycV92ZWN0b3JbaXJxXSA9IHZlY3RvcjsKKwlpcnFfZG9tYWluW2lycV0gPSBk
b21haW47CisJY3B1c19hbmQoKnJlc3VsdCwgZG9tYWluLCBtYXNrKTsKKwlyZXR1cm4gdmVjdG9y
OworCiB9CiAKIHN0YXRpYyBpbnQgYXNzaWduX2lycV92ZWN0b3IoaW50IGlycSwgY3B1bWFza190
IG1hc2ssIGNwdW1hc2tfdCAqcmVzdWx0KQo=

------_=_NextPart_001_01C6F6DD.E040B4D2--


