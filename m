Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbULCSQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbULCSQS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 13:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbULCSQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 13:16:18 -0500
Received: from www1.cdi.cz ([194.213.194.49]:44183 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S262452AbULCSQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 13:16:15 -0500
Date: Fri, 3 Dec 2004 19:15:58 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <linux-kernel@vger.kernel.org>, <piggin@cyberone.com.au>
Subject: Re: [PATCH] sched isolcpus=1 related OOPS in 2.6.9
In-Reply-To: <41B09FFD.6070706@osdl.org>
Message-ID: <Pine.LNX.4.33.0412031907271.493-200000@devix>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-169703902-1102097758=:493"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-169703902-1102097758=:493
Content-Type: TEXT/PLAIN; charset=US-ASCII

> You are correct, of course.  If "isolcpus" is used, the isolated
> cpu(s) (in <cpu_isolated_map>) are not init like the remaining
> cpus are.
>
> I don't know what's intended here... but it's not the divide by 0.

A patch is attached which fixes problems with isolated
domains for me. I hope it is correct :-) I will try on
real SMP when I will be in work (now it boots on Boochs).

enjoy,

    Martin Devera aka devik
Linux kernel QoS/HTB maintainer
  http://luxik.cdi.cz/~devik/

--8323328-169703902-1102097758=:493
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sched269_isol.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0412031915580.493@devix>
Content-Description: 
Content-Disposition: attachment; filename="sched269_isol.patch"

LS0tIGxpbnV4LTIuNi45L2tlcm5lbC9zY2hlZC5jCU1vbiBPY3QgMTggMjM6
NTQ6NTUgMjAwNA0KKysrIGtlcm5lbC9zY2hlZC5jCUZyaSBEZWMgIDMgMTk6
MDY6MDQgMjAwNA0KQEAgLTQ0ODAsNyArNDQ4MCw3IEBADQogI2lmZGVmIENP
TkZJR19OVU1BDQogCQlzZC0+c3BhbiA9IG5vZGVtYXNrOw0KICNlbHNlDQot
CQlzZC0+c3BhbiA9IGNwdV9wb3NzaWJsZV9tYXA7DQorCQlzZC0+c3BhbiA9
IGNwdV9kZWZhdWx0X21hcDsNCiAjZW5kaWYNCiAJCXNkLT5wYXJlbnQgPSBw
Ow0KIAkJc2QtPmdyb3VwcyA9ICZzY2hlZF9ncm91cF9waHlzW2dyb3VwXTsN
CkBAIC00NTEyLDExICs0NTEyLDE0IEBADQogDQogCS8qIFNldCB1cCBpc29s
YXRlZCBncm91cHMgKi8NCiAJZm9yX2VhY2hfY3B1X21hc2soaSwgY3B1X2lz
b2xhdGVkX21hcCkgew0KKwkJaW50IGdyb3VwOw0KIAkJY3B1bWFza190IG1h
c2s7DQogCQljcHVzX2NsZWFyKG1hc2spOw0KIAkJY3B1X3NldChpLCBtYXNr
KTsNCiAJCWluaXRfc2NoZWRfYnVpbGRfZ3JvdXBzKHNjaGVkX2dyb3VwX2lz
b2xhdGVkLCBtYXNrLA0KIAkJCQkJCSZjcHVfdG9faXNvbGF0ZWRfZ3JvdXAp
Ow0KKwkJZ3JvdXAgPSBjcHVfdG9faXNvbGF0ZWRfZ3JvdXAoaSk7DQorCQlz
Y2hlZF9ncm91cF9pc29sYXRlZFtncm91cF0uY3B1X3Bvd2VyID0gU0NIRURf
TE9BRF9TQ0FMRTsNCiAJfQ0KIA0KICNpZmRlZiBDT05GSUdfTlVNQQ0KQEAg
LTQ1MzIsNyArNDUzNSw3IEBADQogCQkJCQkJJmNwdV90b19waHlzX2dyb3Vw
KTsNCiAJfQ0KICNlbHNlDQotCWluaXRfc2NoZWRfYnVpbGRfZ3JvdXBzKHNj
aGVkX2dyb3VwX3BoeXMsIGNwdV9wb3NzaWJsZV9tYXAsDQorCWluaXRfc2No
ZWRfYnVpbGRfZ3JvdXBzKHNjaGVkX2dyb3VwX3BoeXMsIGNwdV9kZWZhdWx0
X21hcCwNCiAJCQkJCQkJJmNwdV90b19waHlzX2dyb3VwKTsNCiAjZW5kaWYN
CiANCkBAIC00NjM0LDcgKzQ2MzcsNyBAQA0KIAkJCQljcHVzX29yKGdyb3Vw
bWFzaywgZ3JvdXBtYXNrLCBncm91cC0+Y3B1bWFzayk7DQogDQogCQkJCWNw
dW1hc2tfc2NucHJpbnRmKHN0ciwgTlJfQ1BVUywgZ3JvdXAtPmNwdW1hc2sp
Ow0KLQkJCQlwcmludGsoIiAlcyIsIHN0cik7DQorCQkJCXByaW50aygiICVz
WyVsZF0iLCBzdHIsIGdyb3VwLT5jcHVfcG93ZXIpOw0KIA0KIAkJCQlncm91
cCA9IGdyb3VwLT5uZXh0Ow0KIAkJCX0gd2hpbGUgKGdyb3VwICE9IHNkLT5n
cm91cHMpOw0K
--8323328-169703902-1102097758=:493--
