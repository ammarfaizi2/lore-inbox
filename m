Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310438AbSCSIAq>; Tue, 19 Mar 2002 03:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310439AbSCSIAg>; Tue, 19 Mar 2002 03:00:36 -0500
Received: from daimi.au.dk ([130.225.16.1]:58380 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S310438AbSCSIA0>;
	Tue, 19 Mar 2002 03:00:26 -0500
Message-ID: <3C96F015.24BDC9FF@daimi.au.dk>
Date: Tue, 19 Mar 2002 09:00:21 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
In-Reply-To: <sc91c4ce.020@mail-01.med.umich.edu> <20020315150241.H24984@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> With all recent kernels, init exiting causes the last of these to trigger:
> 
> NORET_TYPE void do_exit(long code)
> {
>         struct task_struct *tsk = current;
> 
>         if (in_interrupt())
>                 panic("Aiee, killing interrupt handler!");
>         if (!tsk->pid)
>                 panic("Attempted to kill the idle task!");
>         if (tsk->pid == 1)
>                 panic("Attempted to kill init!");

Why actually panic because of an attempt to kill init?

Of course a message should be printed, but after that
couldn't do_exit enter a loop where it just handles
signals and zombies?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
