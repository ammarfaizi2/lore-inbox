Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUJ0CIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUJ0CIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUJ0CHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:07:14 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:16271 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261562AbUJ0CF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:05:27 -0400
Message-ID: <417F025F.5080001@yahoo.com.au>
Date: Wed, 27 Oct 2004 12:05:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random>
In-Reply-To: <20041027005425.GO14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> the per-classzone kswapd treshold was very well taken care of in 2.4,
> thanks the watermarks embedding the low/min/high and the classzone being
> passed up to the kswapd wakeup function.
> 

Kswapd actually should take care of this properly: see the
initial loop before the real scanning loop.

I thought this was a bit subtle, but it seems to work fine,
and Andrew likes it.

I have a patch to explicitly have kswapd use the lower zone
protection watermarks but I haven't really demonstrated it is
better than what is currently there (other than being simpler).
