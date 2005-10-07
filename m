Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbVJGQW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbVJGQW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbVJGQW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:22:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47604 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030488AbVJGQW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:22:58 -0400
Message-ID: <4346A0A4.4090303@mvista.com>
Date: Fri, 07 Oct 2005 09:21:56 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Serge Goodenko <s_goodenko@mail.ru>
Cc: linux-kernel@vger.kernel.org,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
Subject: Re: [PATCH] UML + High-Res-Timers on 2.4.25 kernel
References: <E1ENsDa-0008Y1-00.s_goodenko-mail-ru@f16.mail.ru>
In-Reply-To: <E1ENsDa-0008Y1-00.s_goodenko-mail-ru@f16.mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Goodenko wrote:
> Hello!
> 
> I am trying to compile 2.4.25 UML kernel together with High Resolution Timers patch and it fails to compile saying the following during linking:
> 
> gcc -Wl,-T,arch/um/link.ld -static -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc \
>         -o linux arch/um/main.o vmlinux.o -L/usr/lib -lutil
> vmlinux.o(.text+0x2688): In function `schedule_timeout':
> /usr/src/linux-2.4.25/kernel/sched.c:443: undefined reference to `jiffies'
> vmlinux.o(.text+0x26cd):/usr/src/linux-2.4.25/kernel/sched.c:454: undefined reference to `jiffies'
> vmlinux.o(.text+0x27a4): In function `schedule':
> /usr/src/linux-2.4.25/include/linux/sched.h:929: undefined reference to `jiffies'
> vmlinux.o(.text+0x489e): In function `do_fork':
> /usr/src/linux-2.4.25/kernel/fork.c:740: undefined reference to `jiffies'
> vmlinux.o(.text+0xabd5): In function `do_getitimer':
> /usr/src/linux-2.4.25/kernel/itimer.c:55: undefined reference to `jiffies'
> vmlinux.o(.text+0xacd3):/usr/src/linux-2.4.25/kernel/itimer.c:103: more undefined references to `jiffies' follow
> collect2: ld returned 1 exit status
> make: *** [linux] Error 1
> 
> is there any solution to this problem?
> or HRT patch is not supposed to work under UML at all?
>
You might do better on the HRT list (cc'ed).

I don't know what UML needs.  I would have thought that jiffies would be defined...  especially for 
things like do_fork.  Which patch are you using?
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
