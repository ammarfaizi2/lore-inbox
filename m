Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280031AbRKFTYs>; Tue, 6 Nov 2001 14:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280484AbRKFTY2>; Tue, 6 Nov 2001 14:24:28 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:16695 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280417AbRKFTYR>; Tue, 6 Nov 2001 14:24:17 -0500
Date: Tue, 6 Nov 2001 19:23:44 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: EFS problem(s)
Message-ID: <20011106192344.A2299@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
X-OS: Linux grobbebol 2.4.13 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi *

trying to mount an EFS (irix) CD -- I only can et it to mount using

mount -t efs /dev/sda /mnt -o loop

without loop, it fails always. if I now look at the cd it irregularly
crashes. no messages.

if I mount  harddrive with -o loop and efs, it also irregularly crashes.

if I do not use -o loop, it doesn't crash but after trying to tar a big
file (500 MB on the disk) :

Nov  6 19:18:24 grobbebol kernel: EFS: map_block() failed to map block 472423 (indir)
Nov  6 19:18:24 grobbebol kernel: EFS: map_block() failed to map block 472424 (indir)
Nov  6 19:18:24 grobbebol kernel: EFS: map_block() failed to map block 472425 (indir)
Nov  6 19:18:24 grobbebol kernel: EFS: map_block() failed to map block 472426 (indir)
Nov  6 19:18:24 grobbebol kernel: EFS: map_block() failed to map block 472427 (indir)
Nov  6 19:18:24 grobbebol kernel: EFS: map_block() failed to map block 472428 (indir)
etc. ad infinitum.

probably something wrong with the new code here ?

-- 
Grobbebol's Home                      |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel          | Use your real e-mail address   /\
Linux 2.4.13 (apic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
