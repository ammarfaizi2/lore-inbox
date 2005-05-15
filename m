Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVEOM0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVEOM0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVEOM0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:26:36 -0400
Received: from mx.olc.ru ([212.17.18.162]:53261 "EHLO mx.olc.ru")
	by vger.kernel.org with ESMTP id S261616AbVEOM0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:26:34 -0400
From: Maxim Berezovsky <berry@zarub.org>
Reply-To: berry@zarub.org
To: linux-kernel@vger.kernel.org
Subject: linux kernel v2.4.30 bugreport
Date: Sun, 15 May 2005 19:25:45 +0700
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505151925.45767.berry@zarub.org>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] .c files containing "#include <linux/delay.h>" do not compiling with make

[2] when I try to compile packages from sources, any file that contains 
 "#include <linux/delay.h> does not compile with make.
 make outputs an error just like this:
gcc -D__KERNEL__ -DMODULE=1 -I/home/maxim/download/alsa-driver-1.0.4/include  
-I/lib/modules/2.4.30/build/include -O2 -mpreferred-stack-boundary=2 
-march=i686 -D__SMP__ -DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes 
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -DALSA_BUILD -nostdinc -iwithprefix include  -DKBUILD_BASENAME=cmipci   
-c -o cmipci.o cmipci.c
 In file included from ../alsa-kernel/pci/cmipci.c:29,
                 from cmipci.c:1:
 /lib/modules/2.4.30/build/include/linux/delay.h:57: error: parse error before 
"do"
 /lib/modules/2.4.30/build/include/linux/delay.h:57: error: parse error before 
'(' token
 /lib/modules/2.4.30/build/include/linux/delay.h:60: error: parse error before 
'(' token

 cmipci.c 29 line is:
 #include <linux/delay.h>

[3] bash-2.05b$ cat /proc/version
 Linux version 2.4.30 (root@diesel) (gcc version 3.3.4) #2 SMP

-- 
Maxim "berry" Berezovsky.
-------------------------
vox emissa volat, litera scripta manet.
