Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291258AbSCDEPV>; Sun, 3 Mar 2002 23:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291269AbSCDEPL>; Sun, 3 Mar 2002 23:15:11 -0500
Received: from slip-202-135-78-125.ad.au.prserv.net ([202.135.78.125]:17536
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S291258AbSCDEPB>; Sun, 3 Mar 2002 23:15:01 -0500
Date: Sun, 3 Mar 2002 18:07:21 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com, mingo@elte.hu,
        matthew@hairy.beasts.org, david@mysql.com, wli@holomorphy.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-Id: <20020303180721.57f36b07.rusty@rustcorp.com.au>
In-Reply-To: <20020225113239.A11675@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0202250808150.3268-100000@home.transmeta.com>
	<E16fOAO-0005Ml-00@the-village.bc.nu>
	<20020225113239.A11675@redhat.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002 11:32:40 -0500
Benjamin LaHaise <bcrl@redhat.com> wrote:

> On Mon, Feb 25, 2002 at 04:39:56PM +0000, Alan Cox wrote:
> > _alloca
> > mmap
> > 
> > Still fits on the stack 8)
> 
> Are we sure that forcing semaphore overhead to the size of a page is a 
> good idea?  I'd much rather see a sleep/wakeup mechanism akin to wait 
> queues be exported by the kernel so that userspace can implement a rich 
> set of locking functions on top of that in whatever shared memory is 
> being used.

Unfortunately, no.  You need to know what userspace is using them for so
you can check to avoid the "add to waitqueue" race.

AFAICT a mutex is the simplest useful primitive that can be realistically
exported.

Hope that helps,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
