Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbUKCAxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUKCAxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUKCAwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:52:37 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:26449 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261729AbUKBWIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:08:00 -0500
Message-ID: <41880538.8090902@yahoo.com.au>
Date: Wed, 03 Nov 2004 09:07:52 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add requeue task
References: <418707E5.90705@kolivas.org>	<41877F2D.6070200@yahoo.com.au> <16775.42190.9404.303359@thebsh.namesys.com>
In-Reply-To: <16775.42190.9404.303359@thebsh.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> Nick Piggin writes:
>  > Con Kolivas wrote:
>  > > add requeue task

>  > >  /*
>  > > + * Put task to the end of the run list without the overhead of dequeue
>  > > + * followed by enqueue.
>  > > + */
>  > > +static void requeue_task(struct task_struct *p, prio_array_t *array)
>  > > +{
>  > > +	list_del(&p->run_list);
>  > > +	list_add_tail(&p->run_list, array->queue + p->prio);
>  > > +}
> 
> Shouldn't this be
> 
> list_move_tail(&p->run_list, array->queue + p->prio);
> 
> ?
> 

I think it should indeed.
