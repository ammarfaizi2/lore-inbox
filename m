Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbRDKBI2>; Tue, 10 Apr 2001 21:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDKBIT>; Tue, 10 Apr 2001 21:08:19 -0400
Received: from ns.suse.de ([213.95.15.193]:46350 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132516AbRDKBIB>;
	Tue, 10 Apr 2001 21:08:01 -0400
Date: Wed, 11 Apr 2001 03:07:39 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Weinehall <tao@acc.umu.se>, Andi Kleen <ak@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
Message-ID: <20010411030739.A29277@gruyere.muc.suse.de>
In-Reply-To: <20010411021318.A21221@khan.acc.umu.se> <Pine.LNX.4.31.0104101750320.15069-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104101750320.15069-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Apr 10, 2001 at 05:55:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 05:55:09PM -0700, Linus Torvalds wrote:
> Note that the "fixup" approach is not necessarily very painful at all,
> from a performance standpoint (either on 386 or on newer CPU's). It's not
> really that hard to just replace the instruction in the "undefined
> instruction"  handler by having strict rules about how to use the "xadd"
> instruction.

Fixup for user space is probably not that nice (CMPXCHG is used there by 
linuxthreads) 


-Andi


