Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131336AbRC0OiN>; Tue, 27 Mar 2001 09:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131345AbRC0OiD>; Tue, 27 Mar 2001 09:38:03 -0500
Received: from inet.connecttech.com ([206.130.75.2]:59592 "EHLO
	inet.connecttech.com") by vger.kernel.org with ESMTP
	id <S131336AbRC0Ohp>; Tue, 27 Mar 2001 09:37:45 -0500
Message-ID: <0f5d01c0b6cb$ebcbeb40$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Thomas Foerster" <puckwork@madz.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010327064904Z130600-406+4294@vger.kernel.org>
Subject: Re: URGENT : System hands on "Freeing unused kernel memory: "
Date: Tue, 27 Mar 2001 09:40:50 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Thomas Foerster" <puckwork@madz.net>
> But suddenly the box was offline. One technical assistant from our ISP
tried to reboot
> our server (he couldn't tell me if there had been any messages on the
screen), but the
> system always hangs on
>
> Freeing unused kernel memory: xxk freed

I have a customer with the same symptom. They
have stock Mandrake 7.2 (kernel 2.2.17-21mdk)
and have installed serial-5.05 into it. The kernel
boots to the Freeing message and hangs. I
noticed ctl-alt-del still works, so I configured  in
magic sysrq (Documentation/sysrq.txt). sysrq-p
allowed me to get the eip, which checking against
the System.map I find is mod_timer(). A quick
printk showed me that the kernel isn't hung,
it's in an infinite loop, with mod_timer() being
one of the calls in the loop.

YMMV, but hopefully this method can help
you find your problem.

..Stu


