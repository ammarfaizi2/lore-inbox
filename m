Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286228AbRLJLVz>; Mon, 10 Dec 2001 06:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286229AbRLJLVf>; Mon, 10 Dec 2001 06:21:35 -0500
Received: from [195.66.192.167] ([195.66.192.167]:17421 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286228AbRLJLV3>; Mon, 10 Dec 2001 06:21:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Pavel Machek <pavel@suse.cz>, Quinn Harris <quinn@nmt.edu>
Subject: Re: File copy system call proposal
Date: Mon, 10 Dec 2001 13:20:07 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu> <20011209153522.A138@toy.ucw.cz>
In-Reply-To: <20011209153522.A138@toy.ucw.cz>
MIME-Version: 1.0
Message-Id: <01121013200704.01165@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 December 2001 13:35, Pavel Machek wrote:
> > I would like to propose implementing a file copy system call.
> > I expect the initial reaction to such a proposal would be "feature
> > bloat" but I believe some substantial benefits can be seen possibly
> > making it worthwhile, primarily the following:
> >
> > Copy on write:
>
> You want cowlink() syscall, not copy() syscall. If they are on different
> partitions, let userspace do the job.

A filesystem with support of COW files would be *extremely* useful,
especially when writes trigger COW on block level, not file-by-file.

And it will definitely need in-kernel copyfile()/cowlink()/whatever name you 
want...

> > Will many other users benefit from these features?  Will implementing
> > them (especially copy on write) cause an excessive addition to the code
> > of the kernel?

> Hmm, I have almost 20 different copies of kernel on my systems.... Yep it
> would save me a *lot* of space.

Me too
--
vda
