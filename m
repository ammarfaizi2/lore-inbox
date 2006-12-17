Return-Path: <linux-kernel-owner+w=401wt.eu-S932292AbWLQSQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWLQSQs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 13:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWLQSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 13:16:48 -0500
Received: from www.osadl.org ([213.239.205.134]:50672 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932292AbWLQSQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 13:16:48 -0500
From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Organization: Linutronix
To: Gleb Natapov <glebn@voltaire.com>
Subject: Re: uio and DMA memory allocations
Date: Sun, 17 Dec 2006 19:16:42 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <20061217150445.GC11360@minantech.com>
In-Reply-To: <20061217150445.GC11360@minantech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612171916.43534.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 17. Dezember 2006 16:04 schrieb Gleb Natapov:
> Hi Hans,
>
>    Will it be possible to allocate DMAable memory using uio
> framework (currently it isn't as far as I see).  More specifically
> if a driver needs memory allocated with dma_alloc_coherent() will
> it be possible to allocate it and map into userspace using uio?

Hi Gleb,
I didn't write such a driver yet, but it is certainly possible.
As a first thought, I think we need a small change in the uio 
framework mmap routine. AFAIK, dma_alloc_coherent() returns a
kernel virtual address that would not be handled properly by
the existing code. At the moment, we only have the choice between
logical and physical memory, we probably have to add virtual
memory, too. Thanks for that hint, I'll keep it in mind.

Hans

