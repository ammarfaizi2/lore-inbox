Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130686AbRCPRvj>; Fri, 16 Mar 2001 12:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130722AbRCPRv3>; Fri, 16 Mar 2001 12:51:29 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:4361 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S130686AbRCPRvM>; Fri, 16 Mar 2001 12:51:12 -0500
Date: Fri, 16 Mar 2001 18:49:03 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: Alexander Viro <viro@math.psu.edu>
cc: <Wayne.Brown@altec.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
In-Reply-To: <Pine.GSO.4.21.0103161030330.12618-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0103161847470.517-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Alexander Viro wrote:
> On Fri, 16 Mar 2001 Wayne.Brown@altec.com wrote:
>
> >   The release notes specify this:
> >
> >      mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
> >
> > but this doesn't work because
> >
> >      mount: mount point /proc/sys/fs/binfmt_misc does not exist
>
> Grr... OK, I've been an overoptimistic idiot and missed that ugliness.
>
> Solutions:
> 	a) mount it on some real place. And write there to register
> entries instead of the bogus /proc/sys/fs/binfmt_misc
> 	b) add a couple of proc_mkdir() into fs/proc/root.c
c) stick with the previous binfmt_misc in 2.4 and leave the
   filesystem with 2.5

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

