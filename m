Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132468AbRD1WhK>; Sat, 28 Apr 2001 18:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRD1WhA>; Sat, 28 Apr 2001 18:37:00 -0400
Received: from 13dyn184.delft.casema.net ([212.64.76.184]:27407 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132468AbRD1Wgp>; Sat, 28 Apr 2001 18:36:45 -0400
Message-Id: <200104282236.AAA06021@cave.bitwizard.nl>
Subject: Sony Memory stick format funnies... 
To: linux-kernel@vger.kernel.org
Date: Sun, 29 Apr 2001 00:36:41 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a Sony memory stick in my system. When I display all the
interesting (i.e. not all 0xff and not all 0x00 data), I see (on a
recently formatted stick):

% hd /dev/hde | grep -v "ff ff ff ff ff ff ff ff   ff ff ff ff ff ff ff ff" | grep -v "00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00"
001b0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 80 02 ................
001c0  08 00 01 07 d0 dd 27 00   00 00 d9 ee 01 00 00 00 ....P]'...Yn....
001f0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 55 aa ..............U*
04e00  e9 00 00 20 20 20 20 20   20 20 20 00 02 20 01 00 i..        .. ..
04e10  02 00 02 00 00 f8 0c 00   10 00 08 00 27 00 00 00 .....x......'...
04e20  d9 ee 01 00 00 00 29 00   00 00 00 00 00 00 00 00 Yn....).........
04e30  00 00 00 00 00 00 46 41   54 31 32 20 20 20 00 00 ......FAT12   ..
04ff0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 55 aa ..............U*
05000  f8 ff ff 00 00 00 00 00   00 00 00 00 00 00 00 00 x...............
06800  f8 ff ff 00 00 00 00 00   00 00 00 00 00 00 00 00 x...............
08000  4d 45 4d 53 54 49 43 4b   49 4e 44 03 00 00 00 00 MEMSTICKIND.....
08010  00 00 00 00 00 00 4f 4c   b7 28 00 00 00 00 00 00 ......OL7(......
% 

However, when I mount the stick on /mnt/d1 I see: 

# l /mnt/d1
total 16
drwxr-xr-x 512 root     root        16384 Mar 24 17:26 dcim/
-r-xr-xr-x   1 root     root            0 May 23  2000 memstick.ind*
# 

Where the *(&#$%& does that "dcim" directory come from????


				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
