Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRAaXHW>; Wed, 31 Jan 2001 18:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129530AbRAaXHM>; Wed, 31 Jan 2001 18:07:12 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:37302 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129227AbRAaXHB>; Wed, 31 Jan 2001 18:07:01 -0500
Message-ID: <3A789A81.78A59680@Home.net>
Date: Wed, 31 Jan 2001 18:06:41 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Yourst <yourst@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.4.1: undefined reference to `__buggy_fxsr_alignment'
In-Reply-To: <3A788DDE.AF82E72F@mit.edu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pgcc borks 2.4.1 kernel and prereleases (sadly I found this out the same
way).

Shawn.
Matt Yourst wrote:

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
> -------------------------------------------------------------
>  Matt T. Yourst        Massachusetts Institute of Technology
>  yourst@mit.edu                                 617.225.7690
>  513 French House - 476 Memorial Drive - Cambridge, MA 02139
> -------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
