Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSILSTH>; Thu, 12 Sep 2002 14:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSILSTH>; Thu, 12 Sep 2002 14:19:07 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:50181
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S316971AbSILSTG>; Thu, 12 Sep 2002 14:19:06 -0400
Subject: Re: [PATCH] 2.4-ac task->cpu abstraction and optimization
From: Robert Love <rml@tech9.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: alan@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <15744.14760.938667.636159@kim.it.uu.se>
References: <1031782906.982.33.camel@phantasy> 
	<15744.14760.938667.636159@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Sep 2002 14:23:52 -0400
Message-Id: <1031855035.2958.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 02:52, Mikael Pettersson wrote:

> This is fairly similar to the "up-opt" patch I have been using for my
> 2.4 standard (not -ac) kernels since last winter, available as
> <http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-up-opt-2.4.20-pre6>.
> It's not a direct substitute for yours, since -ac changes kernel/sched.c
> quite a bit, and it has some unnecessary patches to SMP code, but other
> than that, I totally agree with the intention of your patch.

Good ;)

I should of added this is from 2.5; so it has been around for awhile.  I
also took a look at your patch -- looks good, you should submit it to
Marcelo... it cannot hurt for 2.4.

One thing:

    -	int processor;
    +#ifdef CONFIG_SMP
    +	int processor; /* keep old name to avoid upsetting all archs */
    +#endif

It is normally bad form to have conditionally entries in the
task_struct... otherwise, looks good.

	Robert Love

