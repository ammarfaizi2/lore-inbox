Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267648AbTAHRUc>; Wed, 8 Jan 2003 12:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267683AbTAHRUc>; Wed, 8 Jan 2003 12:20:32 -0500
Received: from pc132.utati.net ([216.143.22.132]:6797 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S267648AbTAHRUb> convert rfc822-to-8bit; Wed, 8 Jan 2003 12:20:31 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 make install glitch...
Date: Mon, 6 Jan 2003 23:26:32 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301062326.32596.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Installing 2.4.20 on a fresh red hat 8 system, doing the standard:

make dep clean bzImage modules install modules_install:

Barfs with the following error:

---
blah blah blah...
Root device is (3, 4)
Boot sector 512 bytes.
Setup is 2645 bytes.
System is 893 kB
sh -x ./install.sh 2.4.20 bzImage /home/landley/linux-2.4.20/System.map ""
+ '[' -x /root/bin/installkernel ']'
+ '[' -x /sbin/installkernel ']'
+ exec /sbin/installkernel 2.4.20 bzImage 
/home/landley/linux-2.4.20/System.map ''
/lib/modules/2.4.20 is not a directory.
make[1]: *** [install] Error 1
make[1]: Leaving directory `/home/landley/linux-2.4.20/arch/i386/boot'
make: *** [install] Error 2
---

I.E. make install tries to drop System.map into /lib/modules/`uname -a`, but 
doesn't create it first.

I guess modules_install also installs the bzImage?

Rob

-- 
penguicon.sf.net - A combination Linux Expo and Science Fiction Convention 
with GOHs Terry Pratchett, Eric Raymond, Pete Abrams, Illiad & CmdrTaco.


