Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314449AbSECMKM>; Fri, 3 May 2002 08:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314689AbSECMKL>; Fri, 3 May 2002 08:10:11 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:63760 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S314449AbSECMKK>; Fri, 3 May 2002 08:10:10 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Date: 3 May 2002 12:05:01 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnad4v7c.i01.kraxel@bytesex.org>
In-Reply-To: <11028.1020422524@ocs3.intra.ocs.com.au>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1020427501 18518 127.0.0.1 (3 May 2002 12:05:01 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
>  On 3 May 2002 10:06:04 GMT, 
>  Gerd Knorr <kraxel@bytesex.org> wrote:
> >>  Do it with NO_MAKEFILE_GEN=1 for much, much! faster builds.
> >
> >What exactly is the reason for this hack, i.e. why kbuild wants to
> >rebuild the Makefiles every time?  Isn't it enougth to do that only
> >if .config has been touched?
>  
>  Or any of the Makefile.in files have changed.

.config + all Makefile.in's is still a small number of files where
make has to check the timestamp to see whenever a rebuild of the global
makefile is needed.

>  Or any of the command line options have changed.

Which command line options?

>  Or various environment variables have changed.
>  Or the compiler has changed.

Which environment variables?  CC / CFLAGS?  Well, with other CFLAGS
and/or compiler you have to do a full rebuild anyway, thus using "make
clean" would work equally well ...

>  Or a target file has been altered outside kbuild control.

Which is the users fault IMO.  I don't see the point in trying to catch
this and make kbuild idiot proof.  I doubt it is possible to make kbuild
clever enougth to handle all evil things a user could do.  AI isn't that
good.

>  Coding a special case to work out if the existing global makefile can
>  be reused is horribly error prone.

Special case?  I'd say it is the common case when doing kernel
development.  At least I don't use another compiler for every second
make.  I usually hack some piece of code and recompile the module then.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
