Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVJKR7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVJKR7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 13:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVJKR7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 13:59:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:3763 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932238AbVJKR7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 13:59:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux@horizon.com,
       Kirill Korotaev <dev@sw.ru>, dada1@cosmosbay.com
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8 bits
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
	<1129035658.23677.46.camel@localhost.localdomain>
	<Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
	<434BDB1C.60105@cosmosbay.com>
	<Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 11 Oct 2005 19:59:04 +0200
In-Reply-To: <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
Message-ID: <p73ll10rl3r.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 11 Oct 2005, Eric Dumazet wrote:
> >
> > As NR_CPUS might be > 128, and every spining CPU decrements the lock, we need
> > to use more than 8 bits for a spinlock. The current (i386/x86_64)
> > implementations have a (theorical) bug in this area.

I already queued a patch for x86-64 for this for post 2.6.14
following earlier complaints from Eric.

iirc on 32bit there are other issues though like limited
number of reader lock users.

But then I'm not sure why anybody would want to run a 32bit
kernel on such a big machine ...

> I don't think there are any x86 machines with > 128 CPU's right now.

Someone at Unisys just needs to put dual core hyper threaded CPUs
into their 64 socket systems, then you'll have a 256 CPU x86 machine
(which is currently the maximum the APICs can take anyways...) 
With Multicores being on everybody's roadmap we'll probably see 
such big systems soon.

-Andi
