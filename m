Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbSKBRvC>; Sat, 2 Nov 2002 12:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSKBRvB>; Sat, 2 Nov 2002 12:51:01 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:41377 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP
	id <S261332AbSKBRtW>; Sat, 2 Nov 2002 12:49:22 -0500
Date: Sat, 2 Nov 2002 18:55:51 +0100 (MET)
From: Pilaszy Istvan <pila@inf.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: bug in linux-2.4.19/drivers/video/radeonfb.c
Message-ID: <Pine.GSO.4.00.10211021853200.29606-200000@kempelen.iit.bme.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1036259751=:29606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1036259751=:29606
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi!

I found a bug in the linux kernel source code, in radeonfb.c
I mailed it to the author 2 weeks ago, but no answer...

On line summary of the problem:
Linux kernel 2.4.19 compile fails on drivers/video/radeonfb.c, when
I turn the option `Console Drivers -> Frame-buffer support -> 32 bpp
packed pixels support' on (or something like this).

Environment:
AMD Thunderbird 850MHz, linux 2.4.19, Debian SID distribution,
/proc/version: Linux version 2.4.19 (root@server686) (gcc version 2.95.4
            20010703 (Debian prerelease)) #2 Thu Aug 29 20:06:37 CEST 2002

Solution: (I attached a diff -Naur)
I replaced line 1719 of the source code
of linux-2.4.19/drivers/video/radeonfb.c:
The original was:
#ifdef FBCON_HAS_CFB24
The corrected line is:
#ifdef FBCON_HAS_CFB32

With this modification I can compile the kernel, and it works well.

Bye,
Istvan


---559023410-851401618-1036259751=:29606
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="diff.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.00.10211021855510.29606@kempelen.iit.bme.hu>
Content-Description: 
Content-Disposition: attachment; filename="diff.txt"

LS0tIHJhZGVvbmZiLmMuT1JJRwlTYXQgT2N0IDE5IDE1OjM1OjAzIDIwMDIN
CisrKyByYWRlb25mYi5jCVNhdCBPY3QgMTkgMTU6MzQ6MDUgMjAwMg0KQEAg
LTE3MTYsNyArMTcxNiw3IEBADQogICAgICAgICAgICAgICAgICAgICAgICAg
ZGlzcC0+bGluZV9sZW5ndGggPSBkaXNwLT52YXIueHJlc192aXJ0dWFsICog
MjsNCiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAjZW5kaWYg
IA0KLSNpZmRlZiBGQkNPTl9IQVNfQ0ZCMzIgICAgICAgDQorI2lmZGVmIEZC
Q09OX0hBU19DRkIyNCAgICAgICANCiAgICAgICAgICAgICAgICAgY2FzZSAy
NDoNCiAgICAgICAgICAgICAgICAgICAgICAgICBkaXNwLT5kaXNwc3cgPSAm
ZmJjb25fY2ZiMjQ7DQogICAgICAgICAgICAgICAgICAgICAgICAgZGlzcC0+
ZGlzcHN3X2RhdGEgPSAmcmluZm8tPmNvbl9jbWFwLmNmYjI0Ow0K
---559023410-851401618-1036259751=:29606--
