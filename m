Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264955AbSJ3Xis>; Wed, 30 Oct 2002 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSJ3Xis>; Wed, 30 Oct 2002 18:38:48 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:54020 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S264955AbSJ3Xio>; Wed, 30 Oct 2002 18:38:44 -0500
Date: Wed, 30 Oct 2002 18:44:00 -0500 (EST)
From: root <root@oddball-en.prodigy.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org, <root@oddball-en.prodigy.com>
Subject: Re: 2.5.44-mm6 issues - CORRECTED REPOST
In-Reply-To: <Pine.LNX.4.44.0210301830500.1451-100000@oddball.prodigy.com>
Message-ID: <Pine.LNX.4.44.0210301840560.1583-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Bill Davidsen wrote:

> Trying to compile with netfilter enabled:

At this point the include directive pulled a random dump or something, the 
following is the correct compile error. This mailer is NOT configured.!

net/ipv4/tcp_diag.c
  gcc -Wp,-MD,net/ipv4/.raw.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=raw   -c -o net/ipv4/raw.o net/ipv4/raw.c
net/ipv4/raw.c: In function `raw_send_hdrinc':
net/ipv4/raw.c:297: `NF_IP_LOCAL_OUT' undeclared (first use in this function)
net/ipv4/raw.c:297: (Each undeclared identifier is reported only once
net/ipv4/raw.c:297: for each function it appears in.)
make[2]: *** [net/ipv4/raw.o] Error 1
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

> Disabling netfilter gives a build which boots and oopses, is hung to the 
> reset button stage, and which writes nothing anywhere.
> 
> I have all the netfilter options on, and it wouldn't build as a module 
> with 2.5.44-mm2. With netfilter off 2.5.44-mm2 runs fine.
> 
> 	-bill
> 

