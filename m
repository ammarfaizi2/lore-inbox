Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313334AbSDMMsE>; Sat, 13 Apr 2002 08:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313450AbSDMMsD>; Sat, 13 Apr 2002 08:48:03 -0400
Received: from pe-zf-01.sjc.nl ([213.84.91.21]:36356 "EHLO pe-zf-01.sjc.nl")
	by vger.kernel.org with ESMTP id <S313334AbSDMMsB>;
	Sat, 13 Apr 2002 08:48:01 -0400
Date: Sat, 13 Apr 2002 14:47:52 +0200 (CEST)
From: Stijn Jonker <sjcjonker@sjc.nl>
X-X-Sender: sjonker@ph-wks-01.sjc.nl
To: linux-kernel@vger.kernel.org
Cc: andrewm@uow.edu.au
Subject: PATCH: 3c59x.c LK1.1.16 / Kernel 2.4.17
Message-ID: <Pine.LNX.4.44.0204131440130.31560-200000@ph-wks-01.sjc.nl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1455132787-1018702072=:31560"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1455132787-1018702072=:31560
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,

This attached patch, will change the mtu size of a specific network card 
to 1504 therefor supporting the receiption of packets with vlan tagging.

This can be done when the module is loaded and uses the option vlan, this 
option is setup the same way as the "options" and "full_duplex" options 
so:

vlan=1,0,1 will set the mtu to 1504 for the first and third card found.

It works for me, in a quick test, as i'm far from a C knowledgable person, 
I have no idea how this can impact other area's of the driver, I found 
some checking for the packet size being over 1500. But like i said have no 
clue about the impact.

P.S. This is my first kernel patch, if there is anything wrong with it let 
me know.


P.S.2. I'm not on the linux-kernel ml, could you cc the replies? Thanks in 
advance.

Met Vriendelijke groet/Yours Sincerely
Stijn Jonker <SJCJonker AT sjc.nl>

- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8uCj6H0P/oLuWBrcRAphAAJsGaApWJ1DGG4NcwS5mFtvQ/d06XACfSNT/
s7YW4Ju9ODsMKmyLQNu2jMU=
=UYdk
-----END PGP SIGNATURE-----

--8323328-1455132787-1018702072=:31560
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="3c59x.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="3c59x.patch"

LS0tIGxpbnV4LTIuNC4xNy1vcmlnL2RyaXZlcnMvbmV0LzNjNTl4LmMJU2F0
IEFwciAxMyAxNDoxMjo0MCAyMDAyDQorKysgbGludXgtMi40LjE3L2RyaXZl
cnMvbmV0LzNjNTl4LmMJU2F0IEFwciAxMyAxNDozNjo1MCAyMDAyDQpAQCAt
MTY1LDYgKzE2NSw5IEBADQogICAgIC0gQ29ycmVjdCAzYzk4MiBpZGVudGlm
aWNhdGlvbiBzdHJpbmcNCiAgICAgLSBSZW5hbWUgd2FpdF9mb3JfY29tcGxl
dGlvbigpIHRvIGlzc3VlX2FuZF93YWl0KCkgdG8gYXZvaWQgY29tcGxldGlv
bi5oDQogICAgICAgY2xhc2guDQorICAgDQorICAgTEsxLjEuMTYtc2pjIDEz
IEFwcmlsIDIwMDIgU3Rpam4gSm9ua2VyDQorICAgIC0gQWRkZWQgcGVyIGRl
dmljZSB2bGFuIHN1cHBvcnQvbXR1IGNoYW5naW5nIHRvIDE1MDQuDQogDQog
ICAgIC0gU2VlIGh0dHA6Ly93d3cudW93LmVkdS5hdS9+YW5kcmV3bS9saW51
eC8jM2M1OXgtMi4zIGZvciBtb3JlIGRldGFpbHMuDQogICAgIC0gQWxzbyBz
ZWUgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL3ZvcnRleC50eHQNCkBAIC0x
ODEsNyArMTg0LDcgQEANCiANCiANCiAjZGVmaW5lIERSVl9OQU1FCSIzYzU5
eCINCi0jZGVmaW5lIERSVl9WRVJTSU9OCSJMSzEuMS4xNiINCisjZGVmaW5l
IERSVl9WRVJTSU9OCSJMSzEuMS4xNi1zamMiDQogI2RlZmluZSBEUlZfUkVM
REFURQkiMTkgSnVseSAyMDAxIg0KIA0KIA0KQEAgLTIwNCw2ICsyMDcsNyBA
QA0KICNlbmRpZg0KIC8qIEFsbG93IHNldHRpbmcgTVRVIHRvIGEgbGFyZ2Vy
IHNpemUsIGJ5cGFzc2luZyB0aGUgbm9ybWFsIGV0aGVybmV0IHNldHVwLiAq
Lw0KIHN0YXRpYyBjb25zdCBpbnQgbXR1ID0gMTUwMDsNCitzdGF0aWMgY29u
c3QgaW50IHZtdHUgPSAxNTA0Ow0KIC8qIE1heGltdW0gZXZlbnRzIChSeCBw
YWNrZXRzLCBldGMuKSB0byBoYW5kbGUgYXQgZWFjaCBpbnRlcnJ1cHQuICov
DQogc3RhdGljIGludCBtYXhfaW50ZXJydXB0X3dvcmsgPSAzMjsNCiAvKiBU
eCB0aW1lb3V0IGludGVydmFsIChtaWxsaXNlY3MpICovDQpAQCAtMjc1LDYg
KzI3OSw3IEBADQogTU9EVUxFX1BBUk0oaHdfY2hlY2tzdW1zLCAiMS0iIF9f
TU9EVUxFX1NUUklORyg4KSAiaSIpOw0KIE1PRFVMRV9QQVJNKGZsb3dfY3Ry
bCwgIjEtIiBfX01PRFVMRV9TVFJJTkcoOCkgImkiKTsNCiBNT0RVTEVfUEFS
TShlbmFibGVfd29sLCAiMS0iIF9fTU9EVUxFX1NUUklORyg4KSAiaSIpOw0K
K01PRFVMRV9QQVJNKHZsYW4sICIxLSIgX19NT0RVTEVfU1RSSU5HKDgpICJp
Iik7DQogTU9EVUxFX1BBUk0ocnhfY29weWJyZWFrLCAiaSIpOw0KIE1PRFVM
RV9QQVJNKG1heF9pbnRlcnJ1cHRfd29yaywgImkiKTsNCiBNT0RVTEVfUEFS
TShjb21wYXFfaW9hZGRyLCAiaSIpOw0KQEAgLTI4Nyw2ICsyOTIsNyBAQA0K
IE1PRFVMRV9QQVJNX0RFU0MoaHdfY2hlY2tzdW1zLCAiM2M1OXggSGFyZHdh
cmUgY2hlY2tzdW0gY2hlY2tpbmcgYnkgYWRhcHRlcihzKSAoMC0xKSIpOw0K
IE1PRFVMRV9QQVJNX0RFU0MoZmxvd19jdHJsLCAiM2M1OXggODAyLjN4IGZs
b3cgY29udHJvbCB1c2FnZSAoUEFVU0Ugb25seSkgKDAtMSkiKTsNCiBNT0RV
TEVfUEFSTV9ERVNDKGVuYWJsZV93b2wsICIzYzU5eDogVHVybiBvbiBXYWtl
LW9uLUxBTiBmb3IgYWRhcHRlcihzKSAoMC0xKSIpOw0KK01PRFVMRV9QQVJN
X0RFU0ModmxhbiwgIkNoYW5nZSBtdHUgdG8gMTUwNCBmb3IgdGhlIHNwZWNp
ZmljIGNhcmQgdG8gYWxsb3cgdmxhbiB0YWdzIHRvIGJlIHByb2Nlc3NlZCIp
Ow0KIE1PRFVMRV9QQVJNX0RFU0MocnhfY29weWJyZWFrLCAiM2M1OXggY29w
eSBicmVha3BvaW50IGZvciBjb3B5LW9ubHktdGlueS1mcmFtZXMiKTsNCiBN
T0RVTEVfUEFSTV9ERVNDKG1heF9pbnRlcnJ1cHRfd29yaywgIjNjNTl4IG1h
eGltdW0gZXZlbnRzIGhhbmRsZWQgcGVyIGludGVycnVwdCIpOw0KIE1PRFVM
RV9QQVJNX0RFU0MoY29tcGFxX2lvYWRkciwgIjNjNTl4IFBDSSBJL08gYmFz
ZSBhZGRyZXNzIChDb21wYXEgQklPUyBwcm9ibGVtIHdvcmthcm91bmQpIik7
DQpAQCAtNzkwLDYgKzc5Niw3IEBADQogCXNwaW5sb2NrX3QgbG9jazsJCQkJ
CS8qIFNlcmlhbGlzZSBhY2Nlc3MgdG8gZGV2aWNlICYgaXRzIHZvcnRleF9w
cml2YXRlICovDQogCXNwaW5sb2NrX3QgbWRpb19sb2NrOwkJCQkvKiBTZXJp
YWxpc2UgYWNjZXNzIHRvIG1kaW8gaGFyZHdhcmUgKi8NCiAJdTMyIHBvd2Vy
X3N0YXRlWzE2XTsNCisJaW50IHZsYW47CQkJCQkJLyogVXNlci1zZXR0YWJs
ZSB2bGFuIHN1cHBvcnQuICovDQogfTsNCiANCiAvKiBUaGUgYWN0aW9uIHRv
IHRha2Ugd2l0aCBhIG1lZGlhIHNlbGVjdGlvbiB0aW1lciB0aWNrLg0KQEAg
LTg1Myw2ICs4NjAsNyBAQA0KIHN0YXRpYyBpbnQgaHdfY2hlY2tzdW1zW01B
WF9VTklUU10gPSB7LTEsIC0xLCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xfTsN
CiBzdGF0aWMgaW50IGZsb3dfY3RybFtNQVhfVU5JVFNdID0gey0xLCAtMSwg
LTEsIC0xLCAtMSwgLTEsIC0xLCAtMX07DQogc3RhdGljIGludCBlbmFibGVf
d29sW01BWF9VTklUU10gPSB7LTEsIC0xLCAtMSwgLTEsIC0xLCAtMSwgLTEs
IC0xfTsNCitzdGF0aWMgaW50IHZsYW5bTUFYX1VOSVRTXSA9IHsgLTEsIC0x
LCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xLH07DQogDQogLyogI2RlZmluZSBk
ZXZfYWxsb2Nfc2tiIGRldl9hbGxvY19za2JfZGVidWcgKi8NCiANCkBAIC0x
MDI5LDcgKzEwMzcsMTEgQEANCiANCiAJZGV2LT5iYXNlX2FkZHIgPSBpb2Fk
ZHI7DQogCWRldi0+aXJxID0gaXJxOw0KLQlkZXYtPm10dSA9IG10dTsNCisJ
aWYgKGNhcmRfaWR4IDwgTUFYX1VOSVRTICYmIHZsYW5bY2FyZF9pZHhdID4g
MCApIHsNCisJCWRldi0+bXR1ID0gdm10dTsNCisJfSBlbHNlIHsNCisJCWRl
di0+bXR1ID0gbXR1Ow0KKwl9DQogCXZwLT5kcnZfZmxhZ3MgPSB2Y2ktPmRy
dl9mbGFnczsNCiAJdnAtPmhhc19ud2F5ID0gKHZjaS0+ZHJ2X2ZsYWdzICYg
SEFTX05XQVkpID8gMSA6IDA7DQogCXZwLT5pb19zaXplID0gdmNpLT5pb19z
aXplOw0K
--8323328-1455132787-1018702072=:31560--
