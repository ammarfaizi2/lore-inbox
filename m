Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279968AbRKIQS2>; Fri, 9 Nov 2001 11:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279980AbRKIQST>; Fri, 9 Nov 2001 11:18:19 -0500
Received: from ns.sysgo.de ([213.68.67.98]:35057 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S279968AbRKIQSK>;
	Fri, 9 Nov 2001 11:18:10 -0500
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_GYJJ32HA1OBBG12CVE3K"
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rkaiser@sysgo.de
Organization: Sysgo RTS GmbH
To: <robert@schwebel.de>
Subject: Re: Kernel booting on serial console ... crawling
Date: Fri, 9 Nov 2001 17:18:16 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0111091321441.12746-100000@callisto.local>
In-Reply-To: <Pine.LNX.4.33.0111091321441.12746-100000@callisto.local>
Cc: Anders Larsen <a.larsen@identecsolutions.de>, <pallaire@gameloft.com>,
        <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01110917181600.03671@rob>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_GYJJ32HA1OBBG12CVE3K
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Robert,

Am Freitag,  9. November 2001 13:27 schrieben Sie:
> On Fri, 9 Nov 2001, Robert Kaiser wrote:
> > Is this an AMD Elan's built-in serial port, perchance ?
>
> I got a patch for the Elan's serial port from Jason Sodergren some days
> ago, but it's not clear to me what exactly the problem is with this port.
> I'm using the serial console on a DIL/Net-PC without any problems so far.
> Perhaps it might be a good idea to join forces and try to get a patch for
> the Elan series into the main kernel?
>
> However, my current affords can be found on
>
>   http://www.schwebel.de/software/dnp/index_en.html
>
> This currently implements a new CPU configuration parameter and a fix for
> the clock on the Elan CPUs.

This is interesting, I was not aware of the different clock frequency issue.

Anyway, the patch I am using to fix the crawling console output symptom on 
the Elan is entirely different (see attachment). It was originally posted by
Anders Larsen <a.larsen@identecsolutions.de> and we have been using
it with good success in our embedded Linux product for quite a while now.
The comments in the source describe the problem. Interestingly, even the
latest AMD Elan product (SC520) seems to have this problem too.

Rob

----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10

--------------Boundary-00=_GYJJ32HA1OBBG12CVE3K
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="patch-AMD-elan-serial"
Content-Transfer-Encoding: base64
Content-Description: AMD Elan Workaround
Content-Disposition: attachment; filename="patch-AMD-elan-serial"

SW5kZXg6IHN5c2dvL2VsaW5vcy9saW51eC9kcml2ZXJzL2NoYXIvc2VyaWFsLmMNCmRpZmYgLWMg
c3lzZ28vZWxpbm9zL2xpbnV4L2RyaXZlcnMvY2hhci9zZXJpYWwuYzoxLjIgc3lzZ28vZWxpbm9z
L2xpbnV4L2RyaXZlcnMvY2hhci9zZXJpYWwuYzoxLjMNCioqKiBzeXNnby9lbGlub3MvbGludXgv
ZHJpdmVycy9jaGFyL3NlcmlhbC5jOjEuMglXZWQgTWF5IDE3IDE0OjA3OjAwIDIwMDANCi0tLSBz
eXNnby9lbGlub3MvbGludXgvZHJpdmVycy9jaGFyL3NlcmlhbC5jCVdlZCBKdW4gIDcgMTU6MTk6
NTMgMjAwMA0KKioqKioqKioqKioqKioqDQoqKiogNjA3LDYxMiAqKioqDQotLS0gNjA3LDYxMyAt
LS0tDQogIAlpbnQgc3RhdHVzOw0KICAJc3RydWN0IGFzeW5jX3N0cnVjdCAqIGluZm87DQogIAlp
bnQgcGFzc19jb3VudGVyID0gMDsNCisgCWludCBpaXI7DQogIAlzdHJ1Y3QgYXN5bmNfc3RydWN0
ICplbmRfbWFyayA9IDA7DQogICNpZmRlZiBDT05GSUdfU0VSSUFMX01VTFRJUE9SVAkNCiAgCWlu
dCBmaXJzdF9tdWx0aSA9IDA7DQoqKioqKioqKioqKioqKioNCioqKiA2MjcsNjM1ICoqKioNCiAg
CQlmaXJzdF9tdWx0aSA9IGluYihtdWx0aS0+cG9ydF9tb25pdG9yKTsNCiAgI2VuZGlmDQogIA0K
ICAJZG8gew0KICAJCWlmICghaW5mby0+dHR5IHx8DQohIAkJICAgIChzZXJpYWxfaW4oaW5mbywg
VUFSVF9JSVIpICYgVUFSVF9JSVJfTk9fSU5UKSkgew0KICAJCQlpZiAoIWVuZF9tYXJrKQ0KICAJ
CQkJZW5kX21hcmsgPSBpbmZvOw0KICAJCQlnb3RvIG5leHQ7DQotLS0gNjI4LDYzNyAtLS0tDQog
IAkJZmlyc3RfbXVsdGkgPSBpbmIobXVsdGktPnBvcnRfbW9uaXRvcik7DQogICNlbmRpZg0KICAN
CisgCWlpciA9IHNlcmlhbF9pbihpbmZvLCBVQVJUX0lJUik7DQogIAlkbyB7DQogIAkJaWYgKCFp
bmZvLT50dHkgfHwNCiEgCQkgICAgKChpaXIgPSBzZXJpYWxfaW4oaW5mbywgVUFSVF9JSVIpKSAm
IFVBUlRfSUlSX05PX0lOVCkpIHsNCiAgCQkJaWYgKCFlbmRfbWFyaykNCiAgCQkJCWVuZF9tYXJr
ID0gaW5mbzsNCiAgCQkJZ290byBuZXh0Ow0KKioqKioqKioqKioqKioqDQoqKiogNjQ1LDY1MCAq
KioqDQotLS0gNjQ3LDY2MyAtLS0tDQogIAkJaWYgKHN0YXR1cyAmIFVBUlRfTFNSX0RSKQ0KICAJ
CQlyZWNlaXZlX2NoYXJzKGluZm8sICZzdGF0dXMpOw0KICAJCWNoZWNrX21vZGVtX3N0YXR1cyhp
bmZvKTsNCisgI2lmZGVmIENPTkZJR19BTURfRUxBTg0KKyAJCS8qDQorIAkJKiogVGhlcmUgaXMg
YSBidWcgKG1pc2ZlYXR1cmU/KSBpbiB0aGUgVUFSVCBvbiB0aGUgQU1EIEVsYW4NCisgCQkqKiBT
QzR4MCBhbmQgU0M1MjAgZW1iZWRkZWQgcHJvY2Vzc29yIHNlcmllczsgdGhlIFRIUkUgYml0IG9m
DQorIAkJKiogdGhlIGxpbmUgc3RhdHVzIHJlZ2lzdGVyIHNlZW1zIHRvIGJlIGRlbGF5ZWQgb25l
IGJpdA0KKyAJCSoqIGNsb2NrIGFmdGVyIHRoZSBpbnRlcnJ1cHQgaXMgZ2VuZXJhdGVkLCBzbyBr
bHVkZ2UgdGhpcw0KKyAJCSoqIGlmIHRoZSBJSVIgaW5kaWNhdGVzIGEgVHJhbnNtaXQgSG9sZGlu
ZyBSZWdpc3RlciBJbnRlcnJ1cHQNCisgCQkqLw0KKyAJCWlmICgoaWlyICYgVUFSVF9JSVJfSUQp
ID09IFVBUlRfSUlSX1RIUkkpDQorIAkJCXN0YXR1cyB8PSBVQVJUX0xTUl9USFJFOw0KKyAjZW5k
aWYNCiAgCQlpZiAoc3RhdHVzICYgVUFSVF9MU1JfVEhSRSkNCiAgCQkJdHJhbnNtaXRfY2hhcnMo
aW5mbywgMCk7DQogIA0KKioqKioqKioqKioqKioqDQoqKiogNjc5LDY4NSAqKioqDQogICAqLw0K
ICBzdGF0aWMgdm9pZCByc19pbnRlcnJ1cHRfc2luZ2xlKGludCBpcnEsIHZvaWQgKmRldl9pZCwg
c3RydWN0IHB0X3JlZ3MgKiByZWdzKQ0KICB7DQohIAlpbnQgc3RhdHVzOw0KICAJaW50IHBhc3Nf
Y291bnRlciA9IDA7DQogIAlzdHJ1Y3QgYXN5bmNfc3RydWN0ICogaW5mbzsNCiAgI2lmZGVmIENP
TkZJR19TRVJJQUxfTVVMVElQT1JUCQ0KLS0tIDY5Miw2OTggLS0tLQ0KICAgKi8NCiAgc3RhdGlj
IHZvaWQgcnNfaW50ZXJydXB0X3NpbmdsZShpbnQgaXJxLCB2b2lkICpkZXZfaWQsIHN0cnVjdCBw
dF9yZWdzICogcmVncykNCiAgew0KISAJaW50IHN0YXR1cywgaWlyOw0KICAJaW50IHBhc3NfY291
bnRlciA9IDA7DQogIAlzdHJ1Y3QgYXN5bmNfc3RydWN0ICogaW5mbzsNCiAgI2lmZGVmIENPTkZJ
R19TRVJJQUxfTVVMVElQT1JUCQ0KKioqKioqKioqKioqKioqDQoqKiogNzAxLDcwNiAqKioqDQot
LS0gNzE0LDcyMCAtLS0tDQogIAkJZmlyc3RfbXVsdGkgPSBpbmIobXVsdGktPnBvcnRfbW9uaXRv
cik7DQogICNlbmRpZg0KICANCisgCWlpciA9IHNlcmlhbF9pbihpbmZvLCBVQVJUX0lJUik7DQog
IAlkbyB7DQogIAkJc3RhdHVzID0gc2VyaWFsX2lucChpbmZvLCBVQVJUX0xTUik7DQogICNpZmRl
ZiBTRVJJQUxfREVCVUdfSU5UUg0KKioqKioqKioqKioqKioqDQoqKiogNzA5LDcxNCAqKioqDQot
LS0gNzIzLDczOSAtLS0tDQogIAkJaWYgKHN0YXR1cyAmIFVBUlRfTFNSX0RSKQ0KICAJCQlyZWNl
aXZlX2NoYXJzKGluZm8sICZzdGF0dXMpOw0KICAJCWNoZWNrX21vZGVtX3N0YXR1cyhpbmZvKTsN
CisgI2lmZGVmIENPTkZJR19BTURfRUxBTg0KKyAJCS8qDQorIAkJKiogVGhlcmUgaXMgYSBidWcg
KG1pc2ZlYXR1cmU/KSBpbiB0aGUgVUFSVCBvbiB0aGUgQU1EIEVsYW4NCisgCQkqKiBTQzR4MCBh
bmQgU0M1MjAgZW1iZWRkZWQgcHJvY2Vzc29yIHNlcmllczsgdGhlIFRIUkUgYml0IG9mDQorIAkJ
KiogdGhlIGxpbmUgc3RhdHVzIHJlZ2lzdGVyIHNlZW1zIHRvIGJlIGRlbGF5ZWQgb25lIGJpdA0K
KyAJCSoqIGNsb2NrIGFmdGVyIHRoZSBpbnRlcnJ1cHQgaXMgZ2VuZXJhdGVkLCBzbyBrbHVkZ2Ug
dGhpcw0KKyAJCSoqIGlmIHRoZSBJSVIgaW5kaWNhdGVzIGEgVHJhbnNtaXQgSG9sZGluZyBSZWdp
c3RlciBJbnRlcnJ1cHQNCisgCQkqLw0KKyAJCWlmICgoaWlyICYgVUFSVF9JSVJfSUQpID09IFVB
UlRfSUlSX1RIUkkpDQorIAkJCXN0YXR1cyB8PSBVQVJUX0xTUl9USFJFOw0KKyAjZW5kaWYNCiAg
CQlpZiAoc3RhdHVzICYgVUFSVF9MU1JfVEhSRSkNCiAgCQkJdHJhbnNtaXRfY2hhcnMoaW5mbywg
MCk7DQogIAkJaWYgKHBhc3NfY291bnRlcisrID4gUlNfSVNSX1BBU1NfTElNSVQpIHsNCioqKioq
KioqKioqKioqKg0KKioqIDcxNyw3MjMgKioqKg0KICAjZW5kaWYNCiAgCQkJYnJlYWs7DQogIAkJ
fQ0KISAJfSB3aGlsZSAoIShzZXJpYWxfaW4oaW5mbywgVUFSVF9JSVIpICYgVUFSVF9JSVJfTk9f
SU5UKSk7DQogIAlpbmZvLT5sYXN0X2FjdGl2ZSA9IGppZmZpZXM7DQogICNpZmRlZiBDT05GSUdf
U0VSSUFMX01VTFRJUE9SVAkNCiAgCWlmIChtdWx0aS0+cG9ydF9tb25pdG9yKQ0KLS0tIDc0Miw3
NDggLS0tLQ0KICAjZW5kaWYNCiAgCQkJYnJlYWs7DQogIAkJfQ0KISAJfSB3aGlsZSAoISgoaWly
ID0gc2VyaWFsX2luKGluZm8sIFVBUlRfSUlSKSkgJiBVQVJUX0lJUl9OT19JTlQpKTsNCiAgCWlu
Zm8tPmxhc3RfYWN0aXZlID0gamlmZmllczsNCiAgI2lmZGVmIENPTkZJR19TRVJJQUxfTVVMVElQ
T1JUCQ0KICAJaWYgKG11bHRpLT5wb3J0X21vbml0b3IpDQo=

--------------Boundary-00=_GYJJ32HA1OBBG12CVE3K--
