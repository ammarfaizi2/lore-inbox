Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbVLWOws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVLWOws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 09:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbVLWOws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 09:52:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030424AbVLWOwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 09:52:47 -0500
Date: Fri, 23 Dec 2005 06:51:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nicolas Pitre <nico@cam.org>
Cc: hch@infradead.org, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       arjanv@infradead.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051223065118.95738acc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512230912220.26663@localhost.localdomain>
References: <20051222114147.GA18878@elte.hu>
	<20051222035443.19a4b24e.akpm@osdl.org>
	<20051222122011.GA20789@elte.hu>
	<20051222050701.41b308f9.akpm@osdl.org>
	<1135257829.2940.19.camel@laptopd505.fenrus.org>
	<20051222054413.c1789c43.akpm@osdl.org>
	<1135260709.10383.42.camel@localhost.localdomain>
	<20051222153014.22f07e60.akpm@osdl.org>
	<20051222233416.GA14182@infradead.org>
	<20051222221311.2f6056ec.akpm@osdl.org>
	<Pine.LNX.4.64.0512230912220.26663@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
>
> How can't you get the fact that semaphores could _never_ be as simple as 
> mutexes?  This is a theoritical impossibility, which maybe turns out not 
> to be so true on x86, but which is damn true on ARM where the fast path 
> (the common case of a mutex) is significantly more efficient.
>

I did notice your comments.  I'll grant that mutexes will save some tens of
fastpath cycles on one minor architecture.  Sorry, but that doesn't seem
very important.
