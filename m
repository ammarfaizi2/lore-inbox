Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUABXeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 18:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265778AbUABXeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 18:34:10 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:55687 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262130AbUABXeG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 18:34:06 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 Jan 2004 15:34:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Valdis.Kletnieks@vt.edu
cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware 
In-Reply-To: <200401022110.i02LALKa014919@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0401021524450.2488-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 02 Jan 2004 12:56:16 PST, Davide Libenzi said:
> > On Fri, 2 Jan 2004, Bill Davidsen wrote:
> > 
> > > Yes and even worse, if you stop running setiathome the scientific task 
> > > *still* only gets half the available CPU!
> > 
> > Look that this is not true. If one core is not running any task, the idle 
> > task (if not polling) does "hlt" and the "what they call Fetch And 
> 
> What Bill said was:
> 
> >> memory-bound seti&home at CPU1. Even without hyperthreading, your
> >> scientific task is going to run at 50% of speed and seti&home is going
> >> to get second half. Oops.
> 
> > Yes and even worse, if you stop running setiathome the scientific task 
> > *still* only gets half the available CPU!
> 
> So Bill is pointing out that on a *normal* SMP, you get 50% whether or
> not the other processor is busy.

Define 50% ;) In case you are talking about 50% of all the available 
resources, in case of a 2 way SMP this is pretty obvious since a 
single thread cannot run simultaneuosly on two CPUs. In case of an HT 
core, this is not true since the single thread will expand using the whole 
core resources. Note though that it won't be an expansion to 100%, and 
this is the reason of the existence of the HT technology. That is, even 
with monster length pipelines, the CPU is not able to keep exec units 100% 
full using a single dispatch unit.



- Davide


