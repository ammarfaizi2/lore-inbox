Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264220AbTEGT1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTEGT1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:27:34 -0400
Received: from sj-core-2.cisco.com ([171.71.177.254]:13292 "EHLO
	sj-core-2.cisco.com") by vger.kernel.org with ESMTP id S264244AbTEGT1V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:27:21 -0400
From: "Hua Zhong" <hzhong@cisco.com>
To: <root@chaos.analogic.com>, "Davide Libenzi" <davidel@xmailserver.org>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: top stack (l)users for 2.5.69
Date: Wed, 7 May 2003 12:39:28 -0700
Message-ID: <CDEDIMAGFBEBKHDJPCLDOECDDPAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.53.0305071517100.13724@chaos>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4925.2800
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is my understanding that there is one kernel stack. If there
> is a stack allocated for some "transition", and I guess there
> may be, because of the mail I'm getting, then it has absolutely
> no purpose whatsoever and is wasted valuable non-paged RAM.

I think your understanding is wrong. Each process has its own kernel stack
allocated together with the task_struct in a 8K chunk. At least for 2.4 it
is. I think interrupt handler also uses the current kernel stack.

> The reason why system-call parameters are passed in registers
> is so that we didn't have the overhead of copying stuff from a
> user stack to a kernel stack.
>
> Does anybody know (not guess) if this was stuff added for the
> new non-interrupt 0x80 syscall code? I want to know how a
> simple kernel got corrupted into this twisted thing.
>
> Anybody who has a copy of any of the Intel manuals since '386
> knows that there needs to be only one kernel stack.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? Think about it.

