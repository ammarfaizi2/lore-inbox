Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317749AbSGPD6T>; Mon, 15 Jul 2002 23:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317750AbSGPD6S>; Mon, 15 Jul 2002 23:58:18 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:36619 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317749AbSGPD6S>; Mon, 15 Jul 2002 23:58:18 -0400
Subject: Re: Linux 2.4.19-rc1-ac5 -- Build error in mpparse.c
From: Miles Lane <miles@megapathdsl.net>
To: Alan Cox <alan@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Jul 2002 21:01:06 -0700
Message-Id: <1026792066.1417.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not seen this particular error with mpparse.c 
mentioned on LKML before.

I hit this with gcc version 3.1.1 20020708 (prerelease):

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/3.1.1/include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
In file included from mpparse.c:25:
/usr/src/linux/include/asm/smp.h:45:1: warning: "INT_DELIVERY_MODE" redefined
/usr/src/linux/include/asm/smp.h:42:1: warning: this is the location of the previous definition
mpparse.c:72: parse error before numeric constant
mpparse.c:76: parse error before numeric constant
mpparse.c:77: parse error before numeric constant
mpparse.c:78: parse error before numeric constant
mpparse.c:79: parse error before numeric constant
mpparse.c: In function `smp_read_mpc':
mpparse.c:601: invalid lvalue in assignment

CONFIG_MPENTIUM4=y
CONFIG_TOSHIBA=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y


