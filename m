Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVIDW3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVIDW3s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVIDW3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:29:48 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:54514 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932097AbVIDW3r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sszvKtI7fKo/FiCb/THHz24swHAqauKFxKPEkgmcDRjALrf1i5/w/FepB5XeqE9rGSROGM9raJbUSB+qUxvkC2UcH8xyjzo6ol0BGB31QaoptB+OucpNQLZmMF5DlcDqKU6HvnUitqKDExUzwVtAzEmIN0LXzxzGMJTQCuyv8xo=
Message-ID: <81b0412b0509041529524bca1f@mail.gmail.com>
Date: Mon, 5 Sep 2005 00:29:43 +0200
From: Alex Riesen <raa.lkml@gmail.com>
To: shappen@gmail.com
Subject: Re: threads questions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d2a0e906050903212678ad88a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d2a0e906050903212678ad88a1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Petter Shappen <shappen@gmail.com> wrote:
> As we all know the kernel maintain a data struct for the
> process(PCB),and also for the thread.Because of the latter's smaller
> than the former's,thread switching is faster than the process

not really. They just share some bits (like: address space, file
table, signal handlers, etc),
but aside from that - normal processes.

> switching.And from the book,I read that threads shares some data

What exactly is this book you're reading?

> information of the process,so my question is that when the threads of
> different processes have to switch,and the threads also use some data
> of the processes,will the process switch  before the threads?The speed
> of these threads switching is slower than normal,is that true ?

Why?

> How can the thread's advantage over process reflect?

It usually don't. Not noticably, in any case
