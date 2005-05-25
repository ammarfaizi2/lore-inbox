Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVEYCFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVEYCFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 22:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVEYCFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 22:05:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19438 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262232AbVEYCFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 22:05:01 -0400
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "'Esben Nielsen'" <simlo@phys.au.dk>,
       "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Daniel Walker'" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>, <akpm@osdl.org>
Subject: RE: RT patch acceptance
Date: Tue, 24 May 2005 19:04:56 -0700
Message-ID: <005101c560ce$269c15a0$c800a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.OSF.4.05.10505241123240.5002-100000@da410.phys.au.dk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Esben Nielsen wrote:
> On Tue, 24 May 2005, Christoph Hellwig wrote:
> 
> > On Mon, May 23, 2005 at 04:14:26PM -0700, Daniel Walker wrote:
> > 
> > Personally I think interrupt threads, spinlocks as sleeping mutexes 
> > and PI is something we should keep out of the kernel tree.
> 
> A general threaded interrupt is not a good thing. Ingo made 
> this to see how far he can press it. But having serial 
> drivers running in interrupt is way overkill. Even network 
> drivers can (provided they use DMA) run in interrupt without 
> hurting the overall latencies. It all depends on the driver 
> and how it interfaces with the rest of the kernel, especially 
> what locks are shared and how long the lock are taken. If 
> they are small enough, interrupt context and thus raw 
> spinlocks are good enough. In general, I think each driver 
> ought to be configurable: Either it runs in interrupt context 
> or it runs in a thread. The locks have to be changed 
> accordingly from raw spinlocks to mutexes.
> 

You can run interrupts in threads without any mutex.

There is a /proc interface to switch between threads / mutex.

