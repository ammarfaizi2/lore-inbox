Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTJLWiP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 18:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbTJLWiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 18:38:15 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:2564
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261226AbTJLWiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 18:38:13 -0400
Date: Sun, 12 Oct 2003 18:36:36 -0400 (EDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Manfred Spraul <manfred@colorfullife.com>
cc: Mike Galbraith <efault@gmx.de>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
In-Reply-To: <3F88FB90.7080801@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0310121831210.18583-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1588585444-1065998092=:18583"
Content-ID: <Pine.LNX.4.44.0310121835360.18583@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1588585444-1065998092=:18583
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0310121835361.18583@localhost.localdomain>

On Sun, 12 Oct 2003, Manfred Spraul wrote:

> Could you try the attached patch?
> It updates the end of stack detection to handle unaligned stacks.


I've attached a rediff of your patch against test7 bitkeeper.  It has the 
kstack_end function moved up above ASSEMBLY as suggested by Mike.  I've 
tested this version and it works for me (tm).  Thanks a bunch.

--8323328-1588585444-1065998092=:18583
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="stack2.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0310121834520.18583@localhost.localdomain>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="stack2.patch"

ZGlmZiAtdXIgbGludXgtMi41LXRtYS9hcmNoL2kzODYva2VybmVsL3RyYXBz
LmMgbGludXgtMi41LXRtL2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMuYw0KLS0t
IGxpbnV4LTIuNS10bWEvYXJjaC9pMzg2L2tlcm5lbC90cmFwcy5jCTIwMDMt
MTAtMTIgMTY6MTY6NTYuMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi41
LXRtL2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMuYwkyMDAzLTEwLTEyIDE1OjA1
OjQ4LjAwMDAwMDAwMCAtMDQwMA0KQEAgLTEwNCw3ICsxMDQsNyBAQA0KICNp
ZmRlZiBDT05GSUdfS0FMTFNZTVMNCiAJcHJpbnRrKCJcbiIpOw0KICNlbmRp
Zg0KLQl3aGlsZSAoKChsb25nKSBzdGFjayAmIChUSFJFQURfU0laRS0xKSkg
IT0gMCkgew0KKwl3aGlsZSAoIWtzdGFja19lbmQoc3RhY2spKSB7DQogCQlh
ZGRyID0gKnN0YWNrKys7DQogCQlpZiAoa2VybmVsX3RleHRfYWRkcmVzcyhh
ZGRyKSkgew0KIAkJCXByaW50aygiIFs8JTA4bHg+XSAiLCBhZGRyKTsNCkBA
IC0xMzgsNyArMTM4LDcgQEANCiANCiAJc3RhY2sgPSBlc3A7DQogCWZvcihp
ID0gMDsgaSA8IGtzdGFja19kZXB0aF90b19wcmludDsgaSsrKSB7DQotCQlp
ZiAoKChsb25nKSBzdGFjayAmIChUSFJFQURfU0laRS0xKSkgPT0gMCkNCisJ
CWlmIChrc3RhY2tfZW5kKHN0YWNrKSkNCiAJCQlicmVhazsNCiAJCWlmIChp
ICYmICgoaSAlIDgpID09IDApKQ0KIAkJCXByaW50aygiXG4gICAgICAgIik7
DQpkaWZmIC11ciBsaW51eC0yLjUtdG1hL2luY2x1ZGUvYXNtLWkzODYvdGhy
ZWFkX2luZm8uaCBsaW51eC0yLjUtdG0vaW5jbHVkZS9hc20taTM4Ni90aHJl
YWRfaW5mby5oDQotLS0gbGludXgtMi41LXRtYS9pbmNsdWRlL2FzbS1pMzg2
L3RocmVhZF9pbmZvLmgJMjAwMy0xMC0xMiAxNjoxNjoyOC4wMDAwMDAwMDAg
LTA0MDANCisrKyBsaW51eC0yLjUtdG0vaW5jbHVkZS9hc20taTM4Ni90aHJl
YWRfaW5mby5oCTIwMDMtMTAtMTIgMTU6MTk6MDkuMDAwMDAwMDAwIC0wNDAw
DQpAQCAtOTIsNiArOTIsMTYgQEANCiAjZGVmaW5lIGdldF90aHJlYWRfaW5m
byh0aSkgZ2V0X3Rhc2tfc3RydWN0KCh0aSktPnRhc2spDQogI2RlZmluZSBw
dXRfdGhyZWFkX2luZm8odGkpIHB1dF90YXNrX3N0cnVjdCgodGkpLT50YXNr
KQ0KIA0KK3N0YXRpYyBpbmxpbmUgaW50IGtzdGFja19lbmQodm9pZCAqYWRk
cikNCit7DQorICAgICAgICB1bnNpZ25lZCBsb25nIG9mZnNldCA9ICh1bnNp
Z25lZCBsb25nKWFkZHIgJiAoVEhSRUFEX1NJWkUtMSk7DQorDQorICAgICAg
ICAvKiBTb21lIEFQTSBiaW9zIHZlcnNpb25zIG1pc2FsaWduIHRoZSBzdGFj
ayAqLw0KKyAgICAgICAgaWYgKG9mZnNldCA9PSAwIHx8IG9mZnNldCA+IChU
SFJFQURfU0laRS1zaXplb2Yodm9pZCopKSkNCisgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gMTsNCisgICAgICAgIHJldHVybiAwOw0KK30NCisN
CiAjZWxzZSAvKiAhX19BU1NFTUJMWV9fICovDQogDQogLyogaG93IHRvIGdl
dCB0aGUgdGhyZWFkIGluZm9ybWF0aW9uIHN0cnVjdCBmcm9tIEFTTSAqLw0K
ZGlmZiAtdXIgbGludXgtMi41LXRtYS9tbS9zbGFiLmMgbGludXgtMi41LXRt
L21tL3NsYWIuYw0KLS0tIGxpbnV4LTIuNS10bWEvbW0vc2xhYi5jCTIwMDMt
MTAtMTIgMTY6MjQ6MTQuMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi41
LXRtL21tL3NsYWIuYwkyMDAzLTEwLTEyIDE1OjA1OjQ4LjAwMDAwMDAwMCAt
MDQwMA0KQEAgLTg2Miw3ICs4NjIsNyBAQA0KIAkJdW5zaWduZWQgbG9uZyAq
c3B0ciA9ICZjYWxsZXI7DQogCQl1bnNpZ25lZCBsb25nIHN2YWx1ZTsNCiAN
Ci0JCXdoaWxlICgoKGxvbmcpIHNwdHIgJiAoVEhSRUFEX1NJWkUtMSkpICE9
IDApIHsNCisJCXdoaWxlICgha3N0YWNrX2VuZChzcHRyKSkgew0KIAkJCXN2
YWx1ZSA9ICpzcHRyKys7DQogCQkJaWYgKGtlcm5lbF90ZXh0X2FkZHJlc3Mo
c3ZhbHVlKSkgew0KIAkJCQkqYWRkcisrPXN2YWx1ZTsNCk9ubHkgaW4gbGlu
dXgtMi41LXRtOiBzdGFjay5wYXRjaA0K
--8323328-1588585444-1065998092=:18583--
