Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265152AbSJaFkh>; Thu, 31 Oct 2002 00:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265179AbSJaFkh>; Thu, 31 Oct 2002 00:40:37 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:465 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265152AbSJaFkg>; Thu, 31 Oct 2002 00:40:36 -0500
Message-ID: <3DC0B586.13DA237D@verizon.net>
Date: Wed, 30 Oct 2002 20:45:58 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.44 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.45 ipmr.c syntax error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [4.64.197.173] at Wed, 30 Oct 2002 23:46:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,net/ipv4/.ipmr.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=ipmr   -c -o net/ipv4/ipmr.o net/ipv4/ipmr.c
net/ipv4/ipmr.c: In function `ipmr_forward_finish':
net/ipv4/ipmr.c:1114: structure has no member named `pmtu'
net/ipv4/ipmr.c: In function `ipmr_queue_xmit':
net/ipv4/ipmr.c:1170: structure has no member named `pmtu'
make[2]: *** [net/ipv4/ipmr.o] Error 1
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

On x86 (P4).

~Randy
