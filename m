Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTEVTrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTEVTrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:47:10 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:1989 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S263187AbTEVTrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:47:10 -0400
Message-ID: <004601c3209c$f0739700$0305a8c0@arch.sel.sony.com>
From: "Ming Lei" <lei.ming@attbi.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Elladan" <elladan@eskimo.com>, <efault@gmx.de>
References: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil> <20030514205949.GA3945@kroah.com>
Subject: Re: Linux 2.4 scheduler is RTOS-alike?
Date: Thu, 22 May 2003 13:01:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


will it be the same behavior If thread A and thread B both have a lot of
printf? Suppose A get first run, does B get run at all?

> this question is regarding linux kernel 2.4.7-2.4.20.
> linux 2.4 kernel does support real time sheduler. If using FIFO real time
> schedule policy, would the case that higher priority thread starve the
lower
> priority thread happen?  Similarly, let's say an example: if I have higher
> prioority thread A and lower priority thread B, thread A is running
without
> any wait or blocking, is there a possiblity that 2.4 scheduler may want to
> switch to thread B? Why?

Yes, FIFO threads that spin will block lower priority threads forever.

Sure, guaranteed if the high prio SCHED_FIFO task doesn't block at all.  If
you have a pure cpu burner, it will starve all lower priority
threads.

