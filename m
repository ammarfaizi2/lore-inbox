Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314960AbSDVXoI>; Mon, 22 Apr 2002 19:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314961AbSDVXoH>; Mon, 22 Apr 2002 19:44:07 -0400
Received: from jalon.able.es ([212.97.163.2]:51336 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314960AbSDVXoH>;
	Mon, 22 Apr 2002 19:44:07 -0400
Date: Tue, 23 Apr 2002 01:44:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: m.c.p@gmx.net
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre7-jam4
Message-ID: <20020422234401.GA11590@werewolf.able.es>
In-Reply-To: <200204221036.24880.m.c.p@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Forwarding to the list, 'cuase I think it is a genreal problem...]

On 2002.04.22 Marc-Christian Petersen wrote:
>Hi J.A.,
>
>tried your patch + the fix for the yield problem. Here it goes:
>
>gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre7-jam4/include -Wall 
>-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
>-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  
>-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include 
>-DKBUILD_BASENAME=psdev  -c -o psdev.o psdev.c
>psdev.c: In function `presto_psdev_ioctl':
>psdev.c:269: `TCGETS' undeclared (first use in this function)
>psdev.c:269: (Each undeclared identifier is reported only once
>psdev.c:269: for each function it appears in.)
>psdev.c:270: warning: unreachable code at beginning of switch statement
>make[2]: *** [psdev.o] Error 1
>make[2]: Leaving directory `/usr/src/linux-2.4.19-pre7-jam4/fs/intermezzo'
>make[1]: *** [_modsubdir_intermezzo] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.4.19-pre7-jam4/fs'
>make: *** [_mod_fs] Error 2
>
>2.4.18 + 2.4.19pre7 patch + 2.4.19pre7-jam4 patch.
>

-jam4 does not touch intermezzo fs (really, any file named psdev.c).
So I think it is a plain -pre7 problem.

Bandaid: put an #include <asm/ioctls.h> in fs/intermezzo/psdev.c.
But perchaps it should go on any other place.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam4 #1 SMP lun abr 22 00:52:56 CEST 2002 i686
