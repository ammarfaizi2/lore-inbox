Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbUKDHQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUKDHQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUKDHPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:15:48 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:6285 "EHLO
	webhosting.rdsbv.ro") by vger.kernel.org with ESMTP id S262112AbUKDHJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:09:22 -0500
Date: Thu, 4 Nov 2004 09:08:57 +0200 (EET)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@webhosting.rdsbv.ro
To: jdike@karaya.com, blaisorblade_spam@yahoo.it, linux-kernel@vger.kernel.org
cc: user-mode-linux-user@lists.sourceforge.net
Subject: [PATCH] extend the limits for command line 
Message-ID: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-1646943047-1721268723-1098826471=:22912"
Content-ID: <Pine.LNX.4.61.0411040859131.18123@webhosting.rdsbv.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1646943047-1721268723-1098826471=:22912
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.61.0411040859132.18123@webhosting.rdsbv.ro>

Hello!

(I resend this because I get no feedback.)

Testing UML on my project, I hit the limit for command line with something like 
this:

default \
         mem=64M \
         ubda=COW,/data/UML4/roots/ROOT1 \
         ubdb=SWAP \
         ubdc=CONF.tar \
         ${HSSTR} \
         eth0=daemon,fe:fd:39:bd:cc:d7,,/data/UML4/conf/example1/socks/SW1 
eth1=daemon,fe:fd:01:01:01:12,,/data/UML4/conf/example1/socks/SW2 
eth2=daemon,fe:fd:01:01:01:99,,/data/UML4/conf/example1/socks/SW4 
eth3=daemon,fe:fd:01:01:01:03,,/data/UML4/conf/example1/socks/SW5 
eth4=daemon,fe:fd:01:01:01:04,,/data/UML4/conf/example1/socks/SW6 
eth5=daemon,fe:fd:01:01:01:81,,/data/UML4/conf/example1/socks/SW8p1 
eth6=daemon,fe:fd:3f:a9:35:e2,,/data/UML4/conf/EXTERN/E1  \
         con=null \
         ssl0=port:9101 \
         umid=example1-pc1 \
         @pc1@


Patch to extend the limits (buffer and number of args/envs) is attached.
Please consider including it because UML is intended to be run with such 
long lines.
I'm open to other alternatives as a Kconfig entry for this.

Thank you!

Signed-off-by: Catalin(ux aka Dino) BOIE <catab at umbrella dot ro>

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
---1646943047-1721268723-1098826471=:22912
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="uml-extend-cmd-line-limits.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0410270034310.22912@webhosting.rdsbv.ro>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="uml-extend-cmd-line-limits.patch"

LS0tIGxpbnV4LTIuNi45L2luaXQvbWFpbi5jCTIwMDQtMTAtMTkgMDA6NTM6
MjMuMDAwMDAwMDAwICswMzAwDQorKysgbXlsaW51eC9pbml0L21haW4uYwky
MDA0LTEwLTI2IDIzOjU3OjI5LjAwMDAwMDAwMCArMDMwMA0KQEAgLTExMCw4
ICsxMTAsOCBAQCBFWFBPUlRfU1lNQk9MKHN5c3RlbV9zdGF0ZSk7DQogLyoN
CiAgKiBCb290IGNvbW1hbmQtbGluZSBhcmd1bWVudHMNCiAgKi8NCi0jZGVm
aW5lIE1BWF9JTklUX0FSR1MgMzINCi0jZGVmaW5lIE1BWF9JTklUX0VOVlMg
MzINCisjZGVmaW5lIE1BWF9JTklUX0FSR1MgMjU2DQorI2RlZmluZSBNQVhf
SU5JVF9FTlZTIDI1Ng0KIA0KIGV4dGVybiB2b2lkIHRpbWVfaW5pdCh2b2lk
KTsNCiAvKiBEZWZhdWx0IGxhdGUgdGltZSBpbml0IGlzIE5VTEwuIGFyY2hz
IGNhbiBvdmVycmlkZSB0aGlzIGxhdGVyLiAqLw0KLS0tIGxpbnV4LTIuNi45
L2luY2x1ZGUvYXNtLXVtL3NldHVwLmgJMjAwNC0xMC0xOSAwMDo1NDozMS4w
MDAwMDAwMDAgKzAzMDANCisrKyBteWxpbnV4L2luY2x1ZGUvYXNtLXVtL3Nl
dHVwLmgJMjAwNC0xMC0yNiAyMzo1NzozOS4wMDAwMDAwMDAgKzAzMDANCkBA
IC0xLDYgKzEsNiBAQA0KICNpZm5kZWYgU0VUVVBfSF9JTkNMVURFRA0KICNk
ZWZpbmUgU0VUVVBfSF9JTkNMVURFRA0KIA0KLSNkZWZpbmUgQ09NTUFORF9M
SU5FX1NJWkUgNTEyDQorI2RlZmluZSBDT01NQU5EX0xJTkVfU0laRSA0MDk2
DQogDQogI2VuZGlmCQkvKiBTRVRVUF9IX0lOQ0xVREVEICovDQo=

---1646943047-1721268723-1098826471=:22912--
