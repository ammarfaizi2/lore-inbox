Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWJPXPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWJPXPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWJPXPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:15:48 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:27644 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750731AbWJPXPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:15:47 -0400
Subject: Re: [PATCH] generic signal code (small new feature - userspace
	signal mask), kernel 2.6.16
From: Nicholas Miell <nmiell@comcast.net>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       gk@garethknight.com
In-Reply-To: <p731wp8e6ew.fsf@verdi.suse.de>
References: <5B1B60D4-4259-4720-A5A5-9691CA59E250@garethknight.com>
	 <Pine.LNX.4.64.0610152025300.3962@g5.osdl.org>
	 <p731wp8e6ew.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 16:15:37 -0700
Message-Id: <1161040537.2379.3.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 15:28 +0200, Andi Kleen wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > Why? You're doing user-space accesses from within critical sections with a 
> > spinlock, and that's just a big no-no. Think page faults, swapping etc.
> 
> He could pin the page in memory like futexes do. One page pinned
> per thread shouldn't be a big DOS issue either.
> 
> -Andi

Whatever the final solution ends up being (assuming this actually goes
somewhere), it should be extensible enough for other uses (for example,
some sort of "please don't preempt me right now" hint for use with
pthread spinlocks.)


-- 
Nicholas Miell <nmiell@comcast.net>

