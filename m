Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbRDCKDo>; Tue, 3 Apr 2001 06:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRDCKDd>; Tue, 3 Apr 2001 06:03:33 -0400
Received: from chiara.elte.hu ([157.181.150.200]:54283 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131578AbRDCKDV>;
	Tue, 3 Apr 2001 06:03:21 -0400
Date: Tue, 3 Apr 2001 11:01:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] print-64gb-oopses-2.4.2-J2
Message-ID: <Pine.LNX.4.30.0104031058160.2794-200000@elte.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-1164591972-986288488=:2794"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-1164591972-986288488=:2794
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached patch (against 2.4.3) makes pagetable-printing
PAE-compatible, handling the nonexistent pagetable case too.

	Ingo

--655616-1164591972-986288488=:2794
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="print-64gb-oopses-2.4.2-J2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0104031101280.2794@elte.hu>
Content-Description: 
Content-Disposition: attachment; filename="print-64gb-oopses-2.4.2-J2"

LS0tIGxpbnV4L2FyY2gvaTM4Ni9tbS9mYXVsdC5jLm9yaWcJVHVlIEFwciAg
MyAxMzo1ODo1OCAyMDAxDQorKysgbGludXgvYXJjaC9pMzg2L21tL2ZhdWx0
LmMJVHVlIEFwciAgMyAxMzo1OToyMiAyMDAxDQpAQCAtOTAsNiArOTAsMzMg
QEANCiAJc3Bpbl9sb2NrX2luaXQoJnRpbWVybGlzdF9sb2NrKTsNCiB9DQog
DQorc3RhdGljIHZvaWQgcHJpbnRfcGFnZXRhYmxlX2VudHJpZXMgKHBnZF90
ICpwZ2RpciwgdW5zaWduZWQgbG9uZyBhZGRyZXNzKQ0KK3sNCisJcGdkX3Qg
KnBnZDsNCisJcG1kX3QgKnBtZDsNCisJcHRlX3QgKnB0ZTsNCisNCisJcGdk
ID0gcGdkaXIgKyBfX3BnZF9vZmZzZXQoYWRkcmVzcyk7DQorCXByaW50aygi
cGdkIGVudHJ5ICVwOiAlMDE2THhcbiIsIHBnZCwgKGxvbmcgbG9uZylwZ2Rf
dmFsKCpwZ2QpKTsNCisNCisJaWYgKCFwZ2RfcHJlc2VudCgqcGdkKSkgew0K
KwkJcHJpbnRrKCIuLi4gcGdkIG5vdCBwcmVzZW50IVxuIik7DQorCQlyZXR1
cm47DQorCX0NCisJcG1kID0gcG1kX29mZnNldChwZ2QsIGFkZHJlc3MpOw0K
KwlwcmludGsoInBtZCBlbnRyeSAlcDogJTAxNkx4XG4iLCBwbWQsIChsb25n
IGxvbmcpcG1kX3ZhbCgqcG1kKSk7DQorDQorCWlmICghcG1kX3ByZXNlbnQo
KnBtZCkpIHsNCisJCXByaW50aygiLi4uIHBtZCBub3QgcHJlc2VudCFcbiIp
Ow0KKwkJcmV0dXJuOw0KKwl9DQorCXB0ZSA9IHB0ZV9vZmZzZXQocG1kLCBh
ZGRyZXNzKTsNCisJcHJpbnRrKCJwdGUgZW50cnkgJXA6ICUwMTZMeFxuIiwg
cHRlLCAobG9uZyBsb25nKXB0ZV92YWwoKnB0ZSkpOw0KKw0KKwlpZiAoIXB0
ZV9wcmVzZW50KCpwdGUpKQ0KKwkJcHJpbnRrKCIuLi4gcHRlIG5vdCBwcmVz
ZW50IVxuIik7DQorfQ0KKw0KIGFzbWxpbmthZ2Ugdm9pZCBkb19pbnZhbGlk
X29wKHN0cnVjdCBwdF9yZWdzICosIHVuc2lnbmVkIGxvbmcpOw0KIGV4dGVy
biB1bnNpZ25lZCBsb25nIGlkdDsNCiANCkBAIC0yNzQsMTQgKzMwMSw3IEBA
DQogCXByaW50aygiIHByaW50aW5nIGVpcDpcbiIpOw0KIAlwcmludGsoIiUw
OGx4XG4iLCByZWdzLT5laXApOw0KIAlhc20oIm1vdmwgJSVjcjMsJTAiOiI9
ciIgKHBhZ2UpKTsNCi0JcGFnZSA9ICgodW5zaWduZWQgbG9uZyAqKSBfX3Zh
KHBhZ2UpKVthZGRyZXNzID4+IDIyXTsNCi0JcHJpbnRrKEtFUk5fQUxFUlQg
IipwZGUgPSAlMDhseFxuIiwgcGFnZSk7DQotCWlmIChwYWdlICYgMSkgew0K
LQkJcGFnZSAmPSBQQUdFX01BU0s7DQotCQlhZGRyZXNzICY9IDB4MDAzZmYw
MDA7DQotCQlwYWdlID0gKCh1bnNpZ25lZCBsb25nICopIF9fdmEocGFnZSkp
W2FkZHJlc3MgPj4gUEFHRV9TSElGVF07DQotCQlwcmludGsoS0VSTl9BTEVS
VCAiKnB0ZSA9ICUwOGx4XG4iLCBwYWdlKTsNCi0JfQ0KKwlwcmludF9wYWdl
dGFibGVfZW50cmllcygocGdkX3QgKilfX3ZhKHBhZ2UpLCBhZGRyZXNzKTsN
CiAJZGllKCJPb3BzIiwgcmVncywgZXJyb3JfY29kZSk7DQogCWRvX2V4aXQo
U0lHS0lMTCk7DQogDQo=
--655616-1164591972-986288488=:2794--
