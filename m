Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311108AbSCHUtd>; Fri, 8 Mar 2002 15:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311112AbSCHUtX>; Fri, 8 Mar 2002 15:49:23 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:20496 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S311108AbSCHUtL>; Fri, 8 Mar 2002 15:49:11 -0500
Date: Fri, 8 Mar 2002 20:48:25 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <20020308202836.7D8163FE06@smtp.linux.ibm.com>
Message-ID: <Pine.LNX.4.33.0203082046470.30551-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Hubertus Franke wrote:

> > So I would suggest making the size (and thus alignment check) of locks
> > at least 8 bytes (and preferably 16). That makes it slightly harder to
> > put locks on the stack, but gcc does support stack alignment, even if
> > the code sucks right now.

> Keeping it small, allows for the common case of mutex integration into
> data objects, though its not a big deal.

I guess we need to know what the requirements are of the fabled
"architectures which need special handling of PROT_SEM" before
we can tell whether this is a good idea or not.

Matthew.

