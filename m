Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbSKUNDB>; Thu, 21 Nov 2002 08:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbSKUNDB>; Thu, 21 Nov 2002 08:03:01 -0500
Received: from ns.suse.de ([213.95.15.193]:60932 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266643AbSKUNC4>;
	Thu, 21 Nov 2002 08:02:56 -0500
To: Margit Schubert-While <margit@margit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: L1_CACHE_SHIFT value for P4 ?
References: <4.3.2.7.2.20021121130236.00b15370@mail.dns-host.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Nov 2002 14:10:02 +0100
In-Reply-To: Margit Schubert-While's message of "21 Nov 2002 13:16:33 +0100"
Message-ID: <p73y97nt6fp.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Margit Schubert-While <margit@margit.com> writes:

E> What should be the value of L1_CACHE_SHIFT for a P4 ?
> L1_CACHE_BYTES is set to 1<<L1_CACHE_SHIFT
> 
> In the .config , I notice that L1_CACHE_SHIFT is being set to 7 for the P4.
> Surely that can't be right or ?

The P4 has 128byte L2 cache lines (2^7). The L1 apparently has smaller lines.

For practical reasons the L1_CACHE_BYTES defines should not be smaller than
the L2 line size - otherwise slab's cache colouring would not be very 
effective. In fact the symbol is a bit misnamed, it refers to all CPU caches.
So it needs to be 7.


-Andi
