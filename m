Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263261AbVCKKqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbVCKKqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbVCKKqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:46:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:19411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263261AbVCKKoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:44:12 -0500
Date: Fri, 11 Mar 2005 02:43:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: rostedt@goodmis.org
Cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-Id: <20050311024322.690eb3a9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu>
	<1108789704.8411.9.camel@krustophenia.net>
	<Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
	<Pine.LNX.4.58.0503100447150.14016@localhost.localdomain>
	<20050311095747.GA21820@elte.hu>
	<Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
	<20050311101740.GA23120@elte.hu>
	<Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > did you try the canonical way of putting a spinlock into every
>  > buffer_head?
>  >
> 
>  No, I'll try that now. I just didn't want to modify the buffer head struct
>  just for journaling.  But if it is the quickest and easiest fix, then I'll
>  submit it and we can change it later.

You'll need two spinlocks.  jbd_lock_bh_state() and jbd_lock_bh_journal_head().
