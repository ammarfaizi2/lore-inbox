Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSJJDYG>; Wed, 9 Oct 2002 23:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263077AbSJJDYF>; Wed, 9 Oct 2002 23:24:05 -0400
Received: from codepoet.org ([166.70.99.138]:65470 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S263039AbSJJDYE>;
	Wed, 9 Oct 2002 23:24:04 -0400
Date: Wed, 9 Oct 2002 21:29:51 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Mark Mielke <mark@mark.mielke.cc>,
       Giuliano Pochini <pochini@denise.shiny.it>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010032950.GA11683@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Mark Mielke <mark@mark.mielke.cc>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	linux-kernel@vger.kernel.org
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it> <20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it> <20021009222438.GD5608@mark.mielke.cc> <20021009232002.GC2654@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009232002.GC2654@bjl1.asuk.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 10, 2002 at 12:20:02AM +0100, Jamie Lokier wrote:
> Mark Mielke wrote:
> >     2) Pages should not be candidates for dropping if the pages belong
> >        to the first few pages of a file. (First = 2? 4? 8?) The theory
> >        being, that somebody could begin reading the file again from the
> >        beginning.
> 
> This breaks the benefit of using O_STREAMING to read a lot of small
> files once, as you might do when grepping the kernel tree for example.

I don't think grep is a very good candidate for O_STREAMING.  I
usually want the stuff I grep to stay in cache.  O_STREAMING is
much better suited to applications like ogle, vlc, xine, xmovie,
xmms etc since there is little reason for the OS to cache things
like songs and movies you aren't likely to hear/see again any
time soon.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
