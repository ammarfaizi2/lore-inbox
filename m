Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbRLBQOa>; Sun, 2 Dec 2001 11:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280132AbRLBQOS>; Sun, 2 Dec 2001 11:14:18 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:65042 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S280126AbRLBQOG>;
	Sun, 2 Dec 2001 11:14:06 -0500
To: jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.17.2: make ext2 smaller
Newsgroups: linux.kernel
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com>
Message-Id: <20011202161401.2B57936DD7@hog.ctrl-c.liu.se>
Date: Sun,  2 Dec 2001 17:14:01 +0100 (CET)
From: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>This patch applies an obvious technique to the kernel:  increase the
>amount of code compiled in a single compilation unit, to increase the
>overall knowledge the compiler has of the code, to allow for better
>optimization and dead code removal.  KDE does this, with definite
>success, though they definitely are not the first to do this.
>
>Results from 2.4.17-pre2 plus the attached patch:  1135 bytes saved in
>vmlinux, simply from making all the functions static.
>(*.orig is prior to my patch.  kernel is P2 SMP-based)
>> [jgarzik@rum linux-e2all]$ ls -l vmlinux* arch/i386/boot/bzImage*
>> -rw-r--r--    1 jgarzik  jgarzik   1030259 Dec  2 06:18 arch/i386/boot/bzImage
>> -rw-r--r--    1 jgarzik  jgarzik   1030263 Dec  2 06:04 arch/i386/boot/bzImage.orig
>> -rwxr-xr-x    1 jgarzik  jgarzik   2814631 Dec  2 06:18 vmlinux*
>> -rwxr-xr-x    1 jgarzik  jgarzik   2815766 Dec  2 06:04 vmlinux.orig*

I think that you've only saved some symbols in the vmlinux file, symbols
that will get stripped off anyway when building the bzImage.  If you
want to see the real difference, remove the second "remove $$$tmppiggy"
from arch/i386/boot/compressed/Makefile and look at the _tmp_NNNNNpiggy
file left there.

   /Christer
-- 
"Just how much can I get away with and still go to heaven?"
