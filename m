Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313531AbSDKI5o>; Thu, 11 Apr 2002 04:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313553AbSDKI5n>; Thu, 11 Apr 2002 04:57:43 -0400
Received: from eowyn.iae.nl ([212.61.25.227]:20237 "HELO eowyn.vianetworks.nl")
	by vger.kernel.org with SMTP id <S313531AbSDKI5m>;
	Thu, 11 Apr 2002 04:57:42 -0400
Date: Thu, 11 Apr 2002 11:35:02 +0200
Message-Id: <200204110935.LAA03761@fikkie.vesc.nl>
From: "E. Abbink" <esger@bumblebeast.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Reply-To: esger@bumblebeast.com
Subject: Re: Problem using mandatory locks (other apps can read/delete etc)
X-Mailer: NeoMail 1.25
X-IPAddress: 192.0.0.12
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On 10 April 2002 15:08, E. Abbink wrote:
> > I'm trying to solve a problem using mandatory locks but am having some
> > difficulty in doing so. (if there's a more appropriate place for
> > discussing this please ignore the rest of this post. pointers to that
> > place would be appreciated ;) )
> >
> > my problem:
> >
> > when I lock a file with a mandatory write lock (ie. fcntl, +s-x bits and
> > mand mount option. for code see below) it is still possible:
> >
> > - for me to rm the file in question
> > - for the file to be read by an other process
> 
> [snip]
> 
> >     lock.l_type = F_WRLCK ;   <================
> >     lock.l_whence = SEEK_SET ;
> >     lock.l_start = 0 ;
> >     lock.l_len = 0 ;
> >     lock.l_pid = 0 ; // ignored
> >
> >     int err = fcntl (fd, F_SETLK, &lock) ;
> 
> I know nothing about file locking in Unix, but it looks like you
> requested write lock, i.e. forbid writing to a file. Why are you
> surprised that reads are allowed?
> 
> Probably someone else would comment on why rm is working, though...
> --
> vda

as i understand it what is called a "write" lock is actually an
exclusive lock (ie both read/write). Also, afaik, you cant set both a
read & write lock through fcntl which supports that assumption.
 
Esger

-- 
NeoMail - Webmail that doesn't suck... as much.
http://neomail.sourceforge.net
