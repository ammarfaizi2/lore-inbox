Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSIOWgC>; Sun, 15 Sep 2002 18:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSIOWgB>; Sun, 15 Sep 2002 18:36:01 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:59347 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318285AbSIOWfv>; Sun, 15 Sep 2002 18:35:51 -0400
Date: Sun, 15 Sep 2002 18:40:42 -0400 (EDT)
From: Albert Cranford <ac9410@attbi.com>
X-X-Sender: ac9410@home1
Reply-To: Albert Cranford <ac9410@attbi.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch 5/9]Four new i2c drivers and __init/__exit cleanup to i2c
Message-ID: <Pine.LNX.4.44.0209151839190.7637-200000@home1>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-474002181-1032129642=:7637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-474002181-1032129642=:7637
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

--0-474002181-1032129642=:7637
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=47-i2c-4-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209151840420.7637@home1>
Content-Description: 
Content-Disposition: attachment; filename=47-i2c-4-patch

LS0tIGxpbnV4L2RyaXZlcnMvaTJjL2kyYy1kZXYuYy5vcmlnCTIwMDItMDkt
MDUgMTE6MjM6MzguMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi41LjM0
L2RyaXZlcnMvaTJjL2kyYy1kZXYuYwkyMDAyLTA5LTA1IDExOjI1OjIxLjAw
MDAwMDAwMCAtMDQwMA0KQEAgLTU0NCw4ICs1NDQsNiBAQA0KIAlyZXR1cm4g
MDsNCiB9DQogDQotRVhQT1JUX05PX1NZTUJPTFM7DQotDQogI2lmZGVmIE1P
RFVMRQ0KIA0KIE1PRFVMRV9BVVRIT1IoIkZyb2RvIExvb2lqYWFyZCA8ZnJv
ZG9sQGRkcy5ubD4gYW5kIFNpbW9uIEcuIFZvZ2wgPHNpbW9uQHRrLnVuaS1s
aW56LmFjLmF0PiIpOw0KLS0tIGxpbnV4L2RyaXZlcnMvaTJjL2kyYy1lbGVr
dG9yLmMub3JpZwkyMDAyLTA5LTEwIDIyOjMxOjM0LjAwMDAwMDAwMCAtMDQw
MA0KKysrIGxpbnV4LTIuNS4zNC9kcml2ZXJzL2kyYy9pMmMtZWxla3Rvci5j
CTIwMDItMDktMTAgMjI6MzE6NTguMDAwMDAwMDAwIC0wNDAwDQpAQCAtMjkx
LDggKzI5MSw2IEBADQogCXJldHVybiAwOw0KIH0NCiANCi1FWFBPUlRfTk9f
U1lNQk9MUzsNCi0NCiAjaWZkZWYgTU9EVUxFDQogTU9EVUxFX0FVVEhPUigi
SGFucyBCZXJnbHVuZCA8aGJAc3BhY2V0ZWMubm8+Iik7DQogTU9EVUxFX0RF
U0NSSVBUSU9OKCJJMkMtQnVzIGFkYXB0ZXIgcm91dGluZXMgZm9yIFBDRjg1
ODQgSVNBIGJ1cyBhZGFwdGVyIik7DQotLS0gbGludXgvZHJpdmVycy9pMmMv
aTJjLWZyb2RvLmMub3JpZwkyMDAyLTA5LTA1IDExOjIzOjU5LjAwMDAwMDAw
MCAtMDQwMA0KKysrIGxpbnV4LTIuNS4zNC9kcml2ZXJzL2kyYy9pMmMtZnJv
ZG8uYwkyMDAyLTA5LTA1IDExOjI1OjI4LjAwMDAwMDAwMCAtMDQwMA0KQEAg
LTk3LDggKzk3LDYgQEANCiAJcmV0dXJuIChpMmNfYml0X2FkZF9idXMgKCZm
cm9kb19vcHMpKTsNCiB9DQogDQotRVhQT1JUX05PX1NZTUJPTFM7DQotDQog
c3RhdGljIHZvaWQgX19leGl0IGkyY19mcm9kb19leGl0ICh2b2lkKQ0KIHsN
CiAJaTJjX2JpdF9kZWxfYnVzICgmZnJvZG9fb3BzKTsNCkBAIC0xMTEsOCAr
MTA5LDYgQEANCiBNT0RVTEVfTElDRU5TRSAoIkdQTCIpOw0KICNlbmRpZgkv
KiAjaWZkZWYgTU9EVUxFX0xJQ0VOU0UgKi8NCiANCi1FWFBPUlRfTk9fU1lN
Qk9MUzsNCi0NCiBtb2R1bGVfaW5pdCAoaTJjX2Zyb2RvX2luaXQpOw0KIG1v
ZHVsZV9leGl0IChpMmNfZnJvZG9fZXhpdCk7DQogDQo=
--0-474002181-1032129642=:7637--
