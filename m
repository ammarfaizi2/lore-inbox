Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRHRSXj>; Sat, 18 Aug 2001 14:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264932AbRHRSXa>; Sat, 18 Aug 2001 14:23:30 -0400
Received: from pille.addcom.de ([62.96.128.34]:62982 "HELO pille.addcom.de")
	by vger.kernel.org with SMTP id <S264797AbRHRSXW>;
	Sat, 18 Aug 2001 14:23:22 -0400
Date: Sat, 18 Aug 2001 20:23:09 +0200 (CEST)
From: Frank Neuber <frank.neuber@gmx.de>
To: andre@linux-ide.org
cc: linux-kernel@vger.kernel.org
Subject: BUGFIX: UDMA-SiS5513 chipset support
Message-ID: <Pine.LNX.3.96.1010818151105.1982A-200000@mars.private.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-2139483686-1497291156-998158989=:1982"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---2139483686-1497291156-998158989=:1982
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,
recently I did an upgrade of my old computer (ASUS SP97-V) to
the kernel-2.4.7.

Problem:
  My system was crashing even when I load the module ide-disk.o
Solution:
  Because of the broken hardware (some UDMA problems with an non
  UDMA-Cabel to the drive) the linux kernel hangs during ide_dma_check.
  Even if UDMA is disabeld in the bios, the kernel detect this drive as
  an udma drive. And this is wrong!!
  My solution was simply to comment out the ide_dma_check in ide.c.
  You can find this patch as attachment.

Frank	

-- 
     _/_/_/_/ _//   _/ Frank Neuber
    _/       _/_/  _/  frank.neuber@gmx.de (private)
   _/_/_/   _/ _/ _/
  _/       _/  _/_/    neuber@opensource-systemberatung.de
 _/       _/    // http://www.opensource-systemberatung.de

---2139483686-1497291156-998158989=:1982
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ide-sis.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1010818202309.1982B@mars.private.de>
Content-Description: ide-sis.patch

LS0tIGlkZS5jCVNhdCBBdWcgMTggMTk6NDY6MDggMjAwMQ0KKysrIGlkZS1z
aXMuYwlTYXQgQXVnIDE4IDE5OjQ1OjUxIDIwMDENCkBAIC0zNDMxLDcgKzM0
MzEsNyBAQA0KIAkJCSAqICAgUEFSQU5PSUEhISENCiAJCQkgKi8NCiAJCQko
dm9pZCkgKEhXSUYoZHJpdmUpLT5kbWFwcm9jKGlkZV9kbWFfb2ZmX3F1aWV0
bHksIGRyaXZlKSk7DQotCQkJKHZvaWQpIChIV0lGKGRyaXZlKS0+ZG1hcHJv
YyhpZGVfZG1hX2NoZWNrLCBkcml2ZSkpOw0KKwkJCS8vKHZvaWQpIChIV0lG
KGRyaXZlKS0+ZG1hcHJvYyhpZGVfZG1hX2NoZWNrLCBkcml2ZSkpOw0KIAkJ
fQ0KIAkJZHJpdmUtPmRzY19vdmVybGFwID0gKGRyaXZlLT5uZXh0ICE9IGRy
aXZlICYmIGRyaXZlci0+c3VwcG9ydHNfZHNjX292ZXJsYXApOw0KIAkJZHJp
dmUtPm5pY2UxID0gMTsNCg==
---2139483686-1497291156-998158989=:1982--
