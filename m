Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135632AbRDSLtx>; Thu, 19 Apr 2001 07:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135634AbRDSLtm>; Thu, 19 Apr 2001 07:49:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30988 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135632AbRDSLt3>; Thu, 19 Apr 2001 07:49:29 -0400
Subject: Re: light weight user level semaphores
To: alonz@nolaviz.org (Alon Ziv)
Date: Thu, 19 Apr 2001 12:51:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List),
        mkravetz@sequent.com (Mike Kravetz),
        drepper@cygnus.com (Ulrich Drepper),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <023c01c0c8a9$a4bb9940$910201c0@zapper> from "Alon Ziv" at Apr 19, 2001 10:20:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qCy0-00071d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My lightweight-semaphores were actually even simpler in userspace:
> * the userspace struct was just a signed count and a file handle.
> * Uncontended case is exactly like Linus' version (i.e., down() is decl +
> js, up() is incl()).
> * The contention syscall was (in my implementation) an ioctl on the FH; the
> FH was a special one, from a private syscall (although with the new VFS I'd
> have written it as just another specialized FS, or even referred into the
> SysVsem FS).

Which raises an even more interesting question. Suppose your semaphore function
wanst a magic file system but was flock on a standard file ? The contention
overhead is rather less nice than Linus proposal but it ought 8) to work 
without any kernel patches

