Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUF0KZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUF0KZe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 06:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUF0KZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 06:25:33 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:27778 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261682AbUF0KZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 06:25:13 -0400
Date: Sun, 27 Jun 2004 20:24:59 +1000 (EST)
From: Con Kolivas <kernel@kolivas.org>
To: Michael Buesch <mbuesch@freenet.de>
cc: Willy Tarreau <willy@w.ods.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
In-Reply-To: <200406252148.37606.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.58.0406272021250.29505@kolivas.org>
References: <200406251840.46577.mbuesch@freenet.de> <200406252044.25843.mbuesch@freenet.de>
 <20040625190533.GI29808@alpha.home.local> <200406252148.37606.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1563069844-1088331899=:29572"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1563069844-1088331899=:29572
Content-Type: TEXT/PLAIN; charset=US-ASCII


Ok I found a problem which alost certainly is responsible in the 
conversion from nanoseconds to Hz and may if you're unlucky give a blank 
timeslice. Can you try this (against staircase7.4). I'm almost certain 
it's responsbile. 

Cheers,
Con

P.S.
Sorry about all sorts of different ways I'm sending 
attachments. I'm away from home and use any email access I can find.
---1463811839-1563069844-1088331899=:29572
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="staircase7.4-staircase7.5"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0406272024590.29572@kolivas.org>
Content-Description: 
Content-Disposition: attachment; filename="staircase7.4-staircase7.5"

LS0tIGxpbnV4LTIuNi43LXN0YWlyY2FzZTcuNC9rZXJuZWwvc2NoZWQuYwky
MDA0LTA2LTI3IDIwOjEzOjUyLjk5MDUxNjY2MCArMTAwMA0KKysrIGxpbnV4
LTIuNi43LXN0YWlyY2FzZTcuNC0yL2tlcm5lbC9zY2hlZC5jCTIwMDQtMDYt
MjcgMjA6MTc6MjEuODQ5NTgwNjUzICsxMDAwDQpAQCAtMjE4LDggKzIxOCw4
IEBAIHN0YXRpYyB2b2lkIGRlcXVldWVfdGFzayhzdHJ1Y3QgdGFza19zdHIN
CiANCiBzdGF0aWMgdm9pZCBlbnF1ZXVlX3Rhc2soc3RydWN0IHRhc2tfc3Ry
dWN0ICpwLCBydW5xdWV1ZV90ICpycSkNCiB7DQotCWlmIChycS0+Y3Vyci0+
ZmxhZ3MgJiBQRl9QUkVFTVBURUQpIHsNCi0JCXJxLT5jdXJyLT5mbGFncyAm
PSB+UEZfUFJFRU1QVEVEOw0KKwlpZiAocC0+ZmxhZ3MgJiBQRl9QUkVFTVBU
RUQpIHsNCisJCXAtPmZsYWdzICY9IH5QRl9QUkVFTVBURUQ7DQogCQlsaXN0
X2FkZCgmcC0+cnVuX2xpc3QsIHJxLT5xdWV1ZSArIHAtPnByaW8pOw0KIAl9
IGVsc2UNCiAJCWxpc3RfYWRkX3RhaWwoJnAtPnJ1bl9saXN0LCBycS0+cXVl
dWUgKyBwLT5wcmlvKTsNCkBAIC0zMzAsNyArMzMwLDcgQEAgc3RhdGljIHZv
aWQgcmVjYWxjX3Rhc2tfcHJpbyh0YXNrX3QgKnAsIA0KIHsNCiAJdW5zaWdu
ZWQgbG9uZyBzbGVlcF90aW1lID0gbm93IC0gcC0+dGltZXN0YW1wOw0KIAl1
bnNpZ25lZCBsb25nIHJ1bl90aW1lID0gTlNfVE9fSklGRklFUyhwLT5ydW50
aW1lKTsNCi0JdW5zaWduZWQgbG9uZyB0b3RhbF9ydW4gPSBOU19UT19KSUZG
SUVTKHAtPnRvdGFscnVuKSArIHJ1bl90aW1lOw0KKwl1bnNpZ25lZCBsb25n
IHRvdGFsX3J1biA9IE5TX1RPX0pJRkZJRVMocC0+dG90YWxydW4gKyBwLT5y
dW50aW1lKTsNCiAJaWYgKCghcnVuX3RpbWUgJiYgTlNfVE9fSklGRklFUyhw
LT5ydW50aW1lICsgc2xlZXBfdGltZSkgPA0KIAkJUlJfSU5URVJWQUwpIHx8
IHAtPmZsYWdzICYgUEZfRk9SS0VEKSB7DQogCQkJcC0+ZmxhZ3MgJj0gflBG
X0ZPUktFRDsNCg==

---1463811839-1563069844-1088331899=:29572--
