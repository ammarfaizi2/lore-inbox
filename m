Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSKZU5h>; Tue, 26 Nov 2002 15:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSKZU5h>; Tue, 26 Nov 2002 15:57:37 -0500
Received: from jdike.solana.com ([198.99.130.100]:11904 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S261205AbSKZU5h>;
	Tue, 26 Nov 2002 15:57:37 -0500
Message-Id: <200211262107.gAQL7OX01356@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.49-1 
In-Reply-To: Your message of "Tue, 26 Nov 2002 12:37:32 MST."
             <20021126123732.H9054@schatzie.adilger.int> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Nov 2002 16:07:24 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adilger@clusterfs.com said:
> How does GDB now distinguish between UML processes?  Previously, with
> GDB and UML one would "det; att <host pid>" to trace another process.
> Will there be equivalent functionality in the new setup?

It now doesn't.  What I'm considering is some function you can call from
gdb which would longjmp to the stack that you want to look at and execute
a breakpoint (or maybe just hit a breakpoint that was put there earlier).

That should give you equivalent functionality to the current det/att.

> Will SMP UML "just" be a matter of forking the host process and
> sharing the /proc/mm file descriptors, along with a UML SMP scheduler
> and some IPC to decide which host process is running each UML process?

Pretty much.  It's basically the same as SMP in tt mode, except that starting
the idle threads will be slightly different.

				Jeff

