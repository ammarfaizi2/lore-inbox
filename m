Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbRCDBH1>; Sat, 3 Mar 2001 20:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129948AbRCDBHS>; Sat, 3 Mar 2001 20:07:18 -0500
Received: from cvsftp.cotw.com ([208.242.241.39]:24840 "EHLO cvsftp.cotw.com")
	by vger.kernel.org with ESMTP id <S129932AbRCDBG7>;
	Sat, 3 Mar 2001 20:06:59 -0500
Message-ID: <3AA19820.6A33E871@cotw.com>
Date: Sat, 03 Mar 2001 19:19:28 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: LILO error with 2.4.3-pre1...
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <oupsnl3k5gs.fsf@pigdrop.muc.suse.de> <3A984BDA.190B4D8E@mandrakesoft.com> <20010225011211.A23853@gruyere.muc.suse.de> <20000101001915.A40@(none)>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, needed 2.4.3-pre1 and went to install with LILO using
'lilo -v' and got this:

   LILO version 21.4-4, Copyright (C) 1992-1998 Werner Almesberger
   'lba32' extensions Copyright (C) 1999,2000 John Coffman

   Reading boot sector from /dev/hda
   Merging with /boot/boot.b
   Boot image: /boot/vmlinuz-2.4.2
   Added linux *
   Boot image: /boot/vmlinuz-2.4.3-pre1
   Fatal: geo_comp_addr: Cylinder number is too big (1274 > 1023)

Neato. I don't have time to dig through LILO source code right
now, so here are my system specs:

	Linux Distribution: RedHat 6.2 with all latest updates
        Hard Disk: Maxtor 52049H3 (20GB) IDE
        CPU: Dual PII-266MHz
        RAM: 256MB PC100
        Result of 'fdisk /dev/hda -l':

           Disk /dev/hda: 255 heads, 63 sectors, 2491 cylinders
           Units = cylinders of 16065 * 512 bytes

             Device Boot    Start       End    Blocks   Id  System
          /dev/hda1   *         1      1513  12153141   83  Linux
          /dev/hda2          1514      1530    136552+  82  Linux swap
          /dev/hda3          1531      2491   7719232+  83  Linux

I have no idea why the 1023 limit is coming up considering 2.4.2 and
LILO were working just fine together and I have a newer BIOS that has
not problems detecting the driver properly. Go ahead, call me idiot :).

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
