Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKIHdq>; Thu, 9 Nov 2000 02:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbQKIHdg>; Thu, 9 Nov 2000 02:33:36 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:32859 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S129231AbQKIHdX>;
	Thu, 9 Nov 2000 02:33:23 -0500
Date: Thu, 9 Nov 2000 08:33:21 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Scott McDermott <vaxerdec@frontiernet.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Stange NFS messages - 2.2.18pre19
In-Reply-To: <20001108211538.C14262@vaxerdec>
Message-ID: <Pine.LNX.4.10.10011090832480.14350-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, Scott McDermott wrote:

> Sasi Peter on Tue  7/11 23:28 +0100:
> > I'm getting this under moderate NFS load:
> > Nov  6 17:39:56 iq kernel: svc: server socket destroy delayed (sk_inuse: 1)
> > Nov  6 17:40:08 iq kernel: svc: unknown program 100227 (me 100003)
> > Nov  6 19:06:11 iq kernel: svc: server socket destroy delayed (sk_inuse: 1)
> > Nov  6 19:38:48 iq kernel: svc: server socket destroy delayed (sk_inuse: 1)
> > What do these means? Is this a kernel bug?
> Your Suns are using TCP mounts, this got introduced into 2.2.18
> somewhere and is a bit broken, do a patch -R with
> ftp://oss.sgi.com/www.projects/nfs3/download/nfs_tcp-2.2.17.dif and
> these go away.  Suns try TCP mounts first.  Be careful to unmount them
> first or they will hang waiting for the TCP server to come back up.

Broken link:
[root@iq patches]# wget
ftp://oss.sgi.com/www.projects/nfs3/download/nfs_tcp-2.2.17.dif
--08:31:28--
ftp://oss.sgi.com:21/www.projects/nfs3/download/nfs_tcp-2.2.17.dif
           => `nfs_tcp-2.2.17.dif'
Connecting to oss.sgi.com:21... connected!
Logging in as anonymous ... Logged in!
==> TYPE I ... done.  ==> CWD www.projects/nfs3/download ...
No such directory `www.projects/nfs3/download'.

--  SaPE

Peter, Sasi <sape@sch.hu>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
