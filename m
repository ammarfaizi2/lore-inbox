Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292062AbSBYRai>; Mon, 25 Feb 2002 12:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292035AbSBYRaW>; Mon, 25 Feb 2002 12:30:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49936 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292481AbSBYRaA>; Mon, 25 Feb 2002 12:30:00 -0500
Subject: Re: [PATCH] Lightweight userspace semaphores...
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Mon, 25 Feb 2002 17:42:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        rusty@rustcorp.com.au (Rusty Russell), mingo@elte.hu,
        matthew@hairy.beasts.org (Matthew Kirkwood),
        david@mysql.com (David Axmark),
        wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020225113239.A11675@redhat.com> from "Benjamin LaHaise" at Feb 25, 2002 11:32:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fP9P-0005aB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are we sure that forcing semaphore overhead to the size of a page is a 
> good idea?  I'd much rather see a sleep/wakeup mechanism akin to wait 
> queues be exported by the kernel so that userspace can implement a rich 
> set of locking functions on top of that in whatever shared memory is 
> being used.

The shared memory side of it has to be page sized. It doesn't mean you have
to have 1 semaphore per page but it does mean you have to allocate in page
sized chunks for mmu granularity

