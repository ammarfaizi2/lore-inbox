Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284850AbRLKEXF>; Mon, 10 Dec 2001 23:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284871AbRLKEWy>; Mon, 10 Dec 2001 23:22:54 -0500
Received: from nat.transgeek.com ([66.92.79.28]:58876 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S284850AbRLKEWq>;
	Mon, 10 Dec 2001 23:22:46 -0500
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: allocation failures when cache eats all memory -- the updatedb issue
Date: Mon, 10 Dec 2001 23:24:25 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_P8W50EK1P8HPVLS451YJ"
Message-Id: <20011211002102.9ED87C7382@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_P8W50EK1P8HPVLS451YJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

The attached patch fixes all of these problems for me.  More than likley this 
is just covering the real issue, but the difference should allow someone with 
more VM talent than myself to fix.


Craig.




--------------Boundary-00=_P8W50EK1P8HPVLS451YJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vmscan-alloc-fix.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="vmscan-alloc-fix.diff"

LS0tIGxpbnV4L21tL3Ztc2Nhbi5jCVNhdCBOb3YgMTcgMjI6MTg6MTcgMjAwMQorKysgbGludXgu
bXQvbW0vdm1zY2FuLmMJTW9uIERlYyAxMCAxOTo1NToyMyAyMDAxCkBAIC01MzEsMTMgKzUzMSwx
NCBAQAogICogV2UgbW92ZSB0aGVtIHRoZSBvdGhlciB3YXkgd2hlbiB3ZSBzZWUgdGhlCiAgKiBy
ZWZlcmVuY2UgYml0IG9uIHRoZSBwYWdlLgogICovCi1zdGF0aWMgdm9pZCByZWZpbGxfaW5hY3Rp
dmUoaW50IG5yX3BhZ2VzKQorc3RhdGljIGludCByZWZpbGxfaW5hY3RpdmUoaW50IG5yX3BhZ2Vz
KQogewogCXN0cnVjdCBsaXN0X2hlYWQgKiBlbnRyeTsKKwlpbnQgY291bnQgPSAwOwogCiAJc3Bp
bl9sb2NrKCZwYWdlbWFwX2xydV9sb2NrKTsKIAllbnRyeSA9IGFjdGl2ZV9saXN0LnByZXY7Ci0J
d2hpbGUgKG5yX3BhZ2VzLS0gJiYgZW50cnkgIT0gJmFjdGl2ZV9saXN0KSB7CisJd2hpbGUgKG5y
X3BhZ2VzICYmIGVudHJ5ICE9ICZhY3RpdmVfbGlzdCkgewogCQlzdHJ1Y3QgcGFnZSAqIHBhZ2U7
CiAKIAkJcGFnZSA9IGxpc3RfZW50cnkoZW50cnksIHN0cnVjdCBwYWdlLCBscnUpOwpAQCAtNTQ1
LDE0ICs1NDYsMTYgQEAKIAkJaWYgKFBhZ2VUZXN0YW5kQ2xlYXJSZWZlcmVuY2VkKHBhZ2UpKSB7
CiAJCQlsaXN0X2RlbCgmcGFnZS0+bHJ1KTsKIAkJCWxpc3RfYWRkKCZwYWdlLT5scnUsICZhY3Rp
dmVfbGlzdCk7Ci0JCQljb250aW51ZTsKKwkJfSBlbHNlIHsKKwkJCWRlbF9wYWdlX2Zyb21fYWN0
aXZlX2xpc3QocGFnZSk7CisJCQlhZGRfcGFnZV90b19pbmFjdGl2ZV9saXN0KHBhZ2UpOworCQkJ
U2V0UGFnZVJlZmVyZW5jZWQocGFnZSk7CisJCQlucl9wYWdlcy0tOworCQkJY291bnQrKzsKIAkJ
fQotCi0JCWRlbF9wYWdlX2Zyb21fYWN0aXZlX2xpc3QocGFnZSk7Ci0JCWFkZF9wYWdlX3RvX2lu
YWN0aXZlX2xpc3QocGFnZSk7Ci0JCVNldFBhZ2VSZWZlcmVuY2VkKHBhZ2UpOwogCX0KIAlzcGlu
X3VubG9jaygmcGFnZW1hcF9scnVfbG9jayk7CisJcmV0dXJuIGNvdW50OwogfQogCiBzdGF0aWMg
aW50IEZBU1RDQUxMKHNocmlua19jYWNoZXMoem9uZV90ICogY2xhc3N6b25lLCBpbnQgcHJpb3Jp
dHksIHVuc2lnbmVkIGludCBnZnBfbWFzaywgaW50IG5yX3BhZ2VzKSk7CkBAIC01NjQsMjIgKzU2
NywyNCBAQAogCW5yX3BhZ2VzIC09IGttZW1fY2FjaGVfcmVhcChnZnBfbWFzayk7CiAJaWYgKG5y
X3BhZ2VzIDw9IDApCiAJCXJldHVybiAwOworCXNocmlua19kY2FjaGVfbWVtb3J5KHByaW9yaXR5
LCBnZnBfbWFzayk7CisJc2hyaW5rX2ljYWNoZV9tZW1vcnkocHJpb3JpdHksIGdmcF9tYXNrKTsK
KyNpZmRlZiBDT05GSUdfUVVPVEEKKwlzaHJpbmtfZHFjYWNoZV9tZW1vcnkoREVGX1BSSU9SSVRZ
LCBnZnBfbWFzayk7CisjZW5kaWYKIAogCW5yX3BhZ2VzID0gY2h1bmtfc2l6ZTsKIAkvKiB0cnkg
dG8ga2VlcCB0aGUgYWN0aXZlIGxpc3QgMi8zIG9mIHRoZSBzaXplIG9mIHRoZSBjYWNoZSAqLwog
CXJhdGlvID0gKHVuc2lnbmVkIGxvbmcpIG5yX3BhZ2VzICogbnJfYWN0aXZlX3BhZ2VzIC8gKChu
cl9pbmFjdGl2ZV9wYWdlcyArIDEpICogMik7CisJaWYoIXJhdGlvKQorCQlyYXRpbyA9IG5yX3Bh
Z2VzOworCiAJcmVmaWxsX2luYWN0aXZlKHJhdGlvKTsKIAogCW5yX3BhZ2VzID0gc2hyaW5rX2Nh
Y2hlKG5yX3BhZ2VzLCBjbGFzc3pvbmUsIGdmcF9tYXNrLCBwcmlvcml0eSk7CisKIAlpZiAobnJf
cGFnZXMgPD0gMCkKIAkJcmV0dXJuIDA7Ci0KLQlzaHJpbmtfZGNhY2hlX21lbW9yeShwcmlvcml0
eSwgZ2ZwX21hc2spOwotCXNocmlua19pY2FjaGVfbWVtb3J5KHByaW9yaXR5LCBnZnBfbWFzayk7
Ci0jaWZkZWYgQ09ORklHX1FVT1RBCi0Jc2hyaW5rX2RxY2FjaGVfbWVtb3J5KERFRl9QUklPUklU
WSwgZ2ZwX21hc2spOwotI2VuZGlmCi0KIAlyZXR1cm4gbnJfcGFnZXM7CiB9CiAK

--------------Boundary-00=_P8W50EK1P8HPVLS451YJ--
