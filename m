Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbSI2Tnb>; Sun, 29 Sep 2002 15:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSI2Tnb>; Sun, 29 Sep 2002 15:43:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61193 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261754AbSI2Tna>;
	Sun, 29 Sep 2002 15:43:30 -0400
Message-ID: <3D975901.9000207@pobox.com>
Date: Sun, 29 Sep 2002 15:48:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
References: <Pine.LNX.4.44.0209292117200.25393-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> yes, wrt. keventd i was thinking along the same line - but in a different,
> perhaps cleaner and simpler direction.
> 
> i'd like to introduce the following interfaces:
> 
> 	- create_work_queue(wq, handler_fn)

what is handler_fn for, if you pass work_fn later?


> 	- destroy_work_queue(wq)
> 
> 	- queue_work(wq, work_fn, work_data)

queue_work_delayed(wq, work_fn, work_data, delay) would be nice too


> 	- flush_work_queue(wq)
> 
> this is an extension of the keventd concept. A work queue is a simplified
> interface to create a kernel thread that gets work queued from IRQ and
> process contexts. No more, no less.

Your proposal sounds good to me...

	Jeff



