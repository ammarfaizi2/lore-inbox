Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265214AbRFVBaC>; Thu, 21 Jun 2001 21:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbRFVB3w>; Thu, 21 Jun 2001 21:29:52 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:62293 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265214AbRFVB3h>; Thu, 21 Jun 2001 21:29:37 -0400
Date: Fri, 22 Jun 2001 03:29:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
Message-ID: <20010622032918.H707@athlon.random>
In-Reply-To: <200106211814.f5LIEgK04880@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200106211814.f5LIEgK04880@snark.thyrsus.com>; from esr@snark.thyrsus.com on Thu, Jun 21, 2001 at 02:14:42PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Userland programs which request kernel services via normal system
							 ^^^^^^
>    calls *are not* to be considered derivative works of the kernel.

Please, at least don't say "normal" or it will be non obvious that it is
ok for the vsyscalls too (which aren't *that* normal system calls). I'd
rather use "via any kind of official system call (vsyscalls included)".
Otherwise I guess a malicious could try to say that the vsyscalls are
basically dynamically linking the userspace with the kernel (dynamically
linking GPL code in the kernel to whatever non GPL userspace).

vsyscalls cannot give any advantage to the dark side (satellite is
flooding me with the star wars movies sorry ;) anything you can do with
a vsyscall, you can do with a real syscall too, just slower.  They can
only improve performance when it is possible to provide the same
functionality without entering/exiting kernel. So nobody sane could ever
complain about the vsyscalls but since you're writing that stuff it
worth to make it explicit I think ;).

Thanks,

Andrea
