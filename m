Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317384AbSGITsT>; Tue, 9 Jul 2002 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSGITsS>; Tue, 9 Jul 2002 15:48:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15749 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317390AbSGITr0>; Tue, 9 Jul 2002 15:47:26 -0400
Date: Tue, 9 Jul 2002 15:50:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
In-Reply-To: <E17S18w-0005a7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1020709154108.14801B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002, Alan Cox wrote:

> > That is what it's supposed to do with files. The attached code clearly
> > shows that it doesn't work with directories. The fsync() instantly
> > returns, even though there is buffered data still to be written.
> 
> Your understanding or code is wrong. Its hard to tell which.
> 
> fsync on the directory syncs the directory metadata not the file metadata
> 

Well the original complaint was that Linux NFS didn't allow a directory to
be fsync()ed. I showed that POSIX.4 doesn't provide for fsync()ing
directories, only files, that you have to fsync() individual files, not
the directories that contain them. Others said that fsync()ing individual
files was not necessary, that you only have to fsync() the directory. I
explained that you have to cheat to even get a fd that can be used
to fsync() a directory. Then I showed that fsync()ing a directory in this
manner doesn't work so, we are actually in violent agreement.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

