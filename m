Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316607AbSEUVVy>; Tue, 21 May 2002 17:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSEUVVx>; Tue, 21 May 2002 17:21:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14287 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316607AbSEUVVw>;
	Tue, 21 May 2002 17:21:52 -0400
Date: Tue, 21 May 2002 16:21:38 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: george anzinger <george@mvista.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] POSIX personality
Message-ID: <79630000.1022016098@baldur.austin.ibm.com>
In-Reply-To: <3CEAB85D.1532F5A2@mvista.com>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 21, 2002 02:13:01 PM -0700 george anzinger
<george@mvista.com> wrote:

> What you are proposing seem a bit vague.  I think that
> CLONE_THREAD should group all the thread related stuff under
> the one flag.  IMHO POSIX compatibility should not be off in
> the corner as a step child, but rather should be the norm. 
> The CLONE_THREAD flag would indicate to fork that it should
> create a POSIX thread and set up the needed shared stuff.  I
> rather image this to be a structure that each task_struct
> points to, possibly with a usage count (but that is a
> detail).  Each thread_struct would point to such a
> structure, but processes that are not threaded would not be
> sharing this area with other threads.

That's a possibility I've considered, but I gather most of the kernel
community would prefer to see each resource have its own flag to clone() so
applications can pick and choose which ones to share.  I'm guessing that in
most cases multithreaded apps will choose all flags.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

