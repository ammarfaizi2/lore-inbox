Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268147AbTAKVjP>; Sat, 11 Jan 2003 16:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268146AbTAKVjP>; Sat, 11 Jan 2003 16:39:15 -0500
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:26790 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S268147AbTAKVjO> convert rfc822-to-8bit; Sat, 11 Jan 2003 16:39:14 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org
Subject: hda has changed heads
Date: Sat, 11 Jan 2003 22:49:11 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301112249.11624.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

under 2.5.50 I got the following (sorry for localization):


karpfen:/home/dreher # uname -a
Linux karpfen 2.5.50 #1 Sun Dec 1 21:51:57 CET 2002 i686 unknown

karpfen:/home/dreher # fdisk -l

Festplatte /dev/hda: 255 Köpfe, 63 Sektoren, 4998 Zylinder
Einheiten: Zylinder mit 16065 * 512 Bytes

    Gerät boot.  Anfang      Ende    Blöcke   Id  Dateisystemtyp
/dev/hda1             1        20    160618+  82  Linux Swap
/dev/hda2   *        21       256   1895670    6  FAT16
/dev/hda3           257      3912  29366820   83  Linux
/dev/hda4          3913      4998   8723295    5  Erweiterte
/dev/hda5          3913      4998   8723263+   b  Win95 FAT32
karpfen:/home/dreher # exit


On the other hand, under 2.5.54 (and 2.5.56) I get


karpfen:/usr/src/linux # uname -a
Linux karpfen 2.5.54 #2 Thu Jan 2 22:47:22 CET 2003 i686 unknown

karpfen:/usr/src/linux # fdisk -l

Festplatte /dev/hda: 16 Köpfe, 63 Sektoren, 79656 Zylinder
Einheiten: Zylinder mit 1008 * 512 Bytes

    Gerät boot.  Anfang      Ende    Blöcke   Id  Dateisystemtyp
/dev/hda1             1       319    160618+  82  Linux Swap
Partition 1 endet nicht an einer Zylindergrenze:
     phys=(19, 254, 63) should be (19, 15, 63)
/dev/hda2   *       319      4080   1895670    6  FAT16
Partition 2 endet nicht an einer Zylindergrenze:
     phys=(255, 254, 63) should be (255, 15, 63)
/dev/hda3          4081     62348  29366820   83  Linux
Partition 3 endet nicht an einer Zylindergrenze:
     phys=(1023, 254, 63) should be (1023, 15, 63)
/dev/hda4         62348     79656   8723295    5  Erweiterte
Partition 4 endet nicht an einer Zylindergrenze:
     phys=(1023, 254, 63) should be (1023, 15, 63)
/dev/hda5         62348     79656   8723263+   b  Win95 FAT32


Basically, I dont care about the new number of heads, but now lilo
complains like this (it did not complain before):

karpfen:/etc # lilo
Added testing *
Added linux
Added failsafe
Added linux-2.5.54
Added linux-2.5.50
Device 0x0300: Invalid partition table, 2nd entry
  3D address:     1/0/20 (20160)
  Linear address: 1/12/318 (321300)
karpfen:/etc #




Best wishes,
Michael

