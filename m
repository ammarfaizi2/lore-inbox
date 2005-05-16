Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVEPR0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVEPR0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVEPR0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:26:17 -0400
Received: from alog0086.analogic.com ([208.224.220.101]:12502 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261767AbVEPR0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:26:09 -0400
Date: Mon, 16 May 2005 13:25:53 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Patch -Wshadow jiffies.h
Message-ID: <Pine.LNX.4.61.0505161323450.7164@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-78814821-1116264353=:7164"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-78814821-1116264353=:7164
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


Many developers use -Wshadow when compiling so that they
don't accidentally use some global variable. Recent kernels
are compiled without this so some headers ended up with
local variables that shadow global ones.

Here is a patch for linux-2.6.11.9 that changes two variable
names in jiffies.h. This was previously submitted, but ignored.

The trivial patch is attached. Hopefully our global M$ mailer
doesn't kill it.

Signed-off-by: Richard B. Johnson linux-os@analogic.com


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-78814821-1116264353=:7164
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="jiffie.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0505161325530.7164@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="jiffie.patch"

LS0tIGxpbnV4LTIuNi4xMS45L2luY2x1ZGUvbGludXgvamlmZmllcy5oLm9y
aWcJMjAwNS0wNS0xNiAxMzowNzoyOS4wMDAwMDAwMDAgLTA0MDANCisrKyBs
aW51eC0yLjYuMTEuOS9pbmNsdWRlL2xpbnV4L2ppZmZpZXMuaAkyMDA1LTA1
LTE2IDEzOjEwOjIyLjAwMDAwMDAwMCAtMDQwMA0KQEAgLTMyOCwxMyArMzI4
LDEzIEBADQogfQ0KIA0KIHN0YXRpYyBfX2lubGluZV9fIHZvaWQNCi1qaWZm
aWVzX3RvX3RpbWVzcGVjKGNvbnN0IHVuc2lnbmVkIGxvbmcgamlmZmllcywg
c3RydWN0IHRpbWVzcGVjICp2YWx1ZSkNCitqaWZmaWVzX3RvX3RpbWVzcGVj
KGNvbnN0IHVuc2lnbmVkIGxvbmcgamlmZnksIHN0cnVjdCB0aW1lc3BlYyAq
dmFsdWUpDQogew0KIAkvKg0KIAkgKiBDb252ZXJ0IGppZmZpZXMgdG8gbmFu
b3NlY29uZHMgYW5kIHNlcGFyYXRlIHdpdGgNCiAJICogb25lIGRpdmlkZS4N
CiAJICovDQotCXU2NCBuc2VjID0gKHU2NClqaWZmaWVzICogVElDS19OU0VD
Ow0KKwl1NjQgbnNlYyA9ICh1NjQpamlmZnkgKiBUSUNLX05TRUM7DQogCXZh
bHVlLT50dl9zZWMgPSBkaXZfbG9uZ19sb25nX3JlbShuc2VjLCBOU0VDX1BF
Ul9TRUMsICZ2YWx1ZS0+dHZfbnNlYyk7DQogfQ0KIA0KQEAgLTM2NiwxMyAr
MzY2LDEzIEBADQogfQ0KIA0KIHN0YXRpYyBfX2lubGluZV9fIHZvaWQNCi1q
aWZmaWVzX3RvX3RpbWV2YWwoY29uc3QgdW5zaWduZWQgbG9uZyBqaWZmaWVz
LCBzdHJ1Y3QgdGltZXZhbCAqdmFsdWUpDQoramlmZmllc190b190aW1ldmFs
KGNvbnN0IHVuc2lnbmVkIGxvbmcgamlmZnksIHN0cnVjdCB0aW1ldmFsICp2
YWx1ZSkNCiB7DQogCS8qDQogCSAqIENvbnZlcnQgamlmZmllcyB0byBuYW5v
c2Vjb25kcyBhbmQgc2VwYXJhdGUgd2l0aA0KIAkgKiBvbmUgZGl2aWRlLg0K
IAkgKi8NCi0JdTY0IG5zZWMgPSAodTY0KWppZmZpZXMgKiBUSUNLX05TRUM7
DQorCXU2NCBuc2VjID0gKHU2NClqaWZmeSAqIFRJQ0tfTlNFQzsNCiAJdmFs
dWUtPnR2X3NlYyA9IGRpdl9sb25nX2xvbmdfcmVtKG5zZWMsIE5TRUNfUEVS
X1NFQywgJnZhbHVlLT50dl91c2VjKTsNCiAJdmFsdWUtPnR2X3VzZWMgLz0g
TlNFQ19QRVJfVVNFQzsNCiB9DQo=

--1879706418-78814821-1116264353=:7164--
