Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268232AbUIPPy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268232AbUIPPy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUIPPy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:54:27 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:24797 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268295AbUIPPvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:51:18 -0400
Message-ID: <5d6b657504091608511f100109@mail.gmail.com>
Date: Thu, 16 Sep 2004 17:51:04 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Stelian Pop <stelian@popies.net>, Buddy Lucas <buddy.lucas@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
In-Reply-To: <20040916152919.GG3146@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040913135253.GA3118@crusoe.alcove-fr>
	 <20040915153013.32e797c8.akpm@osdl.org>
	 <20040916064320.GA9886@deep-space-9.dsnet>
	 <20040916000438.46d91e94.akpm@osdl.org>
	 <20040916104535.GA3146@crusoe.alcove-fr>
	 <5d6b657504091608093b171e30@mail.gmail.com>
	 <20040916152919.GG3146@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 17:29:19 +0200, Stelian Pop <stelian@popies.net> wrote:
> On Thu, Sep 16, 2004 at 05:09:51PM +0200, Buddy Lucas wrote:
> 
> > > +       total = remaining = min(len, fifo->size - fifo->tail + fifo->head);
> >
> > I could be mistaken (long day at the office ;-) but doesn't this fail after
> > wrapping?
> 
> No, because the type is *unsigned* int.

Indeed, that would exactly be the reason *why* this would fail. ;-) 

The expression fifo->size - fifo->tail + fifo->head might be negative
at some point, right? (fifo->head has wrapped to some small value and
fifo->tail > fifo->size)


Cheers,
Buddy

> 
> Stelian.
> --
> 
> 
> Stelian Pop <stelian@popies.net>
>
