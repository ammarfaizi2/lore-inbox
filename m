Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSJPMPe>; Wed, 16 Oct 2002 08:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbSJPMOq>; Wed, 16 Oct 2002 08:14:46 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:44942 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S262464AbSJPMNW> convert rfc822-to-8bit;
	Wed, 16 Oct 2002 08:13:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4: variable HZ (not broken. My fault)
Date: Wed, 16 Oct 2002 14:23:45 +0200
User-Agent: KMail/1.4.1
Cc: high-res-timers-discourse@lists.sourceforge.net
References: <1034661791.10843.9.camel@phantasy> <1034664656.718.8.camel@phantasy> <200210161414.55690.roy@karlsbakk.net>
In-Reply-To: <200210161414.55690.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210161423.45169.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry
this was my fault
was playing around with version numbers

On Wednesday 16 October 2002 14:14, Roy Sigurd Karlsbakk wrote:
> On Tuesday 15 October 2002 08:50, Robert Love wrote:
> > On Tue, 2002-10-15 at 02:03, Robert Love wrote:
> > > It works fine, and I have successfully used HZ=1000 on my machines.
> >
> > Except processor usage output was screwy.
>
> and except that it somehow breaks compiling serial.c?
>
> gcc -D__KERNEL__ -I/usr/src/prontux-0.1.9/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -pipe -mpreferred-stack-boundary=2 -march=i586   -nostdinc -iwithprefix
> include -DKBUILD_BASENAME=serial  -c -o serial.o serial.c
> serial.c:231:27: serial_compat.h: No such file or directory
> serial.c: In function `receive_chars':
> serial.c:677: warning: implicit declaration of function
> `queue_task_irq_off' serial.c: At top level:
> serial.c:1591: warning: static declaration for `tty_get_baud_rate' follows
> non-static
> serial.c: In function `rs_write':
> serial.c:1879: warning: implicit declaration of function `copy_from_user'
> serial.c: In function `get_serial_info':
> serial.c:2077: warning: implicit declaration of function `copy_to_user'
> serial.c: In function `send_break':
> serial.c:2391: structure has no member named `timeout'
> serial.c:3843:32: linux/symtab_begin.h: No such file or directory
> serial.c:3846:30: linux/symtab_end.h: No such file or directory
> serial.c: At top level:
> serial.c:3842: variable `serial_syms' has initializer but incomplete type
> serial.c:3844: warning: implicit declaration of function `X'
> serial.c:3844: warning: excess elements in struct initializer
> serial.c:3844: warning: (near initialization for `serial_syms')
> serial.c:3845: warning: excess elements in struct initializer
> serial.c:3845: warning: (near initialization for `serial_syms')
> serial.c:3331: warning: `rs_read_proc' defined but not used
> serial.c:3842: warning: `serial_syms' defined but not used
> make[3]: *** [serial.o] Error 1
> make[3]: Leaving directory `/usr/src/prontux-0.1.9/drivers/char'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/prontux-0.1.9/drivers/char'
> make[1]: *** [_subdir_char] Error 2
> make[1]: Leaving directory `/usr/src/prontux-0.1.9/drivers'
> make: *** [_dir_drivers] Error 2

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

