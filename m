Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSFRRqv>; Tue, 18 Jun 2002 13:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSFRRqu>; Tue, 18 Jun 2002 13:46:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3568 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317525AbSFRRqt>; Tue, 18 Jun 2002 13:46:49 -0400
Subject: Re: latest linus-2.5 BK broken
From: Robert Love <rml@tech9.net>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.44.0206181016290.5510-100000@www.transvirtual.com>
References: <Pine.LNX.4.44.0206181016290.5510-100000@www.transvirtual.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 10:46:49 -0700
Message-Id: <1024422409.1476.208.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-18 at 10:18, James Simmons wrote:

>   gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/tmp/fbdev-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -nostdinc -iwithprefix include    -fno-omit-frame-pointer -DKBUILD_BASENAME=sched   -c -o sched.o sched.c
> sched.c: In function `sys_sched_setaffinity':
> sched.c:1329: `cpu_online_map' undeclared (first use in this function)
> sched.c:1329: (Each undeclared identifier is reported only once
> sched.c:1329: for each function it appears in.)
> sched.c: In function `sys_sched_getaffinity':
> sched.c:1389: `cpu_online_map' undeclared (first use in this function)
> make[1]: *** [sched.o] Error 1

Rusty, I assume this is a side-effect of the hotplug merge?

Can you fix this or tell me what is the new equivalent of
cpu_online_map?

	Robert Love

