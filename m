Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265318AbTLNBlm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 20:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbTLNBlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 20:41:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:42404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265318AbTLNBll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 20:41:41 -0500
Date: Sat, 13 Dec 2003 17:41:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
In-Reply-To: <20031213222626.GA20153@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0312131740120.14336@home.osdl.org>
References: <20031213114134.GA9896@skeleton-jack> <20031213222626.GA20153@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Dec 2003, Jamie Lokier wrote:
>
> Peter Horton wrote:
> > A quick look at sparc and sparc64 seem to show the same problem.
>
> D-cache incoherence with unsuitably aligned multiple MAP_FIXED
> mappings is also observed on SH4, SH5, PA-RISC 1.1d.  The kernel may
> have the same behaviour on those platforms: allowing a mapping that
> should not be allowed.

Why?

If the user asks for it, it's the users own damn fault. Nobody guarantees
cache coherency to users who require fixed addresses.

Just document it as a bug in the user program if this causes problems.
Don't blame the kernel - the kernel is only doing what the user asked it
to do.

		Linus
