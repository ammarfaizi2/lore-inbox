Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVLZLMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVLZLMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 06:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVLZLMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 06:12:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751066AbVLZLMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 06:12:40 -0500
Date: Mon, 26 Dec 2005 03:11:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@elte.hu, zippel@linux-m68k.org, hch@infradead.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051226031128.13bbace9.akpm@osdl.org>
In-Reply-To: <1135593776.2935.5.camel@laptopd505.fenrus.org>
References: <20051222114147.GA18878@elte.hu>
	<20051222153014.22f07e60.akpm@osdl.org>
	<20051222233416.GA14182@infradead.org>
	<200512251708.16483.zippel@linux-m68k.org>
	<20051225150445.0eae9dd7.akpm@osdl.org>
	<20051225232222.GA11828@elte.hu>
	<20051226023549.f46add77.akpm@osdl.org>
	<1135593776.2935.5.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> 
> > hm.  16 CPUs hitting the same semaphore at great arrival rates.  The cost
> > of a short spin is much less than the cost of a sleep/wakeup.  The machine
> > was doing 100,000 - 200,000 context switches per second.
> 
> interesting.. this might be a good indication that a "spin a bit first"
> mutex slowpath for some locks might be worth implementing...

If we see a workload which is triggering such high context switch rates,
maybe.  But I don't think we've seen any such for a long time.

