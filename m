Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263642AbUEKUbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUEKUbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUEKUbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:31:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:1174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263645AbUEKUb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:31:26 -0400
Date: Tue, 11 May 2004 13:30:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: mingo@elte.hu, geoff@linux.jf.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-Id: <20040511133053.62960b69.akpm@osdl.org>
In-Reply-To: <200405112027.i4BKR5F18656@unix-os.sc.intel.com>
References: <20040511131137.2390ffa8.akpm@osdl.org>
	<200405112027.i4BKR5F18656@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> > +
>  > +int del_single_shot_timer(struct timer_struct *timer)
>  > +{
>  > +	if (del_timer(timer))
>  > +		del_timer_sync(timer);
>  > +}
>  >  #endif
> 
>  I'm confused, isn't the polarity of del_timer() need to be reversed?

Hey, I didn't compile it, let alone test it!

>  Also propagate the return value of del_timer_sync()?

yup.

If it looks OK, please fix it up, kerneldocify the function and prepare a
real patch?

