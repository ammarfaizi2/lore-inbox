Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131525AbRC0UOk>; Tue, 27 Mar 2001 15:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131527AbRC0UOa>; Tue, 27 Mar 2001 15:14:30 -0500
Received: from colorfullife.com ([216.156.138.34]:40460 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131525AbRC0UOS>;
	Tue, 27 Mar 2001 15:14:18 -0500
Message-ID: <001d01c0b6fa$688b9030$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <mshiju@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel Oops message -2.4.x - contains ksymoops <oops.txt
Date: Tue, 27 Mar 2001 22:13:30 +0200
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

> Unable to handle kernel NULL pointer dereference at virtual address
> 00000004
> [...]
>
> EIP; c0111720 <interruptible_sleep_on_timeout+30/60>

It accesses a wait queue pointer

>
> Trace; c2810add <[lanstreamer]streamer_open+2cd/8f0>
>
Uninitialized old style waitqueue?
I assume a
    init_waitqueue_head(&streamer_priv->srb_wait);
is missing somewhere.

I've checked the code from 2.4.2/drivers/net/tokenring/lanstreamer.c,
and I don't see a problem. Which driver to you use?

--
    Manfred

