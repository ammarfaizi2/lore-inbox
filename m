Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274360AbRITIBF>; Thu, 20 Sep 2001 04:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274361AbRITIAz>; Thu, 20 Sep 2001 04:00:55 -0400
Received: from t2.redhat.com ([199.183.24.243]:56817 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274360AbRITIAu>; Thu, 20 Sep 2001 04:00:50 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Howells <dhowells@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Thu, 20 Sep 2001 09:19:54 +0200." <20010920091954.B4332@athlon.random> 
Date: Thu, 20 Sep 2001 09:01:13 +0100
Message-ID: <8929.1000972873@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli <andrea@suse.de> wrote:
> the process doesn't need to lock multiple mm_structs at the same time.

fork, ptrace, /proc/pid/mem, /proc/pid/maps

All have to be able to lock two process's mm_structs simultaneously, even if
it's indirectly through copy_to_user() or copy_from_user().

David
