Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWD1OAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWD1OAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWD1OAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:00:44 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:50055 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030406AbWD1OAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:00:43 -0400
Date: Fri, 28 Apr 2006 22:55:41 +0900 (JST)
Message-Id: <20060428.225541.124090656.taka@valinux.co.jp>
To: kernel@kolivas.org
Cc: maeda.naoaki@jp.fujitsu.com, linux-kernel@vger.kernel.org, efault@gmx.de,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <200604282309.32320.kernel@kolivas.org>
References: <200604282011.36917.kernel@kolivas.org>
	<44520581.3090404@jp.fujitsu.com>
	<200604282309.32320.kernel@kolivas.org>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Friday 28 April 2006 22:07, MAEDA Naoaki wrote:
> > Con Kolivas wrote:
> > > I agree with Mike here. It's either global resource management or it
> > > isn't. If one user is using all interactive tasks and the other user none
> > > it's unfair resource management.
> >
> > My intention was not to hurt interactive task's response, but it seems
> > that just ignoring interactive tasks is not good. I'll consider
> > regulating interactive tasks also.
> 
> I appreciate the gesture of concern over interactive tasks :-) Unfortunately 
> it doesn't change the fact that interactive tasks can also consume large 
> proportions of the resources, and that any interactivity estimator will get 
> it wrong on occasion and flag a non interactive task as interactive.

I think you can introduce some threshold to estimate whether
a process should be treated as an interactive process or not
while vanilla kernel defines it statically.
It will make processes in a resource group consuming large cpu-time
hard to be treated as interactive processes.


Thanks,
Hirokazu Takahashi.

