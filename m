Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422839AbWJPTHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422839AbWJPTHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422835AbWJPTHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:07:09 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:12017 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1422818AbWJPTHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:07:07 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: [PATCH] x86_64: store Socket ID in phys_proc_id
Date: Mon, 16 Oct 2006 11:52:39 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D6E3@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64: store Socket ID in phys_proc_id
Thread-Index: AcbxUiBVxuYFuta9TTyuk6EUKOOcrgAAURyQ
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
X-OriginalArrivalTime: 16 Oct 2006 18:52:41.0127 (UTC)
 FILETIME=[41DE4370:01C6F154]
X-WSS-ID: 692D0A570C44651557-05-01
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_001_01C6F154.41269D3B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F154.41269D3B
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Current code store phys_proc_id with init APIC ID, and later will change
to apicid>>bits.

So for the apic id lifted system, for example BSP with apicid 0x10, the
phys_proc_id will be 8.

This patch use initial APIC ID to get Socket ID.

It also removed ht_nodeid calculating, because We already have correct
socket id for sure.

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>



------_=_NextPart_001_01C6F154.41269D3B
Content-Type: application/octet-stream;
 name=setup_c.diff
Content-Transfer-Encoding: base64
Content-Description: setup_c.diff
Content-Disposition: attachment;
 filename=setup_c.diff

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC94ODZfNjQva2Vy
bmVsL3NldHVwLmMKaW5kZXggZmM5NDRiNS4uZDMwZjc4YSAxMDA2NDQKLS0tIGEvYXJjaC94ODZf
NjQva2VybmVsL3NldHVwLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL3NldHVwLmMKQEAgLTY0
MywzNCArNjQzLDIwIEBAICNlbmRpZgogCiAJLyogTG93IG9yZGVyIGJpdHMgZGVmaW5lIHRoZSBj
b3JlIGlkIChpbmRleCBvZiBjb3JlIGluIHNvY2tldCkgKi8KIAljLT5jcHVfY29yZV9pZCA9IGMt
PnBoeXNfcHJvY19pZCAmICgoMSA8PCBiaXRzKS0xKTsKLQkvKiBDb252ZXJ0IHRoZSBBUElDIElE
IGludG8gdGhlIHNvY2tldCBJRCAqLwotCWMtPnBoeXNfcHJvY19pZCA9IHBoeXNfcGtnX2lkKGJp
dHMpOworCS8qIENvbnZlcnQgdGhlIGluaXRpYWwgQVBJQyBJRCBpbnRvIHRoZSBzb2NrZXQgSUQg
Ki8KKwljLT5waHlzX3Byb2NfaWQgPj49IGJpdHM7IAogCiAjaWZkZWYgQ09ORklHX05VTUEKICAg
CW5vZGUgPSBjLT5waHlzX3Byb2NfaWQ7CiAgCWlmIChhcGljaWRfdG9fbm9kZVthcGljaWRdICE9
IE5VTUFfTk9fTk9ERSkKICAJCW5vZGUgPSBhcGljaWRfdG9fbm9kZVthcGljaWRdOwogIAlpZiAo
IW5vZGVfb25saW5lKG5vZGUpKSB7Ci0gCQkvKiBUd28gcG9zc2liaWxpdGllcyBoZXJlOgotIAkJ
ICAgLSBUaGUgQ1BVIGlzIG1pc3NpbmcgbWVtb3J5IGFuZCBubyBub2RlIHdhcyBjcmVhdGVkLgot
IAkJICAgSW4gdGhhdCBjYXNlIHRyeSBwaWNraW5nIG9uZSBmcm9tIGEgbmVhcmJ5IENQVQotIAkJ
ICAgLSBUaGUgQVBJQyBJRHMgZGlmZmVyIGZyb20gdGhlIEh5cGVyVHJhbnNwb3J0IG5vZGUgSURz
Ci0gCQkgICB3aGljaCB0aGUgSzggbm9ydGhicmlkZ2UgcGFyc2luZyBmaWxscyBpbi4KLSAJCSAg
IEFzc3VtZSB0aGV5IGFyZSBhbGwgaW5jcmVhc2VkIGJ5IGEgY29uc3RhbnQgb2Zmc2V0LAotIAkJ
ICAgYnV0IGluIHRoZSBzYW1lIG9yZGVyIGFzIHRoZSBIVCBub2RlaWRzLgotIAkJICAgSWYgdGhh
dCBkb2Vzbid0IHJlc3VsdCBpbiBhIHVzYWJsZSBub2RlIGZhbGwgYmFjayB0byB0aGUKLSAJCSAg
IHBhdGggZm9yIHRoZSBwcmV2aW91cyBjYXNlLiAgKi8KLSAJCWludCBodF9ub2RlaWQgPSBhcGlj
aWQgLSAoY3B1X2RhdGFbMF0ucGh5c19wcm9jX2lkIDw8IGJpdHMpOwotIAkJaWYgKGh0X25vZGVp
ZCA+PSAwICYmCi0gCQkgICAgYXBpY2lkX3RvX25vZGVbaHRfbm9kZWlkXSAhPSBOVU1BX05PX05P
REUpCi0gCQkJbm9kZSA9IGFwaWNpZF90b19ub2RlW2h0X25vZGVpZF07CiAgCQkvKiBQaWNrIGEg
bmVhcmJ5IG5vZGUgKi8KLSAJCWlmICghbm9kZV9vbmxpbmUobm9kZSkpCi0gCQkJbm9kZSA9IG5l
YXJieV9ub2RlKGFwaWNpZCk7CisJCW5vZGUgPSBuZWFyYnlfbm9kZShhcGljaWQpOwogIAl9CiAJ
bnVtYV9zZXRfbm9kZShjcHUsIG5vZGUpOwogCi0JcHJpbnRrKEtFUk5fSU5GTyAiQ1BVICVkLyV4
IC0+IE5vZGUgJWRcbiIsIGNwdSwgYXBpY2lkLCBub2RlKTsKKwlwcmludGsoS0VSTl9JTkZPICJD
UFUgJWQvMHglMDJ4IC0+IE5vZGUgJWRcbiIsIGNwdSwgYXBpY2lkLCBub2RlKTsKICNlbmRpZgog
I2VuZGlmCiB9CkBAIC05MjgsNyArOTE0LDcgQEAgdm9pZCBfX2NwdWluaXQgZWFybHlfaWRlbnRp
ZnlfY3B1KHN0cnVjdAogCX0KIAogI2lmZGVmIENPTkZJR19TTVAKLQljLT5waHlzX3Byb2NfaWQg
PSAoY3B1aWRfZWJ4KDEpID4+IDI0KSAmIDB4ZmY7CisJYy0+cGh5c19wcm9jX2lkID0gKGNwdWlk
X2VieCgxKSA+PiAyNCkgJiAweGZmOyAvKiBpbml0aWFsIEFQSUMgSUQgKi8KICNlbmRpZgogfQog
CkBAIC0xMTM2LDYgKzExMjIsNyBAQCAjZW5kaWYKICNpZmRlZiBDT05GSUdfU01QCiAJaWYgKHNt
cF9udW1fc2libGluZ3MgKiBjLT54ODZfbWF4X2NvcmVzID4gMSkgewogCQlpbnQgY3B1ID0gYyAt
IGNwdV9kYXRhOworCQlzZXFfcHJpbnRmKG0sICJhcGljIGlkXHRcdDogMHglMDJ4XG4iLCB4ODZf
Y3B1X3RvX2FwaWNpZFtjcHVdKTsKIAkJc2VxX3ByaW50ZihtLCAicGh5c2ljYWwgaWRcdDogJWRc
biIsIGMtPnBoeXNfcHJvY19pZCk7CiAJCXNlcV9wcmludGYobSwgInNpYmxpbmdzXHQ6ICVkXG4i
LCBjcHVzX3dlaWdodChjcHVfY29yZV9tYXBbY3B1XSkpOwogCQlzZXFfcHJpbnRmKG0sICJjb3Jl
IGlkXHRcdDogJWRcbiIsIGMtPmNwdV9jb3JlX2lkKTsK

------_=_NextPart_001_01C6F154.41269D3B--


