Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVCXJm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVCXJm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 04:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVCXJm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 04:42:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24517 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262435AbVCXJm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 04:42:56 -0500
Date: Thu, 24 Mar 2005 10:42:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: sounak chakraborty <sounakrin@yahoo.co.in>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched.c  function
In-Reply-To: <20050324093352.43916.qmail@web53307.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503241038530.27454@yvahk01.tjqt.qr>
References: <20050324093352.43916.qmail@web53307.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I had a wild idea to process one function that repeatedly checks the task list
>and find out which process is in which state

Why do not you do so, then? Note that on uniprocessors, all other tasks are
suspended, so their state does not change in between.

Tasks do not change their state without holding a lock. (There is an exception,
but it is justified.)

>I can run for_each process after certain interval of time, but rather than
>using timer i thought to set a value or call the function (for_each_process)
>whenever sheduling occurs(that is some process is going to sleep and some are
>awakening) that is i am getting some changes in the task list after that..

So you want to record task state changes? That is better done at the right
places in the kernel rather than traversing the task list repeatedly (the
latter is not that performant).

>i am sorry if some of my concepts are wrong as i am new to kernel and would be
>obliged if you correct me thank for your help sounak

I would be interested in the background: what do you need to know the task
states for?



Jan Engelhardt
-- 
