Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWKGMcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWKGMcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWKGMcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:32:33 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:25018 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750953AbWKGMcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:32:32 -0500
Message-ID: <45507CD4.5030600@garzik.org>
Date: Tue, 07 Nov 2006 07:32:20 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [take21 0/4] kevent: Generic event handling mechanism.
References: <11619654014077@2ka.mipt.ru> <45506D51.30604@garzik.org> <20061107115111.GA13028@2ka.mipt.ru>
In-Reply-To: <20061107115111.GA13028@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Mmap ring buffer implementation was stopped by Andrew Morton and Ulrich
> Drepper, process' memory is used instead. copy_to_user() is slower (and
> some times noticebly), but there are major advantages of such approach.


hmmmm.  I say there are advantages to both.

Perhaps create a "kevent_direct_limit" resource limit for each thread. 
By default, each thread could mmap $n pinned pagecache pages.  Sysadmin 
can tune certain app resource limits to permit more.

I would think that retaining the option to avoid copy_to_user() 
-somehow- in -some- cases would be wise.

	Jeff


