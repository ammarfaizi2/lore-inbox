Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSHJPhx>; Sat, 10 Aug 2002 11:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSHJPhx>; Sat, 10 Aug 2002 11:37:53 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:44292 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S317030AbSHJPhw>; Sat, 10 Aug 2002 11:37:52 -0400
Date: Sat, 10 Aug 2002 11:41:09 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: local apic on up broken with 2.4.20-pre1-ac1
Message-ID: <20020810114109.A26436@light-brigade.mit.edu>
References: <200208062329.g76NTqP30962@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200208062329.g76NTqP30962@devserv.devel.redhat.com>; from alan@redhat.com on Tue, Aug 06, 2002 at 07:29:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this has been broken for the last few -ac kernels.

gcc -D__KERNEL__ -I/devel/rpm/BUILD/kernel-2.4.20pre1ac1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
mpparse.c:74: `dest_LowestPrio' undeclared here (not in a function)
mpparse.c: In function `smp_read_mpc':
mpparse.c:609: `dest_Fixed' undeclared (first use in this function)
mpparse.c:609: (Each undeclared identifier is reported only once
mpparse.c:609: for each function it appears in.)
mpparse.c:609: `dest_LowestPrio' undeclared (first use in this function)
make[2]: *** [mpparse.o] Error 1
make[2]: Leaving directory `/devel/rpm/BUILD/kernel-2.4.20pre1ac1/arch/i386/kernel'

				-- Gerald

