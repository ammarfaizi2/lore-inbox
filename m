Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132223AbRDCQmr>; Tue, 3 Apr 2001 12:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132224AbRDCQmi>; Tue, 3 Apr 2001 12:42:38 -0400
Received: from colorfullife.com ([216.156.138.34]:33038 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132223AbRDCQmU>;
	Tue, 3 Apr 2001 12:42:20 -0400
Message-ID: <003501c0bc5c$e26e81c0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <ocdi@ocdi.org>
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: uninteruptable sleep
Date: Tue, 3 Apr 2001 18:40:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ps xl:
>   F UID PID PPID PRI NI VSZ RSS WCHAN STAT TTY TIME COMMAND
> 040 1000 1230 1 9 0 24320 4 down_w D ? 0:00
>           /home/data/mozilla/obj/dist/bin/mozi
>
down_w

Perhaps down_write_failed()? 2.4.3 converted the mmap semaphore to a
rw-sem.
Did you compile sysrq into your kernel? Then enable it with

#echo 1 > /proc/sys/kernel/sysrq
and press <Alt>+<SysRQ>+'t'

It prints the complete back trace, not just one function name

--
    Manfred



