Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288624AbSAQMMX>; Thu, 17 Jan 2002 07:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288633AbSAQMMN>; Thu, 17 Jan 2002 07:12:13 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:13787 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288624AbSAQMMD>; Thu, 17 Jan 2002 07:12:03 -0500
Date: Thu, 17 Jan 2002 12:14:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Christoph Rohland <cr@sap.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <m3u1tll6pb.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0201171206350.1051-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Christoph Rohland wrote:
> On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> > They were running out of pagetables, mapping 1G per-task (shm for
> > example) will overflow the lowmem zone with PAE with some houndred
> > tasks in the system. They were pointing the finger at the VM but the
> > VM was just doing the very right thing to do.
> 
> This lets me think about putting the swap vector of shmem into highmem
> also. These can get big on highend servers and exactly these servers
> tend to use a lot of shared mem.

Yes, good idea.

But people should realize that moving page tables and other such
structures into not-always-mapped highmem will make them harder to
access with kernel debuggers - I think those will want some changes.

Hugh

