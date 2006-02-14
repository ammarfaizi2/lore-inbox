Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWBNEAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWBNEAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWBNEAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:00:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750962AbWBNEAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:00:42 -0500
Date: Mon, 13 Feb 2006 19:59:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kenneth.w.chen@intel.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/2] fix perf. bug in wake-up load balancing for aim7
 and db workload
Message-Id: <20060213195943.5d9ef90c.akpm@osdl.org>
In-Reply-To: <43F15211.2090206@yahoo.com.au>
References: <200602140309.k1E394g17590@unix-os.sc.intel.com>
	<20060213193856.696bf1f0.akpm@osdl.org>
	<43F15211.2090206@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > I'm more inclined to revert it and not add the sysctl (ugh) until we have a
>  > good reason to do so.
>  > 
> 
>  If you revert this then Ken's database benchmark gets worse. Hence the
>  sysctl.

Putting that knob in there hurts.  There's just no way in which we can
autodetect the right setting? 

Ho hum.  Well could someone please resend Ken's sysctl-knob patch, this
time 

a) with a good changelog which is useful to people who write things to
   /proc.  ie: end users, not scheduler hackers and

b) with an update to Documentation/kernel-parameters.txt and

c) if poss, with a better name?  Something which describes what its
   effect is upon the overall system not its effect upon mysterious
   scheduler internals.

If this thing is to be useful to administrators, they actually have to have
a chance of understanding what it does.

Thanks.
