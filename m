Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSAKAnS>; Thu, 10 Jan 2002 19:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289812AbSAKAnI>; Thu, 10 Jan 2002 19:43:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45071 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289811AbSAKAmv>; Thu, 10 Jan 2002 19:42:51 -0500
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: Ronald.Wahl@informatik.tu-chemnitz.de (Ronald Wahl)
Date: Fri, 11 Jan 2002 00:54:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <m2sn9dn2kh.fsf@goliath.csn.tu-chemnitz.de> from "Ronald Wahl" at Jan 11, 2002 01:39:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Opxl-00066O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The compiler doesn't know, where the binary runs later. Or do you mean,
> that it has to insert some code that checks for the existance of these
> instructions during program start? Ok that would be a solution, but how
> do you do this for libraries that are not run in itself?

It means the compiler for -m686 shouldn't have assumed cmov was available

> > So you have a buggy rpm program. Get the rpm program fixed so it correctly
> > stops you from doing that.
> 
> Maybe, ok. But why should such a mistake prevent me from workin with the
> system when it could be easily catched? Ok, the emulation code may not

It can be easily caught. Thats what rpm is for. If it let you install that
package on a box that can run it without using --force type options its
a bug. 

> be easy, I dunno, but the infrastructure for emulation of instructions
> is already there (FPU emulation). To say its the admins fault is easy

FPU emulation should probably have been in glibc via a fault handler
but thats a historical story.

> but the costs of automatically catching such errors are little in
> respect of the benefit you get. A running system is always better than
> a unusable one even if it was the admins fault.

Then while you are it you can make the kernel magically recover from rm -rf /
or rm * in /lib...

