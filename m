Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbRAaWR5>; Wed, 31 Jan 2001 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRAaWRh>; Wed, 31 Jan 2001 17:17:37 -0500
Received: from [64.64.109.142] ([64.64.109.142]:50697 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129110AbRAaWR0>; Wed, 31 Jan 2001 17:17:26 -0500
Message-ID: <3A788ECC.B8F48AB9@didntduck.org>
Date: Wed, 31 Jan 2001 17:16:44 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Yourst <yourst@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.4.1: undefined reference to `__buggy_fxsr_alignment'
In-Reply-To: <3A788DDE.AF82E72F@mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Yourst wrote:
> 
> Hi,
> 
> I just tried to compile 2.4.1 and I'm getting the error "undefined
> reference to `__buggy_fxsr_alignment'" when trying to do the final
> link. It looks like this check was something 2.4.1 added to
> include/asm-i386/bugs.h to fail the kernel build if part of the thread
> structure wasn't aligned on a 16-byte boundary (which seems to make
> sense given FXSR's alignment requirements.) When was this check added?
> I assumed it was a bug in 2.4.0 that was just recently discovered, but
> I didn't see anything in the ChangeLog to that effect.
> 
> The problem is that I don't know how to fix it (at least not reliably
> and cleanly.) I tried rearranging the fields in the task structure,
> but the alignment still wasn't right. I did apply a few non-standard
> patches that expanded the task structure, but the additional fields
> came well after the task's struct thread (which was causing the
> alignment problem.) FYI, I'm compiling with pgcc 2.95.2 and linking
> with binutils/ld 2.10 (I've used both of these successfully for
> countless kernel compiles before this.)
> 
> Anyone else had this problem?
> 
> - Matt Yourst
> 

What GCC version did you compile with?

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
