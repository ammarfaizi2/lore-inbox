Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLPPHW>; Sat, 16 Dec 2000 10:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLPPHM>; Sat, 16 Dec 2000 10:07:12 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:65288 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129345AbQLPPHF>;
	Sat, 16 Dec 2000 10:07:05 -0500
Date: Sat, 16 Dec 2000 16:35:40 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: mark_inode_dirty question
In-Reply-To: <20001216152653.A26034@inspiron.random>
Message-ID: <Pine.LNX.4.10.10012161632420.10851-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Andrea Arcangeli wrote:

> On Sat, Dec 16, 2000 at 02:47:16PM +0200, Jani Monoses wrote:
> > mark_inode_dirty and mark_inode_dirty_sync .Could the i_state be changed
> > during the call (on another CPU)?
> 
> no because you're protected by the inode_lock.
> 
> Andrea
> 

Thanks but
I meant between the moment the call from mark_* is made and the lock is
taken.I suppose it can be changed thus the double check in both caller and
callee.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
