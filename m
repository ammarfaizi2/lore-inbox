Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbSKHQDi>; Fri, 8 Nov 2002 11:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266518AbSKHQDh>; Fri, 8 Nov 2002 11:03:37 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:27342 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266507AbSKHQDh>;
	Fri, 8 Nov 2002 11:03:37 -0500
Date: Fri, 8 Nov 2002 16:09:55 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] epoll bits 0.30 ...
Message-ID: <20021108160955.GA30234@bjl1.asuk.net>
References: <20021106124607.09da5e1c.rusty@rustcorp.com.au> <Pine.LNX.4.44.0211061641180.953-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211061641180.953-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Rusty, the hash is not under pressure over there. The only time seeks is
> performed is at file removal ( from the set ) and eventually at file
> modify. There's a direct link between the wait queue and its item during
> the high frequency event delivery, so need seek is performed.

It does seem peculiar to use a prime-sized hash table, though.  These
days, good power-of-two-sized hash functions are well known.

-- Jamie
