Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272559AbRITB7q>; Wed, 19 Sep 2001 21:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274124AbRITB70>; Wed, 19 Sep 2001 21:59:26 -0400
Received: from colorfullife.com ([216.156.138.34]:1811 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S272651AbRITB7V>;
	Wed, 19 Sep 2001 21:59:21 -0400
Message-ID: <006c01c14137$95c580c0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Andrea Arcangeli" <andrea@suse.de>, "David Howells" <dhowells@redhat.com>
Cc: "Linus Torvalds" <torvalds@transmeta.com>, <Ulrich.Weigand@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <torvalds@transmeta.com> <5079.1000911203@warthog.cambridge.redhat.com> <20010919200357.Z720@athlon.random>
Subject: Re: Deadlock on the mm->mmap_sem
Date: Wed, 19 Sep 2001 20:19:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if we go generic then I strongly recommend my version of the generic
> semaphores is _much_ faster (and cleaner) than this one (it even
allows
> more than 2^31 concurrent readers on 64 bit archs ;).
>
Andrea,

implementing recursive semaphores is trivial, but do you have any idea
how to fix the latency problem?
Multithreaded, iobound apps that use mmap are unusable with unfair
semaphores.

My test app hangs for minutes within mprotect().

--
    Manfred



