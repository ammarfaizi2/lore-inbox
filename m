Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSGPPvG>; Tue, 16 Jul 2002 11:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317868AbSGPPvF>; Tue, 16 Jul 2002 11:51:05 -0400
Received: from p508875D5.dip.t-dialin.net ([80.136.117.213]:25745 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317865AbSGPPvE>; Tue, 16 Jul 2002 11:51:04 -0400
Date: Tue, 16 Jul 2002 09:53:48 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <20020716123122.GE4576@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44.0207160953110.3452-100000@hawkeye.luckynet.adm>
X-Location: Calgary; CA
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Jul 2002, Matthias Andree wrote:
> > Write a binary (/usr/bin/fsync) which opens a fd, fsync it, close it, be 
> > done with it.
> 
> Or steal one from FreeBSD (written by Paul Saab), fix the err() function
> and be done with it.
> 
> .../usr.bin/fsync/fsync.{1,c}
> 
> Interesting side note -- mind the O_RDONLY:
> 
>         for (i = 1; i < argc; ++i) {
>                 if ((fd = open(argv[i], O_RDONLY)) < 0)
>                         err(1, "open %s", argv[i]);
> 
>                 if (fsync(fd) != 0)
>                         err(1, "fsync %s", argv[1]);
>                 close(fd);
>         }

Pretty much the thing I had in mind, except that the close return code is 
disregarded here...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

