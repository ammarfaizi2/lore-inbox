Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262352AbSJEOaj>; Sat, 5 Oct 2002 10:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262353AbSJEOaj>; Sat, 5 Oct 2002 10:30:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7525 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262352AbSJEOai>; Sat, 5 Oct 2002 10:30:38 -0400
Date: Sat, 5 Oct 2002 16:36:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
Message-ID: <20021005143627.GA32733@dualathlon.random>
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.suse.lists.linux.kernel> <p73adltqz9g.fsf@oldwotan.suse.de> <1033824043.3425.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033824043.3425.0.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 02:20:43PM +0100, Alan Cox wrote:
> On Sat, 2002-10-05 at 05:35, Andi Kleen wrote:
> >  		 */
> > diff -urN linux-2.4.18.tmp/include/asm-alpha/ioctls.h linux-2.4.18.SuSE/include/asm-alpha/ioctls.h
> > --- linux-2.4.18.tmp/include/asm-alpha/ioctls.h	Sat May  4 11:37:28 2002
> > +++ linux-2.4.18.SuSE/include/asm-alpha/ioctls.h	Sat May  4 11:37:56 2002
> > @@ -92,6 +92,7 @@
> >  #define TIOCGSID	0x5429  /* Return the session ID of FD */
> >  #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> >  #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
> > +#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
> >  
> 
> Shouldn't these values be reserved in 2.5 before anything goes into 2.4
> for this - the values finally used might be different

yes it should, just like the MAP_BIGPAGE and several other bits in the
rhas (O_ATOMICLOOKUP etc...):

+#define MAP_BIGPAGE	0x40		/* bigpage mapping */

I attempted doing a sync with mainline for all these potential future
binary-incompatibilities several months ago but it went to /dev/null and
nobody cared to merge these bits into mainline, hopefully this thread
will bring more attention to these kind of patches now.

Andrea
