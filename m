Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317464AbSGaXfE>; Wed, 31 Jul 2002 19:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318552AbSGaXfE>; Wed, 31 Jul 2002 19:35:04 -0400
Received: from [143.166.83.88] ([143.166.83.88]:12809 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S317464AbSGaXfD>; Wed, 31 Jul 2002 19:35:03 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <F44891A593A6DE4B99FDCB7CC537BBBBB839AD@AUSXMPS308.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: peter@chubb.wattle.id.au
cc: pavel@ucw.cz, viro@math.psu.edu, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: RE: 2.5.28 and partitions
Date: Wed, 31 Jul 2002 18:38:24 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1156AB7B5243327-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Matt> What's wrong with EFI GUID scheme (GPT) (other than it wasn't
> Matt> invented by Linux folks)?
> 
> Nothing, except it's not used on all platforms yet.

(set boot issues aside for now)
It could.  I use it on x86 and IA-64 now.  I think Richard Hirst found the
last (knock on wood) of my endianness bugs about 6 months ago, so I know it
works on BE and LE non-Intel machines.  It's in the partitioning menu, not
specific to arch.  The only arch dependency in code is on asm-ia64/efi.h for
some typedefs, which is annoying but not hard to fix if desired (move
relevant bits to include/linux/efi.h).

> For my machines the *only* reason for having a legacy partitioning
> scheme is to allow booting.

As you point out, booting is BIOS-specific.  So for now boot a disk with a
native scheme (where your OS resides already) and mount that 64XB file
system for data afterwords.  By the time that doesn't work, 32-bit CPUs will
be dead anyhow.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

