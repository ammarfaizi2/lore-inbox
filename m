Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313200AbSDDPjG>; Thu, 4 Apr 2002 10:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313154AbSDDPi5>; Thu, 4 Apr 2002 10:38:57 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:15215 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S313200AbSDDPil>;
	Thu, 4 Apr 2002 10:38:41 -0500
Date: Thu, 4 Apr 2002 16:35:33 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Ingo Molnar <mingo@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.44.0204040747260.25330-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0204041625250.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Ingo Molnar wrote:
> The GPL right now protects our work from being abused in such a way - it's
> illegal to provide a binary-only sched.o and compile a kernel product from
> that, because the resulting kernel is still one work and the whole work
> must still be under the GPL. It's equally illegal to recover the location
> of sched.o in the final kernel image and runtime relink it with a
> binary-only sched.o. It's equally illegal to accomplish the same over the
> internal module interface.
>
> Think about it, every separate .o in the Linux kernel can be equivalently
> expressed in terms of a EXPORT-ed module interface, GPL-ed header files
> and a closed-source module. There is a good reason why the GPL forbids
> such freely defined 'module interfaces' to be added. Think of the GPL as
> the price you pay for being able to use the Linux kernel's source code or
> being allowed to link to it - you are not forced in any way to do that.
>
> and no, you have no *right* to link a binary-only sched.o to the Linux
> kernel - even if you develop a sched.c 'separately' - and intuitively feel
> that it's somehow a separate work, the end result is still a derivative of
> the kernel. And this violation of the license is illegal in most
> countries, it's even a crime in some countries.

After thinking about it for a while (and careful reading of your
explanation) I must conclude that your view is probably safer, i.e. in
the long term it is probably better for the Linux kernel to protect its
status along the lines you described, even if it is not as "smooth" or
"convenient to everyone" as the scheme I was talking about.

On the issue of what should be considered a derivative and what shouldn't,
from your email it seems (and it's not a bad thing, imho) that the Linux
kernel is protecting itself to make sure that "interesting" functionality
is either already in the kernel or exists as a GPL'd module.

To make this thought clearer, let's say that there is no GPL'd journalling
filesystem for Linux (i.e. reiserfs, ext3 and others suddenly
disappeared). Then, to make your thoughts consistent you would need to
disable the exported interfaces required for development of a journalling
filesystem. Because, otherwise, you would be working on a "lite" OS and
"interesting stuff will happen behind the closed doors". As I said, it is
not necesserily "bad", i.e. it may well be necessary for Linux's survival
and therefore I am all for it. I only thought that there is something
_technically_ unpleasant or "wrong" about it... Maybe "wrong" is the wrong
word, but you know what I mean.

Regards,
Tigran


