Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262356AbSI2AQJ>; Sat, 28 Sep 2002 20:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSI2AQJ>; Sat, 28 Sep 2002 20:16:09 -0400
Received: from dp.samba.org ([66.70.73.150]:28371 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262356AbSI2AQI>;
	Sat, 28 Sep 2002 20:16:08 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15766.18152.73299.58831@argo.ozlabs.ibm.com>
Date: Sun, 29 Sep 2002 10:18:48 +1000 (EST)
To: davidm@hpl.hp.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: show_stack()/show_trace() prototypes
In-Reply-To: <200209281642.g8SGgKMA007827@napali.hpl.hp.com>
References: <200209281642.g8SGgKMA007827@napali.hpl.hp.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger writes:

> Ingo, the ksymoops patch adds these to linux/sched.h:
> 
> extern void show_trace(unsigned long *stack);
> extern void show_stack(unsigned long *stack);
> 
> This is not good.

I agree.  It is unnecessary to have these declarations in
linux/sched.h since these functions are only called from arch code.
So I would also vote for having the declarations arch-specific.

Paul.
