Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264652AbRFSSbM>; Tue, 19 Jun 2001 14:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbRFSSbC>; Tue, 19 Jun 2001 14:31:02 -0400
Received: from ut-rasC-dial120.uniweb.net.co ([200.24.97.120]:49163 "EHLO
	earth.cj.osso.org.co") by vger.kernel.org with ESMTP
	id <S264652AbRFSSaz>; Tue, 19 Jun 2001 14:30:55 -0400
Date: Tue, 19 Jun 2001 13:30:29 -0500 (COT)
From: "Jhon H. Caicedo" <jhcaiced@osso.org.co>
To: <linux-kernel@vger.kernel.org>
Subject: AMD756VIPER PCI IRQ Routing Patch (Need Additional Tests)
Message-ID: <Pine.LNX.4.33.0106191306370.31330-200000@earth.cj.osso.org.co>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811832-917376918-992975429=:31330"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811832-917376918-992975429=:31330
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE


Hi,

I have been working on a small patch to add support for AMD756 PCI IRQ
Routing with linux-2.4.5

This has been tested with a Gigabyte 7IXE 7F board and several PCI cards,
including a SMC-Lucent PCI Cardbus Bridge which doesn't get an IRQ
assigned by the BIOS.

If anybody has a board based on this chipset I would appreciate further
testing and advise about the patch.

In this alpha version, I left two printk() lines to get information
about the IRQ settings.

You should get an output like the following:

[root@klingon ~]# dmesg | grep 756
PCI: Using IRQ router AMD756 VIPER [1022/740b] at 00:07.3
AMD756: dev 104c:ac1c, router pirq : 4 get irq :  0
AMD756: dev 104c:ac1c, router pirq : 4 get irq :  0
AMD756: dev 10ec:8029, router pirq : 3 get irq : 10
AMD756: dev 104c:ac1c, router pirq : 4 get irq :  0
AMD756: dev 104c:ac1c, router pirq : 4 SET irq :  5
AMD756: dev 104c:ac1c, router pirq : 4 get irq :  5
AMD756: dev 11fe:0005, router pirq : 1 get irq : 12

Thanks.

diff -u linux-2.4.5/arch/i386/kernel/pci-irq.c \
  linux/arch/i386/kernel/pci-irq.c > linux-2.4.5_amd756-pci-routing-alpha1.=
patch

--
Jhon H. Caicedo O. <jhcaiced@osso.org.co>
Observatorio Sismol=F3gico del SurOccidente O.S.S.O
http://www.osso.org.co
Cali - Colombia

---1463811832-917376918-992975429=:31330
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.5_amd756-pci-routing-alpha1.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0106191330290.31330@earth.cj.osso.org.co>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.5_amd756-pci-routing-alpha1.patch"

LS0tIGxpbnV4LTIuNC41L2FyY2gvaTM4Ni9rZXJuZWwvcGNpLWlycS5jCVdl
ZCBNYXkgMTYgMTI6MjU6MzkgMjAwMQ0KKysrIGxpbnV4L2FyY2gvaTM4Ni9r
ZXJuZWwvcGNpLWlycS5jCVR1ZSBKdW4gMTkgMTM6MjA6NDcgMjAwMQ0KQEAg
LTM5MSw2ICszOTEsNTYgQEANCiAJcmV0dXJuIDE7DQogfQ0KIA0KKy8qDQor
ICogSnVuLzE5LzIwMDEgU3VwcG9ydCBmb3IgQU1ENzU2IFBDSSBSb3V0ZXIg
KEFscGhhIFJlbGVhc2UpDQorICogSmhvbiBILiBDYWljZWRvIDxqaGNhaWNl
ZEBvc3NvLm9yZy5jbz4NCisgKiBUaGUgQU1ENzU2IHBpcnEgcnVsZXMgYXJl
IG5pYmJsZS1iYXNlZA0KKyAqIG9mZnNldCAweDU2IDAtMyBQSVJRQSAgNC03
ICBQSVJRQg0KKyAqIG9mZnNldCAweDU3IDAtMyBQSVJRQyAgNC03ICBQSVJR
RA0KKyAqLw0KK3N0YXRpYyBpbnQgcGlycV9hbWQ3NTZfZ2V0KHN0cnVjdCBw
Y2lfZGV2ICpyb3V0ZXIsIHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBwaXJx
KQ0KK3sNCisJdTggaXJxX3ZhbHVlOw0KKwl1OCBpcnE7DQorCQ0KKwlpZiAo
cGlycSA8IDUpDQorCXsNCisJCWlmIChwaXJxIDwgMykNCisJCQlwY2lfcmVh
ZF9jb25maWdfYnl0ZShyb3V0ZXIsIDB4NTYsICZpcnFfdmFsdWUpOw0KKwkJ
ZWxzZQ0KKwkJCXBjaV9yZWFkX2NvbmZpZ19ieXRlKHJvdXRlciwgMHg1Nywg
JmlycV92YWx1ZSk7DQorCSAgICBpZiAocGlycSAmIDEpDQorCSAgICAJaXJx
ID0gaXJxX3ZhbHVlICYgMTU7DQorCSAgICBlbHNlDQorCSAgICAJaXJxID0g
aXJxX3ZhbHVlID4+IDQ7DQorCQlwcmludGsoS0VSTl9JTkZPICJBTUQ3NTY6
IGRldiAlMDR4OiUwNHgsIHJvdXRlciBwaXJxIDogJWQgZ2V0IGlycSA6ICUy
ZFxuIiwNCisJCQlkZXYtPnZlbmRvciwgZGV2LT5kZXZpY2UsIHBpcnEsIGly
cSk7DQorCQlyZXR1cm4gaXJxOw0KKwl9DQorICAgIHJldHVybiAwOw0KK30N
CisNCitzdGF0aWMgaW50IHBpcnFfYW1kNzU2X3NldChzdHJ1Y3QgcGNpX2Rl
diAqcm91dGVyLCBzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgcGlycSwgaW50
IGlycSkNCit7DQorCXU4IGlycV92YWx1ZTsNCisJdTggb2Zmc2V0Ow0KKw0K
KwlwcmludGsoS0VSTl9JTkZPICJBTUQ3NTY6IGRldiAlMDR4OiUwNHgsIHJv
dXRlciBwaXJxIDogJWQgU0VUIGlycSA6ICUyZFxuIiwgDQorCQlkZXYtPnZl
bmRvciwgZGV2LT5kZXZpY2UsIHBpcnEsIGlycSk7DQorCQ0KKwlpZiAocGly
cSA8IDMpDQorCQlvZmZzZXQgPSAweDU2Ow0KKwllbHNlDQorCQlvZmZzZXQg
PSAweDU3Ow0KKwlwY2lfcmVhZF9jb25maWdfYnl0ZShyb3V0ZXIsIG9mZnNl
dCwgJmlycV92YWx1ZSk7DQorCWlmIChwaXJxICYgMSkNCisJCWlycV92YWx1
ZSA9IChpcnFfdmFsdWUgJiAweEYwKSB8IGlycTsNCisJZWxzZQ0KKwkJaXJx
X3ZhbHVlID0gKGlycV92YWx1ZSAmIDB4MEYpIHwgKGlycSA8PCA0KTsNCisJ
cGNpX3dyaXRlX2NvbmZpZ19ieXRlKHJvdXRlciwgb2Zmc2V0LCBpcnFfdmFs
dWUpOw0KKwlyZXR1cm4gMTsNCit9DQorDQogI2lmZGVmIENPTkZJR19QQ0lf
QklPUw0KIA0KIHN0YXRpYyBpbnQgcGlycV9iaW9zX3NldChzdHJ1Y3QgcGNp
X2RldiAqcm91dGVyLCBzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgcGlycSwg
aW50IGlycSkNCkBAIC00MjYsNiArNDc2LDggQEANCiAJeyAiVkxTSSA4MkM1
MzQiLCBQQ0lfVkVORE9SX0lEX1ZMU0ksIFBDSV9ERVZJQ0VfSURfVkxTSV84
MkM1MzQsIHBpcnFfdmxzaV9nZXQsIHBpcnFfdmxzaV9zZXQgfSwNCiAJeyAi
U2VydmVyV29ya3MiLCBQQ0lfVkVORE9SX0lEX1NFUlZFUldPUktTLCBQQ0lf
REVWSUNFX0lEX1NFUlZFUldPUktTX09TQjQsDQogCSAgcGlycV9zZXJ2ZXJ3
b3Jrc19nZXQsIHBpcnFfc2VydmVyd29ya3Nfc2V0IH0sDQorCXsgIkFNRDc1
NiBWSVBFUiIsIFBDSV9WRU5ET1JfSURfQU1ELCBQQ0lfREVWSUNFX0lEX0FN
RF9WSVBFUl83NDBCLA0KKwkJcGlycV9hbWQ3NTZfZ2V0LCBwaXJxX2FtZDc1
Nl9zZXQgfSwNCiANCiAJeyAiZGVmYXVsdCIsIDAsIDAsIE5VTEwsIE5VTEwg
fQ0KIH07DQo=
---1463811832-917376918-992975429=:31330--
