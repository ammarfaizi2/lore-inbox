Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318806AbSIOWjM>; Sun, 15 Sep 2002 18:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318807AbSIOWjM>; Sun, 15 Sep 2002 18:39:12 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:20881 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318806AbSIOWjJ>; Sun, 15 Sep 2002 18:39:09 -0400
Date: Sun, 15 Sep 2002 18:43:58 -0400 (EDT)
From: Albert Cranford <ac9410@attbi.com>
X-X-Sender: ac9410@home1
Reply-To: Albert Cranford <ac9410@attbi.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch 7/9]Four new i2c drivers and __init/__exit cleanup to i2c
Message-ID: <Pine.LNX.4.44.0209151842090.7637-200000@home1>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1231093406-1032129838=:7637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1231093406-1032129838=:7637
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

--0-1231093406-1032129838=:7637
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=47-i2c-6-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209151843580.7637@home1>
Content-Description: 
Content-Disposition: attachment; filename=47-i2c-6-patch

LS0tIGxpbnV4L2RyaXZlcnMvaTJjL2kyYy1jb3JlLmMub3JpZwkyMDAyLTA5
LTEwIDIzOjExOjA0LjAwMDAwMDAwMCAtMDQwMA0KKysrIGxpbnV4LTIuNS4z
NC9kcml2ZXJzL2kyYy9pMmMtY29yZS5jCTIwMDItMDktMTEgMjI6NTA6Mjku
MDAwMDAwMDAwIC0wNDAwDQpAQCAtMTUwOCw2ICsxNTA4LDEyIEBADQogI2lm
ZGVmIENPTkZJR19JMkNfVkVMTEVNQU4NCiAJZXh0ZXJuIGludCBpMmNfYml0
dmVsbGVfaW5pdCh2b2lkKTsNCiAjZW5kaWYNCisjaWZkZWYgQ09ORklHX0ky
Q19QUE9SVA0KKwlleHRlcm4gaW50IGkyY19iaXRwcG9ydF9pbml0KHZvaWQp
Ow0KKyNlbmRpZg0KKyNpZmRlZiBDT05GSUdfSTJDX0ZST0RPDQorCWV4dGVy
biBpbnQgaTJjX2Zyb2RvX2luaXQodm9pZCk7DQorI2VuZGlmDQogI2lmZGVm
IENPTkZJR19JMkNfQklUVklBDQogCWV4dGVybiBpbnQgaTJjX2JpdHZpYV9p
bml0KHZvaWQpOw0KICNlbmRpZg0KQEAgLTE1MTgsNiArMTUyNCw5IEBADQog
I2lmZGVmIENPTkZJR19JMkNfRUxFS1RPUg0KIAlleHRlcm4gaW50IGkyY19w
Y2Zpc2FfaW5pdCh2b2lkKTsNCiAjZW5kaWYNCisjaWZkZWYgQ09ORklHX0ky
Q19QQ0ZFUFANCisJZXh0ZXJuIGludCBpMmNfcGNmZXBwX2luaXQodm9pZCk7
DQorI2VuZGlmDQogDQogI2lmZGVmIENPTkZJR19JMkNfQUxHTzhYWA0KIAll
eHRlcm4gaW50IGkyY19hbGdvXzh4eF9pbml0KHZvaWQpOw0KQEAgLTE1MjUs
NiArMTUzNCwxMiBAQA0KICNpZmRlZiBDT05GSUdfSTJDX1JQWExJVEUNCiAJ
ZXh0ZXJuIGludCBpMmNfcnB4X2luaXQodm9pZCk7DQogI2VuZGlmDQorI2lm
ZGVmIENPTkZJR19JMkNfSUJNX09DUF9BTEdPDQorCWV4dGVybiBpbnQgaTJj
X2FsZ29faWljX2luaXQodm9pZCk7DQorI2VuZGlmDQorI2lmZGVmIENPTkZJ
R19JMkNfSUJNX09DUF9BREFQDQorCWV4dGVybiBpbnQgaWljX2libW9jcF9p
bml0KHZvaWQpOw0KKyNlbmRpZg0KICNpZmRlZiBDT05GSUdfSTJDX1BST0MN
CiAJZXh0ZXJuIGludCBzZW5zb3JzX2luaXQodm9pZCk7DQogI2VuZGlmDQpA
QCAtMTU1Myw2ICsxNTY4LDE1IEBADQogI2lmZGVmIENPTkZJR19JMkNfVkVM
TEVNQU4NCiAJaTJjX2JpdHZlbGxlX2luaXQoKTsNCiAjZW5kaWYNCisjaWZk
ZWYgQ09ORklHX0kyQ19QUE9SVA0KKwlpMmNfYml0cHBvcnRfaW5pdCgpOw0K
KyNlbmRpZg0KKyNpZmRlZiBDT05GSUdfSTJDX0ZST0RPDQorCWkyY19mcm9k
b19pbml0KCk7DQorI2VuZGlmDQorI2lmZGVmIENPTkZJR19JMkNfQklUVklB
DQorCWkyY19iaXR2aWFfaW5pdCgpOw0KKyNlbmRpZg0KIA0KIAkvKiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0gcGNmIC0tLS0tLS0tICovDQogI2lmZGVmIENP
TkZJR19JMkNfQUxHT1BDRg0KQEAgLTE1NjEsNiArMTU4NSw5IEBADQogI2lm
ZGVmIENPTkZJR19JMkNfRUxFS1RPUg0KIAlpMmNfcGNmaXNhX2luaXQoKTsN
CiAjZW5kaWYNCisjaWZkZWYgQ09ORklHX0kyQ19QQ0ZFUFANCisJaTJjX3Bj
ZmVwcF9pbml0KCk7DQorI2VuZGlmDQogDQogCS8qIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLSA4eHggLS0tLS0tLS0gKi8NCiAjaWZkZWYgQ09ORklHX0kyQ19B
TEdPOFhYDQpAQCAtMTU2OSw2ICsxNTk2LDEyIEBADQogI2lmZGVmIENPTkZJ
R19JMkNfUlBYTElURQ0KIAlpMmNfcnB4X2luaXQoKTsNCiAjZW5kaWYNCisj
aWZkZWYgQ09ORklHX0kyQ19JQk1fT0NQX0FMR08NCisJaTJjX2FsZ29faWlj
X2luaXQoKTsNCisjZW5kaWYNCisjaWZkZWYgQ09ORklHX0kyQ19JQk1fT0NQ
X0FEQVANCisJaWljX2libW9jcF9pbml0KCk7DQorI2VuZGlmDQogDQogCS8q
IC0tLS0tLS0tLS0tLS0tIHByb2MgaW50ZXJmYWNlIC0tLS0gKi8NCiAjaWZk
ZWYgQ09ORklHX0kyQ19QUk9DDQo=
--0-1231093406-1032129838=:7637--
