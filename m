Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUE0L2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUE0L2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 07:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUE0L2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 07:28:07 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:65234 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261932AbUE0L2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 07:28:04 -0400
Date: Thu, 27 May 2004 13:27:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, mingo@elte.hu, andrea@suse.de,
       riel@redhat.com, torvalds@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527112705.GA21190@wohnheim.fh-wedel.de>
References: <1ZQpn-1Rx-1@gated-at.bofh.it> <1ZQz8-1Yh-15@gated-at.bofh.it> <1ZRFf-2Vt-3@gated-at.bofh.it> <203Zu-4aT-15@gated-at.bofh.it> <206b3-5WN-33@gated-at.bofh.it> <20baw-1Lz-15@gated-at.bofh.it> <m38yff7zn3.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m38yff7zn3.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 21:32:32 +0200, Andi Kleen wrote:
> "David S. Miller" <davem@redhat.com> writes:
> 
> >> Change gcc to catch stack overflows before the fact and disallow
> >> module load unless modules have those checks as well.
> 
> It's impossible to do anything but panic, so it's not too helpful
> in practice.

Oh, panic is *very* helpful.  Panic won't do random funny things, it
will just stop the machine.  If we got an immediate panic on any stack
overflow, I would want 4k stacks right now.

> > That's easy, just enable profiling then implement a suitable
> > _mcount that checks for stack overflow.  I bet someone has done
> > this already.
> 
> I did it for x86-64 a long time ago. Should be easy to port to i386 
> too.
> 
> ftp://ftp.x86-64.org/pub/linux/debug/stackcheck-1

Cool!  If that is included, I don't have any objections against 4k
stacks anymore.

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
