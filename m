Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313401AbSDGRs4>; Sun, 7 Apr 2002 13:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313407AbSDGRs4>; Sun, 7 Apr 2002 13:48:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47286 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313401AbSDGRsz>;
	Sun, 7 Apr 2002 13:48:55 -0400
Date: Sun, 7 Apr 2002 13:48:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: arjan@fenrus.demon.nl
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
In-Reply-To: <200204071727.g37HRet17641@fenrus.demon.nl>
Message-ID: <Pine.GSO.4.21.0204071348000.4686-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Apr 2002 arjan@fenrus.demon.nl wrote:

> In article <E16uGg1-0006Ln-00@the-village.bc.nu> you wrote:
> > This wants fixing in 2.5 too - basically
> > 
> > static int (*afs_syscall)(...);
> > sys_afs_syscall(...)
> > {
> >        if(afs_syscall)
> >                return afs_syscall(....)
> >        return -ENOSYS;
> > }
> 
> I think it wants addin a lock around it vs module unload....

I suspect that equivalent of sys_nfsservctl() would be a better way,
actually...

