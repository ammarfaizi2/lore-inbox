Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbRBYTZz>; Sun, 25 Feb 2001 14:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129646AbRBYTZo>; Sun, 25 Feb 2001 14:25:44 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:55208 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S129652AbRBYTZ3>;
	Sun, 25 Feb 2001 14:25:29 -0500
Date: Sun, 25 Feb 2001 20:25:26 +0100
From: Marc Lehmann <pcg@goof.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux swap freeze STILL in 2.4.x
Message-ID: <20010225202526.B8890@cerebro.laendle>
Mail-Followup-To: Mike Galbraith <mikeg@wen-online.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010225155929.A371@cerebro.laendle> <Pine.LNX.4.33.0102251745360.568-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0102251745360.568-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Sun, Feb 25, 2001 at 05:58:32PM +0100
X-Operating-System: Linux version 2.4.2-ac3 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and one last thing I forgot: loop devices. Since 2.4.1 (the first
version I used) through 2.4.2 and 2.4.2ac3 I only get:

cerebro:~# strace -f -o x losetup -e rc6 /dev/loop0 /dev/hdd
Memory Fault

And then no access to the loop device works anymore (clearly this is after
the 2.4.0.something crypto-patch applied, so this is probably not a 2.4.2
issue anyway since there is no 2.4.2 crypto patch).

Happy Hacking ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
