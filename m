Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269088AbUJUNAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269088AbUJUNAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUJUM4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:56:42 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:48045 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268831AbUJUMoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:44:15 -0400
Date: Thu, 21 Oct 2004 14:45:05 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041021124505.GD8756@dualathlon.random>
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <16759.38054.944944.610417@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16759.38054.944944.610417@alkaid.it.uu.se>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 12:51:18PM +0200, Mikael Pettersson wrote:
> Have you verified that? GCCs up to and including 2.95.3 and
> early versions of 2.96 miscompiled the kernel when spinlocks
> where empty structs on UP. I.e., you might not get a compile-time
> error but runtime corruption instead.

peraphs we should add a check on the compiler and force people to use
gcc >= 3?

Otherwise adding an #ifdef will fix 2.95, just like the spinlock does in
UP.

btw, the only machine where I still have gcc 2.95.3 is not uptodate
enough to run 2.6 regardless of the fact 2.6 could compile on such
machine or not.
