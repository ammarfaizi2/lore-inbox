Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265191AbSJPQiJ>; Wed, 16 Oct 2002 12:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265192AbSJPQiJ>; Wed, 16 Oct 2002 12:38:09 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:5539 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265191AbSJPQiH>; Wed, 16 Oct 2002 12:38:07 -0400
Date: Wed, 16 Oct 2002 11:43:57 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Matthew Wilcox <willy@debian.org>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Allow compilation with -ffunction-sections
In-Reply-To: <20021016145113.E15163@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0210161140300.1904-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Matthew Wilcox wrote:

> If you compile the kernel with -ffunction-sections, each function gets
> put in a section .text.function_name.  This collides with our current use
> of .text.init.  So here's a patch which converts x86 to use .init.text
> instead.
> 
> I've tested it on x86 and it still frees 120k of ram, so it seems to work.
> Other architectures will need to change their vmlinux.lds appropriately,
> and may need other changes (arm, m68k seem to use .text.init verbatim).

Just in case anybody feels bored, maybe someone wants to come up with a
include/asm-generic/vmlinux.lds.S (or a better name) which has the common 
part of all the arch's vmlinux.lds.S - so we could make such changes like
you're proposing at one place in the future.

Since all vmlinux.lds.S get preprocessed by the C preprocessor, putting
an "#include <asm-generic/vmlinux.lds.S>" in there should be easy enough 
instead of all the current duplication.

--Kai


