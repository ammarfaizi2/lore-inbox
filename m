Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129068AbRAaXDV>; Wed, 31 Jan 2001 18:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129037AbRAaXDM>; Wed, 31 Jan 2001 18:03:12 -0500
Received: from mail2.galactica.it ([212.41.208.19]:15378 "EHLO galactica.it")
	by vger.kernel.org with ESMTP id <S129097AbRAaXDF>;
	Wed, 31 Jan 2001 18:03:05 -0500
Message-ID: <000901c08bda$1f3b8660$6a157a3e@xxx>
From: "Gian Piero Sala" <gpierosala@galactica.it>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Compiling 2.4.1: undefined reference to `__buggy_fxsr_alignment'
Date: Thu, 1 Feb 2001 00:04:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
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

I have the *same* problem.
I'm using pgcc-2.95.2.1 & binutils 2.10.1 with glibc-2.2.1.
Previous kernels compiled pretty well.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
