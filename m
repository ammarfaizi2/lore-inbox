Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSKLQON>; Tue, 12 Nov 2002 11:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266092AbSKLQON>; Tue, 12 Nov 2002 11:14:13 -0500
Received: from netrealtor.ca ([216.209.85.42]:28172 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261839AbSKLQOM>;
	Tue, 12 Nov 2002 11:14:12 -0500
Date: Tue, 12 Nov 2002 11:26:27 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Kent Borg <kentborg@borg.org>
Cc: Adam Voigt <adam@cryptocomm.com>, linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
Message-ID: <20021112162627.GB6811@mark.mielke.cc>
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com> <20021112110149.A9492@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112110149.A9492@borg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 11:01:49AM -0500, Kent Borg wrote:
> On Tue, Nov 12, 2002 at 10:38:55AM -0500, Adam Voigt wrote:
> > I have a directory with 39,000 files in it, and I'm trying to use the cp
> > command to copy them into another directory, 
> > [...]
> > "argument list too long"
> No, it is not a kernel limit, it is a limit to your shell (bash, for
> example).  Look at xargs to get around it.

>From "man execve":

       E2BIG  The argument list is too big.

>From "man sysconf":

       _SC_ARG_MAX
              The  maximum  length of the arguments to the exec()
              family of functions;  the  corresponding  macro  is
              ARG_MAX.

On my RedHat 8.0 box:

       $ getconf ARG_MAX
       131072

It is definately a kernel limitation, although as other people have
pointed out, there are common userspace solutions to the problem.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

