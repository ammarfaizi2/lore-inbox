Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265902AbRGJHdP>; Tue, 10 Jul 2001 03:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265907AbRGJHdF>; Tue, 10 Jul 2001 03:33:05 -0400
Received: from t2.redhat.com ([199.183.24.243]:54776 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S265902AbRGJHcz>; Tue, 10 Jul 2001 03:32:55 -0400
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>
Cc: bcrl@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] read/write semaphore trylock routines - 2.4.6 
In-Reply-To: Your message of "Mon, 09 Jul 2001 20:32:13 PDT."
             <3B4A773D.50632896@compaq.com> 
Date: Tue, 10 Jul 2001 08:32:54 +0100
Message-ID: <16572.994750374@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A caveat for these trylock routines is that they use the cmpxchg
> instruction, which limits their usefulness on x86 to 486 and above.

Given that the implementation in that asm-i386/rwsem.h is based around usage
of the XADD instruction which exists everywhere the CMPXCHG instruction does
(I believe), you don't really need to put the #if clause around it.

You should also add spinlock versions too, which will cover most other archs.

David
