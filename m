Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSH0EkK>; Tue, 27 Aug 2002 00:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSH0EkK>; Tue, 27 Aug 2002 00:40:10 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:27607 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S313305AbSH0EkJ>;
	Tue, 27 Aug 2002 00:40:09 -0400
Date: Tue, 27 Aug 2002 14:44:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: bulb@vagabond.cybernet.cz
Cc: bulb@cimice.maxinet.cz, linux-kernel@vger.kernel.org
Subject: Re: Question about leases
Message-Id: <20020827144421.5ebec0e4.sfr@canb.auug.org.au>
In-Reply-To: <20020827143517.40ba04f7.sfr@canb.auug.org.au>
References: <20020827010616.GB16207@vagabond>
	<20020827143517.40ba04f7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Tue, 27 Aug 2002 14:35:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Tue, 27 Aug 2002 03:06:16 +0200 Jan Hudec <bulb@cimice.maxinet.cz> wrote:
> >
> > Please can anyone throw a bit light on file leases (fcntl F_SETLEASE
> > command) or at least point me to some documentation? I can't find any.
> 
> There isn't any (except maybe the talk I gave at Linux Kongress
> last year (http://www.canb.auug.org.au/~sfr/idle.html).
> 
> > As far as I figured out process holding a lease is notified when other
> > process opens the leased file. But I am still not sure how the leases
> > should then be released and how the process knows which lease was broken
> > (struct siginfo does not seem to have union member for that case).
> 
> To release a lease, you use fcntl(fd, F_SETLEASE,  F_UNLCK).  The file
> descriptor of the file that the lease is on is returned in the
> siginfo structure.

You should also be aware that there are lots of bugs with file leases
before 2.4.20-pre3 and in early 2.5 kernels.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
