Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbTLNEdH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 23:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265345AbTLNEdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 23:33:07 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:5764 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S265343AbTLNEdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 23:33:04 -0500
Date: Sun, 14 Dec 2003 04:32:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][RFC] HT scheduler
Message-ID: <20031214043245.GC21241@mail.shareable.org>
References: <20031213022038.300B22C2C1@lists.samba.org> <3FDAB517.4000309@cyberone.com.au> <brgeo7$huv$1@gatekeeper.tmr.com> <3FDBC876.3020603@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDBC876.3020603@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> >Shared runqueues sound like a simplification to describe execution units
> >which have shared resourses and null cost of changing units. You can do
> >that by having a domain which behaved like that, but a shared runqueue
> >sounds better because it would eliminate the cost of even considering
> >moving a process from one sibling to another.
> 
> You are correct, however it would be a miniscule cost advantage,
> possibly outweighed by the shared lock, and overhead of more
> changing of CPUs (I'm sure there would be some cost).

Regarding the overhead of the shared runqueue lock:

Is the "lock" prefix actually required for locking between x86
siblings which share the same L1 cache?

-- Jaime
