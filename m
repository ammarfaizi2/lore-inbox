Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135858AbRD3QtB>; Mon, 30 Apr 2001 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136488AbRD3Qsm>; Mon, 30 Apr 2001 12:48:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:19773 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135858AbRD3QrZ>; Mon, 30 Apr 2001 12:47:25 -0400
Date: Mon, 30 Apr 2001 18:46:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, Ralf Nyren <ralf@nyren.net>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
Message-ID: <20010430184633.B19620@athlon.random>
In-Reply-To: <Pine.LNX.4.31.0104291552190.523-100000@HADDOCK.100Mbit.nyren.net> <15084.62398.56283.772414@pizda.ninka.net> <3AED0A7A.7263E27B@uow.edu.au> <15085.3340.784923.77844@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15085.3340.784923.77844@pizda.ninka.net>; from davem@redhat.com on Sun, Apr 29, 2001 at 11:58:20PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 11:58:20PM -0700, David S. Miller wrote:
> 
> Andrew Morton writes:
>  > "David S. Miller" wrote:
>  > > 
>  > > I'm having a devil of a time finding the tcpblast sources on the
>  > > net, can you point me to where I can get them?
>  > 
>  > I seem to have a copy. 
>  > 
>  > http://www.zip.com.au/~akpm/tcpblast-19990504.tar.gz
> 
> Thanks to everyone who pointed me at this and the debian copy :-)
> 
> Anyways, I just tried to reproduce Ralf's problem on two of my
> machines.  One was an SMP sparc64 system, and the other was my
> uniprocessor Athlon.
> 
> What kind of machine are you reproducing this on Ralf?  I'm not

JFYI: I reproduced too on my UP athlon. I run:

	tcpblast -d0 -s 40481 another_host 9000

two times and after the second it locked hard. I didn't had any fork
bomb at the same time but there was an high computing load in the
background.

the nic is:

Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 36)

Andrea
