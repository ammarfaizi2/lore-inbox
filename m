Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261383AbREMHfD>; Sun, 13 May 2001 03:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbREMHey>; Sun, 13 May 2001 03:34:54 -0400
Received: from hut.comstar.ru ([195.210.128.8]:33555 "EHLO hut.comstar.ru")
	by vger.kernel.org with ESMTP id <S261383AbREMHeo>;
	Sun, 13 May 2001 03:34:44 -0400
Message-ID: <3AFE3870.3BB1B69@cyberplat.ru>
Date: Sun, 13 May 2001 11:32:00 +0400
From: Oleg Makarenko <omakarenko@cyberplat.ru>
Organization: cyberplat.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20-0.20.8 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ipv4@mail.ru
Subject: [PATCH] NFS Server performance and 8139too
Content-Type: multipart/mixed;
 boundary="------------A07B5A3708D145C89F6620F1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A07B5A3708D145C89F6620F1
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit


Since 2.2.19 I have a very poor NFS server performance on Linux 
using 8139too driver (v0.9.14) while the driver v0.9.10 from 2.2.18 
works fine (even with 2.2.19)

I have checked 2.2.20pre2 and 8139too project pages and found no patches
for the problem. Am I alone with that bad NFS performance here?

My setup:

PII-500, 196M, Linux 2.2.19. rh6.2, 8139too, 
serves as NFS server and client for SCO OpenServer and file server and
client
for macintosh

the following command on SCO:

sco# cat /mnt/linux/one-megabyte-file > /dev/null 

takes about 30 minutes with 2.2.19 kernel and about 0.3 secs on 2.2.18.
(I have never made the real benchmarks, numbers are just to show the 
difference)

The following one line patch puts performance of 2.2.19 back to
2.2.18 for me and I use it for a week without any problems.

Beware that I am not a kernel hacker so the patch can be completely 
wrong. But I hope it still can provide some useful information to 
somebody  who really knows what is going on here :)

oleg
--------------A07B5A3708D145C89F6620F1
Content-Type: application/octet-stream;
 name="linux-2.2.19-8139too.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linux-2.2.19-8139too.patch"

LS0tIGxpbnV4LTIuMi4xOS9kcml2ZXJzL25ldC84MTM5dG9vLmMJU3VuIE1hciAyNSAyMDoz
NzozNCAyMDAxCisrKyBsaW51eC1tb2xlL2RyaXZlcnMvbmV0LzgxMzl0b28uYwlTYXQgTWF5
IDEyIDE4OjI3OjQ4IDIwMDEKQEAgLTE4MDgsNiArMTgwOCw3IEBACiAJCXRwLT5kaXJ0eV90
eCA9IGRpcnR5X3R4OwogCQlpZiAobmV0aWZfcXVldWVfc3RvcHBlZCAoZGV2KSkKIAkJCW5l
dGlmX3dha2VfcXVldWUgKGRldik7CisJCW1hcmtfYmgoTkVUX0JIKTsKIAl9CiB9Cg==

--------------A07B5A3708D145C89F6620F1--

