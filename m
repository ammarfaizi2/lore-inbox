Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbSJEAzA>; Fri, 4 Oct 2002 20:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261790AbSJEAzA>; Fri, 4 Oct 2002 20:55:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52232 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261786AbSJEAy7>; Fri, 4 Oct 2002 20:54:59 -0400
Date: Fri, 4 Oct 2002 18:02:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <Pine.GSO.4.21.0210042045010.21250-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210041755310.2993-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Alexander Viro wrote:
> 
> Hell knows.  The only explanation I see (and that's not worth much) is that
> we somehow confuse the chipset and get crapped on something like next cache
> miss.

I don't see any better explanation right now, so I guess we just revert 
that thing.

The only other notion I might come up with is stack corruption, ie the
code in pci_read_bases() might corrupt the return stack subtly (it does
add another local variable whose address is taken), causing a jump to a
random address on return. Compiler bug?

		Linus

