Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292708AbSBYQdL>; Mon, 25 Feb 2002 11:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291957AbSBYQcv>; Mon, 25 Feb 2002 11:32:51 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22946 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S292708AbSBYQcq>; Mon, 25 Feb 2002 11:32:46 -0500
Date: Mon, 25 Feb 2002 11:32:40 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>, mingo@elte.hu,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020225113239.A11675@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0202250808150.3268-100000@home.transmeta.com> <E16fOAO-0005Ml-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16fOAO-0005Ml-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 25, 2002 at 04:39:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 04:39:56PM +0000, Alan Cox wrote:
> _alloca
> mmap
> 
> Still fits on the stack 8)

Are we sure that forcing semaphore overhead to the size of a page is a 
good idea?  I'd much rather see a sleep/wakeup mechanism akin to wait 
queues be exported by the kernel so that userspace can implement a rich 
set of locking functions on top of that in whatever shared memory is 
being used.

		-ben
