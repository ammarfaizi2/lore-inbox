Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316496AbSE3JB4>; Thu, 30 May 2002 05:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSE3JBz>; Thu, 30 May 2002 05:01:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50948 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316496AbSE3JBz>; Thu, 30 May 2002 05:01:55 -0400
Date: Thu, 30 May 2002 10:01:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Erik Andersen <andersen@codepoet.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - What's up with the kernel build?
Message-ID: <20020530100144.B10611@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205292019090.9971-100000@chaos.physics.uiowa.edu> <3CF5E698.2020806@mandrakesoft.com> <20020530085413.GA29170@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 02:54:13AM -0600, Erik Andersen wrote:
> On Thu May 30, 2002 at 04:45:12AM -0400, Jeff Garzik wrote:
> > A small request to add to the list:
> > 
> > Current 2.4.x kernels build (at least on x86) with
> >     -nostdinc -I /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.0.4/include
> 
> Shockingly, not everyone uses mandrake's gcc 3.0.4...  ;-)
> 
> GCCINCDIR:= ${shell $(CC) -print-search-dirs | sed -ne "s/install: \(.*\)/\1include/gp"}
> CFLAGS+=-nostdinc -I $(GCCINCDIR)

There is a nicer way of achieving the same thing:

CFLAGS	+= -nostdinc -iwithprefix include

`-iwithprefix DIR'
     Add a directory to the second include path.  The directory's name
     is made by concatenating PREFIX and DIR, where PREFIX was
     specified previously with `-iprefix'.  If you have not specified a
     prefix yet, the directory containing the installed passes of the
     compiler is used as the default.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

