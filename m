Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSEGH27>; Tue, 7 May 2002 03:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315380AbSEGH25>; Tue, 7 May 2002 03:28:57 -0400
Received: from pat.uio.no ([129.240.130.16]:7907 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315379AbSEGH24>;
	Tue, 7 May 2002 03:28:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: Dan Yocum <yocum@fnal.gov>
Subject: Re: Poor NFS client performance on 2.4.18?
Date: Tue, 7 May 2002 09:28:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CC86BDC.C8784EA2@fnal.gov> <shsu1pyppnz.fsf@charged.uio.no> <3CD6FE1E.A20384D@fnal.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174zP0-0007N9-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 7. May 2002 00:05, Dan Yocum wrote:
> Trond,
>
> OK, so backing out the rpc_tweaks dif fixed the performance problem,
> however, seems to have introduced another problem that appears to be
> stemming from the seekdir.dif.  Attempting to run an app from an IRIX
> client (that has the 32bitclients option set) freezes the NFS volume - one
> can't access it from the Linux side, anymore.
>
> You can read and write to the NFS volume *before* trying to run something
> from there, but not after.
>
> Ideas?

That smells like another network driver bug. Have you tcpdumped the traffic 
between client and server?

Cheers,
  Trond
