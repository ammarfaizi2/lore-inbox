Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271907AbRHVAvy>; Tue, 21 Aug 2001 20:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269641AbRHVAvo>; Tue, 21 Aug 2001 20:51:44 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:48655 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271907AbRHVAvb>; Tue, 21 Aug 2001 20:51:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
Date: Wed, 22 Aug 2001 02:58:12 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>
In-Reply-To: <20010820230909.A28422@oisec.net> <20010821172029Z16065-32384+285@humbolt.nl.linux.org> <15234.58438.146372.874293@abasin.nj.nec.com>
In-Reply-To: <15234.58438.146372.874293@abasin.nj.nec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010822005135Z16145-32383+772@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 22, 2001 12:44 am, Sven Heinicke wrote:
> Great, with 2.4.8-ac8 I get no memory problems.  Can you tell me what
> file(s) where modified to fix this to I can look for the fixes in
> future vanilla kernels?
> 
> Thanks!  Now to work on the drive speed problem, it's faster with your
> fix but still slower at writing then my IDE drive on another systems.

It's a highmem scanning problem, these were supposed to be fixed in a series 
of changes back in 2.4.8-pre, but they're not completely gone yet.  I've cc'd
a few people who've shown interest in this ugly^H^H^H^H particular corner of
the kernel, but now I'm shutting down for the night.  Guys, can you please
take a look at this one?  It's time to put the highmem allocation problem
definitively to rest.  Most likely, this problem occurs in -ac as well, just
with less frequency.

> Daniel Phillips writes:
>  > On August 21, 2001 06:48 pm, Sven Heinicke wrote:
>  > > Yes, highmem was on, the stystem got 4G of memory.  I turned off
>  > > highmem and got no messages apart from one:
>  > > 
>  > > Aug 21 07:29:19 ps1 kernel: (scsi0:A:0:0): Locking max tag count at 64
>  > > 
>  > > which I was getting before.
>  > >
>  > > Disk access is faster then before but still slower then the IDE
>  > > drive.  Any ideas?
>  > 
>  > Two separate problems, I think.  I don't know anything about the aic7xxx 
>  > driver but I can take a look at the highmem problem.  First, can you try
>  > it with highmem enabled, on a recent -ac kernel, say 2.4.8-ac7.
>  > 
>  > --
>  > Daniel

--
Daniel
