Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318502AbSHEOgl>; Mon, 5 Aug 2002 10:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSHEOgl>; Mon, 5 Aug 2002 10:36:41 -0400
Received: from csmail.cs.ccu.edu.tw ([140.123.101.2]:785 "EHLO
	csmail.cs.ccu.edu.tw") by vger.kernel.org with ESMTP
	id <S318502AbSHEOgk>; Mon, 5 Aug 2002 10:36:40 -0400
Message-ID: <024c01c23c8e$5804d710$74667b8c@edward>
From: "=?big5?B?RWR3YXJkIFNoYW8gXCiq8qp2sOpcKQ==?=" <szg90@cs.ccu.edu.tw>
To: "=?big5?B?RWR3YXJkIFNoYW8gXCiq8qp2sOpcKQ==?=" <szg90@cs.ccu.edu.tw>,
       <linux-kernel@vger.kernel.org>
References: <021b01c23c8d$22becc60$74667b8c@edward>
Subject: Re: a question about __down() in Linux/arch/i386/kernel/semaphore.c
Date: Mon, 5 Aug 2002 22:42:37 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, i found it!
wake_up_locked(&sem->wait);
but why do we need to wake up the sleepers again?
Thank you very much.

-Edward Shao-

----- Original Message -----
From: "Edward Shao (ªòªv°ê)" <szg90@cs.ccu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, August 05, 2002 10:33 PM
Subject: a question about __down() in Linux/arch/i386/kernel/semaphore.c


> Hi,
>
> I have a question about __down() in kernel 2.4.18
> (Linux/arch/i386/kernel/semaphore.c)
> I found the last line of __down() is
> wake_up(&sem->wait);
> but in kernel 2.5.28, i didn't see this line..
> is this line necessary in kernel 2.4.18?
> why?
>
> Thank you very much.
>
> Best Regard!!!
>
> -Edward Shao-
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


