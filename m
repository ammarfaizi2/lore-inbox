Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUCVSVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 13:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUCVSVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 13:21:39 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:24469 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262142AbUCVSVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 13:21:35 -0500
Message-Id: <200403221821.i2MILCox004241@eeyore.valparaiso.cl>
To: Russ Weight <rweight@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Disassemble vmlinuz (i386) 
In-Reply-To: Your message of "Mon, 22 Mar 2004 09:58:07 PST."
             <20040322175807.GA22404@us.ibm.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 22 Mar 2004 14:21:12 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russ Weight <rweight@us.ibm.com> said:
> 	Admittedly, you would have to be pretty desparate to want
> to disassemble vmlinuz... but I was... and I did.  There may
> be other (better?) ways to do this, but since I didn't find
> a complete recipe for this in my web searches, I'll post what
> I did in case it might be helpful to others.

When I needed to do stuff like this, I went back to the vmlinux
(uncompressed) which was lying around in the build directory. Or even to
the individual .o files.

> 	Note that this was done on a 2.4.9 kernel.
> 
> - Russ
> 
> 
> The short version:
> ==================
> (1) Strip the header and decompress the kernel

Or grab the uncompressed version (if available).

> (2) Write a small C program to copy the decompressed kernel
>     into a shared memory segment.

Placing it into a file and objdump(1) should give most of what you are
after... and you might also start gdb(1) on the file. Dunno if the weird
startup code/placement messes it up, but worth a try.

> (3) Run the C program under gdb - stop at a breakpoint after the
>     copy and then use the gdb "disassemble" command to disassemble
> 	the kernel from shared memory.
> (4) Clean up the addresses. If you pick a good virtual address
>     for the shared memory segment, then the cleanup can be a fairly
> 	simple search & replace.

May I ask what you were after?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
