Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290878AbSAaD1B>; Wed, 30 Jan 2002 22:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290880AbSAaD0v>; Wed, 30 Jan 2002 22:26:51 -0500
Received: from zero.tech9.net ([209.61.188.187]:60677 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290878AbSAaD0k>;
	Wed, 30 Jan 2002 22:26:40 -0500
Subject: Re: Various issues with 2.5.2-dj6
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@suse.de>
Cc: Nathan <wfilardo@fuse.net>, lkml <linux-kernel@vger.kernel.org>,
        vojtech@suse.cz
In-Reply-To: <20020131041901.H31313@suse.de>
In-Reply-To: <3C58B3DD.3000800@fuse.net>  <20020131041901.H31313@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 30 Jan 2002 22:32:37 -0500
Message-Id: <1012447958.3219.100.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-30 at 22:19, Dave Jones wrote:
> On Wed, Jan 30, 2002 at 10:02:53PM -0500, Nathan wrote:
> 
>  > Issue 1: kernel does not compile without SMP support (missing references 
>  > to global_irq_holder in sched.c)
> 
>  Possibly an issue with preempt on top of my tree. Builds fine UP & SMP
>  here without it.

It is an issue with preempt-kernel and the newest version of Ingo's
scheduler (J9).  You just need to change the `ifdef CONFIG_SMP' to
`ifdef CONFIG_SMP || CONFIG_PREEMPT' or wait till 2.5-proper has that
version of Ingo's scheduler and my patch will have the change ...

	Robert Love

