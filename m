Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUDNOiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUDNOiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:38:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:33245 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S263415AbUDNOiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:38:12 -0400
Date: Wed, 14 Apr 2004 20:03:05 +0530
From: mohanlal jangir <mohanlal@samsung.com>
Subject: Re: Implementation of events in Linux Kernel
To: rakesh <raklfs@yahoo.com>, kernelnewbies@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Message-id: <020e01c4222d$67440440$7f476c6b@sisodomain.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <20040414142410.17997.qmail@web20729.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "rakesh" <raklfs@yahoo.com>
To: <kernelnewbies@nl.linux.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, April 14, 2004 7:54 PM
Subject: Implementation of events in Linux Kernel


>
> Hi All,
>
> Please excuse me if this is not the right place to post this question.
>
>       I have an application which runs on MIPS with Embedded Linux. Iwant
to write a char driver . I have a Rx Task and an Interrupthandler for the
char driver which will let me know if anything comesat the chip level.

If you receive interrupt from device, you can establish an interrupt handler
for that. See function "request_irq". If you want a sleep/wakeup mechanism,
there are many ways of doing this in Linux kernel. One of them is using
interruptible_sleep_on/wake_up_interruptible.

Regards
Mohanlal

  Assuming its pSOS or other real time operating systems one ofhandling an
interrupt is sending an event to the Rx Task then Rx Taskwill read from the
whatever buffer it may be.       If I want to implement the same thing in
Linux at the kernellevel treating my driver as a module. How ( what system
call ) can Ipass an event to the task such that it receives the event and
readsfrom the buffer ?      One more question in general what are all the
various exceptionsor Traps I have to look while writing a Linux Device
Driver.Thanks in Advance for all your help.ThanksRakesh
>
>
>
>
> ---------------------------------
> Do you Yahoo!?
> Yahoo! Tax Center - File online by April 15th

