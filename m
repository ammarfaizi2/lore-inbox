Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270433AbRHNEdc>; Tue, 14 Aug 2001 00:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270436AbRHNEdW>; Tue, 14 Aug 2001 00:33:22 -0400
Received: from chinook.Stanford.EDU ([171.64.93.186]:21888 "EHLO
	chinook.stanford.edu") by vger.kernel.org with ESMTP
	id <S270433AbRHNEdG>; Tue, 14 Aug 2001 00:33:06 -0400
Date: Mon, 13 Aug 2001 21:33:19 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-pre1 NFS problem
Message-ID: <20010813213319.A2253@chinook.stanford.edu>
In-Reply-To: <20010813114636.A4641@chinook.stanford.edu> <200108131933.f7DJXjX20270@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108131933.f7DJXjX20270@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
X-Mailer: Mutt http://www.mutt.org/
From: Max Kamenetsky <maxk@chinook.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@transmeta.com> [08/13/01 18:40] wrote:
> In article <20010813114636.A4641@chinook.stanford.edu> you write:
> >It looks like 2.4.9-pre1 breaks the NFS server.  Directories still get
> >exported and clients can mount them fine, but the ls command on the
> >client fails to report any files.  Filename completion also doesn't
> >work.  However, files can still be viewed if you know the exact file
> >name.
> 
> Yes, there's a missing off_t -> loff_t change in pre1, and the compile
> will even warn about it...
> 
> >The same problem happens with 2.4.9-pre2.
> 
> ..but I thought I fixed it in pre2. 
> 
> HOWEVER - there are a few others that I missed because the NFSD layer is
> doing ugly casts of function pointers (don't ask me why - it should have
> the right type in 'filldir_t' already but wants to use its own type), so
> the compiler can't warn about it. 
> 
> Let's hear it for type safety and avoiding ugly casts.
> 
> Anyway, here's the patch - does this fix it for you?

[snip patch]

I didn't try the patch, but 2.4.9-pre3 fixes the problem.  I'm
assuming the patch is in that kernel version.

Max

