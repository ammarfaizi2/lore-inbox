Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUEKUpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUEKUpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUEKUpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:45:51 -0400
Received: from fmr03.intel.com ([143.183.121.5]:55728 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263626AbUEKUps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:45:48 -0400
Message-Id: <200405112045.i4BKjcF18930@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <mingo@elte.hu>, <geoff@linux.jf.intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] [PATCH] Performance of del_timer_sync
Date: Tue, 11 May 2004 13:45:40 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQ3luvTHFs4npLbTueDZAAp9kW2lQAAPRSQ
In-Reply-To: <20040511133053.62960b69.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton wrote on Tuesday, May 11, 2004 1:31 PM
> > > +int del_single_shot_timer(struct timer_struct *timer)
> > > +{
> > > +	if (del_timer(timer))
> > > +		del_timer_sync(timer);
> > > +}
> > >  #endif
> >
> > I'm confused, isn't the polarity of del_timer() need to be reversed?
>
> Hey, I didn't compile it, let alone test it!
>
> > Also propagate the return value of del_timer_sync()?
>
> yup.
>
> If it looks OK, please fix it up, kerneldocify the function and prepare
> a real patch?

Looks wonderful, much better than what we had before.  We will consolidate
the comments, run through our test setup and re-post.  Thanks!

- Ken


