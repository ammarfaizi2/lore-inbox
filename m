Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288999AbSAFSWC>; Sun, 6 Jan 2002 13:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289000AbSAFSVv>; Sun, 6 Jan 2002 13:21:51 -0500
Received: from unknown-1-11.windriver.com ([147.11.1.11]:8872 "EHLO
	mail.wrs.com") by vger.kernel.org with ESMTP id <S288999AbSAFSVi>;
	Sun, 6 Jan 2002 13:21:38 -0500
From: mike stump <mrs@windriver.com>
Date: Sun, 6 Jan 2002 10:20:47 -0800 (PST)
Message-Id: <200201061820.KAA19527@kankakee.wrs.com>
To: dewar@gnat.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: dewar@gnat.com
> To: dewar@gnat.com, paulus@samba.org
> Date: Sun,  6 Jan 2002 08:05:56 -0500 (EST)

> If you have a memory mapped byte, you really want a way of saying
> "when I read this byte, do a byte read, it will not work to do a
> word read"

> (volatile gets close in C, but is not close enough) will ensure a
> byte store in practice, but may not ensure byte reads.

?  Do you have an example where this fails?  Do you not consider it a
bug?  Now, I would place a fair amount of buren on the compiler to get
it right, though, this isn't absolute.  For example, eieieio or
whatever it is called on the powerpc.  I think the chip/OS/MMU must
bear some responsibility for meeting its obligations to the compiler,
and if it doesn't, then that chip/OS/MMU fails to provide a reasonable
base on which to provide the compiler.  Did you have this case in
mind?
