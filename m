Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTKNXqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 18:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbTKNXqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 18:46:31 -0500
Received: from aneto.able.es ([212.97.163.22]:6619 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261151AbTKNXq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 18:46:29 -0500
Date: Sat, 15 Nov 2003 00:46:27 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Greg Louis <glouis@dynamicro.on.ca>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre8-pac1 and -rc1-pac1 NFSv3 problem
Message-ID: <20031114234627.GA12679@werewolf.able.es>
References: <20031111182647.GA25026@athame.dynamicro.on.ca> <20031111190000.GA25290@athame.dynamicro.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031111190000.GA25290@athame.dynamicro.on.ca> (from glouis@dynamicro.on.ca on Tue, Nov 11, 2003 at 20:00:00 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.11, Greg Louis wrote:
> On 20031111 (Tue) at 1326:47 -0500, Greg Louis wrote:
> > Kernels 2.4.23-pre7-pac1 and 2.4.23-rc1 are ok but -pre8-pac1 and
> > -rc1-pac1 behave as follows: mounting a remote directory via NFS with
> > v3 enabled (client and server) seems to work ok, and running mount with
> > no parameters shows the NFS mount, but any attempt at access fails with
> > a message like
> >   /bin/ls: reading directory /whatever/it/was: Input/output error
> 
> Reverting all changes to fs/nfs/* since 2.4.23-pre7-pac1, and only
> those, corrects the problem.
> 

/metoo

annwn:~> bpsh 0 mount   
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,mode=0620)
none on /dev/shm type tmpfs (rw)
none on /tmp type tmpfs (rw)
192.168.0.1:/lib on /lib type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
192.168.0.1:/bin on /bin type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
192.168.0.1:/sbin on /sbin type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
192.168.0.1:/usr on /usr type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
192.168.0.1:/opt on /opt type nfs (ro,noatime,nfsvers=3,nolock,addr=192.168.0.1)
192.168.0.1:/home on /home type nfs (rw,nfsvers=3,noac,addr=192.168.0.1)
192.168.0.1:/work on /work/shared type nfs (rw,nfsvers=3,noac,addr=192.168.0.1)

annwn:~> bpsh 0 pwd
/home/magallon

annwn:~> bpsh 0 ls
ls: reading directory .: Invalid argument

It works for some time, and then it breaks.
Could you send me the patch you used to revert those changes ?
I will try to make a diff from rc1 to pre7 and reverse.

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-rc1-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
