Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268951AbRHPWkG>; Thu, 16 Aug 2001 18:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbRHPWj4>; Thu, 16 Aug 2001 18:39:56 -0400
Received: from [209.10.41.242] ([209.10.41.242]:52920 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268934AbRHPWjt>;
	Thu, 16 Aug 2001 18:39:49 -0400
Subject: Re: kernel threads
To: cwidmer@iiic.ethz.ch
Date: Thu, 16 Aug 2001 23:37:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Christian Widmer" at Aug 17, 2001 12:23:35 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XVl6-0006Dr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> schedule the call to kernel_thread using tq_schedule

You still want to use daemonzie

> - is there no need to call daemonize in the second variant - if yes why?

A task always has a parent, it'll just be a random task that ran the 
kernel_thread request - in fact it might be a kernel thread and then 
I dont guarantee what will occur. In fact I wouldnt try the tq_schedule one

> - can i do both variants during interupt time (when there is no valid 
> current)?

No, but you can create a thread ready in case its needed then wake it from
an IRQ
