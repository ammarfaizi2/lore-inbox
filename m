Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313358AbSDGRaF>; Sun, 7 Apr 2002 13:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313366AbSDGRaE>; Sun, 7 Apr 2002 13:30:04 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:23454 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S313358AbSDGRaD>;
	Sun, 7 Apr 2002 13:30:03 -0400
Date: Sun, 7 Apr 2002 18:27:40 +0100
Message-Id: <200204071727.g37HRet17641@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
In-Reply-To: <E16uGg1-0006Ln-00@the-village.bc.nu>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16uGg1-0006Ln-00@the-village.bc.nu> you wrote:
> This wants fixing in 2.5 too - basically
> 
> static int (*afs_syscall)(...);
> sys_afs_syscall(...)
> {
>        if(afs_syscall)
>                return afs_syscall(....)
>        return -ENOSYS;
> }

I think it wants addin a lock around it vs module unload....
