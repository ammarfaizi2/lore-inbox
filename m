Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264416AbRGISCP>; Mon, 9 Jul 2001 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264433AbRGISCG>; Mon, 9 Jul 2001 14:02:06 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64273 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264416AbRGISBx>; Mon, 9 Jul 2001 14:01:53 -0400
Date: Mon, 9 Jul 2001 11:00:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: msync() bug
In-Reply-To: <Pine.LNX.4.21.0107091852580.923-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0107091058490.14375-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Jul 2001, Hugh Dickins wrote:
>
> As it stands, yes.  But shouldn't there be some kind of VM_ASIFRESERVED
> vma flag to treat all its pages as if they were reserved, for /dev/mem?

Sure, that is doable. We do in fact already have the flag - you could
think of the VM_IO as that kind of flag already. I wouldn't object to that
kind of change in the 2.5.x timeframe. We already have vmscan ignoring
VM_IO objects, we could do the same to copy_mm() and to mmdrop().

		Linus

