Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263605AbUEKU04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUEKU04 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUEKU0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:26:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:16786 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263605AbUEKU0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:26:50 -0400
Date: Tue, 11 May 2004 13:26:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: mingo@elte.hu, geoff@linux.jf.intel.com, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-Id: <20040511132619.7a4fb4cb.akpm@osdl.org>
In-Reply-To: <20040511211950.A20071@infradead.org>
References: <409FFF3B.3090506@linux.intel.com>
	<20040511004551.7c7af44d.akpm@osdl.org>
	<00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com>
	<20040511121126.73f5fdeb.akpm@osdl.org>
	<20040511195856.GA4958@elte.hu>
	<20040511131137.2390ffa8.akpm@osdl.org>
	<20040511211950.A20071@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 11, 2004 at 01:11:37PM -0700, Andrew Morton wrote:
> > +int del_single_shot_timer(struct timer_struct *timer)
> > +{
> > +	if (del_timer(timer))
> > +		del_timer_sync(timer);
> > +}
> 
> it's probably better named del_timer_singleshot given the name we gave
> to the other timer functions.

Nah, that's ungrammatical.  del_timer_singleshot means "delete a timer in a
single-shot manner".

We have:

"add a timer"
"modify a timer"
"delete a timer"
"delete a timer synchronously"
"delete a single-shot timer"

