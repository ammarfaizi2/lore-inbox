Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132805AbRDDQDd>; Wed, 4 Apr 2001 12:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132772AbRDDQDY>; Wed, 4 Apr 2001 12:03:24 -0400
Received: from mail.inup.com ([194.250.46.226]:50443 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S132755AbRDDQDO>;
	Wed, 4 Apr 2001 12:03:14 -0400
Date: Wed, 4 Apr 2001 18:07:20 +0200
From: christophe barbe <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep
Message-ID: <20010404180720.A14832@pc8.inup.com>
In-Reply-To: <003501c0bc5c$e26e81c0$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <003501c0bc5c$e26e81c0$5517fea9@local>; from manfred@colorfullife.com on mar, avr 03, 2001 at 18:40:53 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem seems to be related with the recent post from David Howells <dhowells@cambridge.redhat.com> with the subject "rw_semaphore bug".

Christophe

On mar, 03 avr 2001 18:40:53 Manfred Spraul wrote:
> > ps xl:
> >   F UID PID PPID PRI NI VSZ RSS WCHAN STAT TTY TIME COMMAND
> > 040 1000 1230 1 9 0 24320 4 down_w D ? 0:00
> >           /home/data/mozilla/obj/dist/bin/mozi
> >
> down_w
> 
> Perhaps down_write_failed()? 2.4.3 converted the mmap semaphore to a
> rw-sem.
> Did you compile sysrq into your kernel? Then enable it with
> 
> #echo 1 > /proc/sys/kernel/sysrq
> and press <Alt>+<SysRQ>+'t'
> 
> It prints the complete back trace, not just one function name
> 
> --
>     Manfred
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
