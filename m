Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133067AbRDRKFK>; Wed, 18 Apr 2001 06:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133068AbRDRKFB>; Wed, 18 Apr 2001 06:05:01 -0400
Received: from cad2.me.ccu.edu.tw ([140.123.121.3]:2485 "EHLO
	cad2.me.ccu.edu.tw") by vger.kernel.org with ESMTP
	id <S133067AbRDRKEu>; Wed, 18 Apr 2001 06:04:50 -0400
Message-ID: <3ADD68F1.69DC083E@cs.ccu.edu.tw>
Date: Wed, 18 Apr 2001 18:14:09 +0800
From: lmc83 <lmc83@cs.ccu.edu.tw>
X-Mailer: Mozilla 4.5 [zh-TW] (WinNT; I)
X-Accept-Language: zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: some question about ramdisk
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
    I have some question about initrd.
    If I have a compressed ramdisk image: initrd.gz put at a memory location
    for example: 0x00070000 (in fact, in my application, it is flash)

    1. what is the meaning of initrd_start in rd.c (linux-2.4.0)?
       Is it means 0x00070000?
       or is it means the initrd.gz will be decompressed to the
       location initrd_start?

    2. I'm tracing the rd.c and found that initrd_load() will be
       called only if initrd_start != 0, but for my testing
       case, it seems always initrd_start==0.
       Which kernel parameter can modify the initrd_start?


    3. How to tell the kernel that I have a initrd who's image
       is located 0x00070000?
       I saw the Document/kernel-parameters.txt, is seems doesn't
       have suitable parameter for me to use.
       
       Should I modify the kernel source code to fit my requirement?
       I've saw the "How-To: make root/boot disk", it use floppy's
       specific sector as ramdisk image, 
       I think is's a little similar to my application,
       I will try to just specify memory location instead of 
       reading from floppy's specific sector.

    Thanks in advance for you help

    Liang Ming-Chung
