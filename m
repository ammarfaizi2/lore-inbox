Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278456AbRJOWKm>; Mon, 15 Oct 2001 18:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278457AbRJOWKc>; Mon, 15 Oct 2001 18:10:32 -0400
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:8067
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S278456AbRJOWKX>; Mon, 15 Oct 2001 18:10:23 -0400
From: arjan@fenrus.demon.nl
To: hiren_mehta@agilent.com (MEHTA,HIREN A-SanJose,ex1)
Subject: Re: spin locks and timers in scsi hba driver
cc: linux-kernel@vger.kernel.org
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E495@axcs13.cos.agilent.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15tFwW-0004rw-00@fenrus.demon.nl>
Date: Mon, 15 Oct 2001 23:10:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01A7DAF31F93D511AEE300D0B706ED9208E495@axcs13.cos.agilent.com> you wrote:
> Hi List,

> I want to make sure that my hba-driver timers do run
> when the uppar scsi-layer calls any of the error handler entry points
> and while I am still doing the error handling. As I know, scsi-layer
> calls spin_lock_irqsave(&io_request_lock, flags) before calling the
> error handlers and they call spin_unlock_irqrestore(&io_request_lock, flags)
> after returning from the error handlers. So, inside the error handlers,
> I call spin_unlock_irq(&io_request_lock); wait for the timers to run,
> and the again call spin_lock_irq(&io_request_lock). 

well interrupts are still disabled...
Could you give an URL to the source of your driver so that I and others can
see what you really are trying to do ?

Greetings,
   Arjan van de Ven
