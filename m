Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318799AbSIOWhW>; Sun, 15 Sep 2002 18:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318599AbSIOWhQ>; Sun, 15 Sep 2002 18:37:16 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:35543 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318295AbSIOWhE>; Sun, 15 Sep 2002 18:37:04 -0400
Date: Sun, 15 Sep 2002 18:41:54 -0400 (EDT)
From: Albert Cranford <ac9410@attbi.com>
X-X-Sender: ac9410@home1
Reply-To: Albert Cranford <ac9410@attbi.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch 5/9]Four new i2c drivers and __init/__exit cleanup to i2c
Message-ID: <Pine.LNX.4.44.0209151840510.7637-200000@home1>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1048217028-1032129714=:7637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1048217028-1032129714=:7637
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello Linus,
New I2C drivers that have been adjusted after Russell King comments of August.
o i2c-algo-8xx.c
o i2c-pport.c
o i2c-adap-ibm_ocp.c
o i2c-pcf-epp.c
o Add new drivers to Config.in and Makefile.
o Add new drivers to i2c-core for initialization.
o Remove EXPORT_NO_SYMBOLS statement from i2c-dev, i2c-elektor and i2c-frodo.
o Cleanup init_module and cleanup_module adding __init and __exit to most drivers.
o Adjust i2c-elektor with cli/sti replacement.
-- 
ac9410@attbi.com

--0-1048217028-1032129714=:7637
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=47-i2c-5-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209151841540.7637@home1>
Content-Description: 
Content-Disposition: attachment; filename=47-i2c-5-patch

LS0tIGxpbnV4L2RyaXZlcnMvaTJjL0NvbmZpZy5pbi5vcmlnCTIwMDItMDkt
MTAgMjI6Mjg6MzIuMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi41LjM0
L2RyaXZlcnMvaTJjL0NvbmZpZy5pbgkyMDAyLTA5LTEwIDIyOjI4OjEyLjAw
MDAwMDAwMCAtMDQwMA0KQEAgLTEzLDExICsxMywxNiBAQA0KICAgICAgIGRl
cF90cmlzdGF0ZSAnICBQaGlsaXBzIHN0eWxlIHBhcmFsbGVsIHBvcnQgYWRh
cHRlcicgQ09ORklHX0kyQ19QSElMSVBTUEFSICRDT05GSUdfSTJDX0FMR09C
SVQgJENPTkZJR19QQVJQT1JUDQogICAgICAgZGVwX3RyaXN0YXRlICcgIEVM
ViBhZGFwdGVyJyBDT05GSUdfSTJDX0VMViAkQ09ORklHX0kyQ19BTEdPQklU
DQogICAgICAgZGVwX3RyaXN0YXRlICcgIFZlbGxlbWFuIEs5MDAwIGFkYXB0
ZXInIENPTkZJR19JMkNfVkVMTEVNQU4gJENPTkZJR19JMkNfQUxHT0JJVA0K
KyAgICAgIGRlcF90cmlzdGF0ZSAnICBCYXNpYyBJMkMgb24gUGFyYWxsZWwg
UG9ydCcgQ09ORklHX0kyQ19QUE9SVCAkQ09ORklHX0kyQ19BTEdPQklUDQor
ICAgICAgaWYgWyAiJENPTkZJR19BUkNIX1NBMTEwMCIgPSAieSIgXTsgdGhl
bg0KKyAgICAgICAgIGRlcF90cmlzdGF0ZSAnU0ExMTAwIEkyQyBBZGFwdGVy
JyBDT05GSUdfSTJDX0ZST0RPICRDT05GSUdfSTJDX0FMR09CSVQNCisgICAg
ICBmaQ0KICAgIGZpDQogDQogICAgZGVwX3RyaXN0YXRlICdJMkMgUENGIDg1
ODQgaW50ZXJmYWNlcycgQ09ORklHX0kyQ19BTEdPUENGICRDT05GSUdfSTJD
DQogICAgaWYgWyAiJENPTkZJR19JMkNfQUxHT1BDRiIgIT0gIm4iIF07IHRo
ZW4NCiAgICAgICBkZXBfdHJpc3RhdGUgJyAgRWxla3RvciBJU0EgY2FyZCcg
Q09ORklHX0kyQ19FTEVLVE9SICRDT05GSUdfSTJDX0FMR09QQ0YNCisgICAg
ICBkZXBfdHJpc3RhdGUgJyAgUENGIG9uIEVQUCBwb3J0JyBDT05GSUdfSTJD
X1BDRkVQUCAkQ09ORklHX0kyQ19BTEdPUENGDQogICAgZmkNCiANCiAgICBp
ZiBbICIkQ09ORklHX01JUFNfSVRFODE3MiIgPSAieSIgXTsgdGhlbg0KLS0t
IGxpbnV4L2RyaXZlcnMvaTJjL01ha2VmaWxlLm9yaWcJMjAwMi0wOS0xMSAw
MDozNzo1MS4wMDAwMDAwMDAgLTA0MDANCisrKyBsaW51eC0yLjUuMzQvZHJp
dmVycy9pMmMvTWFrZWZpbGUJMjAwMi0wOS0xMSAyMjo0NTo1OC4wMDAwMDAw
MDAgLTA0MDANCkBAIC0xMSwxMCArMTEsMTYgQEANCiBvYmotJChDT05GSUdf
STJDX1BISUxJUFNQQVIpCSs9IGkyYy1waGlsaXBzLXBhci5vDQogb2JqLSQo
Q09ORklHX0kyQ19FTFYpCQkrPSBpMmMtZWx2Lm8NCiBvYmotJChDT05GSUdf
STJDX1ZFTExFTUFOKQkrPSBpMmMtdmVsbGVtYW4ubw0KK29iai0kKENPTkZJ
R19JMkNfUFBPUlQpCQkrPSBpMmMtcHBvcnQubw0KK29iai0kKENPTkZJR19J
MkNfRlJPRE8pCQkrPSBpMmMtZnJvZG8ubw0KIG9iai0kKENPTkZJR19JMkNf
QUxHT1BDRikJKz0gaTJjLWFsZ28tcGNmLm8NCiBvYmotJChDT05GSUdfSTJD
X0VMRUtUT1IpCSs9IGkyYy1lbGVrdG9yLm8NCitvYmotJChDT05GSUdfSTJD
X1BDRkVQUCkJKz0gaTJjLXBjZi1lcHAubw0KIG9iai0kKENPTkZJR19JVEVf
STJDX0FMR08pCSs9IGkyYy1hbGdvLWl0ZS5vDQogb2JqLSQoQ09ORklHX0lU
RV9JMkNfQURBUCkJKz0gaTJjLWFkYXAtaXRlLm8NCitvYmotJChDT05GSUdf
STJDX0FMR084WFgpCSs9IGkyYy1hbGdvLTh4eC5vDQorb2JqLSQoQ09ORklH
X0kyQ19JQk1fT0NQX0FMR08pCSs9IGkyYy1hbGdvLWlibV9vY3Aubw0KK29i
ai0kKENPTkZJR19JMkNfSUJNX09DUF9BREFQKQkrPSBpMmMtYWRhcC1pYm1f
b2NwLm8NCiBvYmotJChDT05GSUdfSTJDX1BST0MpCQkrPSBpMmMtcHJvYy5v
DQogDQogIyBUaGlzIGlzIG5lZWRlZCBmb3IgYXV0b21hdGljIHBhdGNoIGdl
bmVyYXRpb246IHNlbnNvcnMgY29kZSBzdGFydHMgaGVyZQ0K
--0-1048217028-1032129714=:7637--
