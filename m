Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2SWj>; Fri, 29 Dec 2000 13:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2SW3>; Fri, 29 Dec 2000 13:22:29 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:40371 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129930AbQL2SWN>; Fri, 29 Dec 2000 13:22:13 -0500
Date: Fri, 29 Dec 2000 17:54:36 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Tim Wright <timw@splhi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
In-Reply-To: <20001229083014.A3096@scutter.internal.splhi.com>
Message-ID: <Pine.LNX.4.21.0012291712310.3592-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000, Tim Wright wrote:
> Yes, this is a very important point if we ever want to make serious use
> of large memory machines on ia32. We ran into this with DYNIX/ptx when the
> P6 added 36-bit physical addressing. Conserving KVA (kernel virtual address
> space), became a very high priority. Eventually, we had to add code to play
> silly segment games and "magically" materialize and dematerialize a 4GB
> kernel virtual address space instead of the 1GB. This only comes into play
> with really large amounts of memory, and is almost certainly not worth the
> agony of implementation on Linux, but we'll need to be careful elsewhere to
> conserve it as much as possible.

  Indeed.  I'm compiling my kernels with 2GB virtual.  Not as I want more
NORMAL pages in the page cache (HIGH memory is fine), but as I need
NORMAL pages for kernel data/structures (memory allocated from  
slab-caches) which need to be constantly mapped in.

Mark


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
