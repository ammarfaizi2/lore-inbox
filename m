Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282201AbRKWSuw>; Fri, 23 Nov 2001 13:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282206AbRKWSum>; Fri, 23 Nov 2001 13:50:42 -0500
Received: from ids.big.univali.br ([200.169.51.11]:1920 "HELO
	mail.big.univali.br") by vger.kernel.org with SMTP
	id <S282201AbRKWSu3>; Fri, 23 Nov 2001 13:50:29 -0500
Date: Fri, 23 Nov 2001 16:50:25 -0200 (BRST)
From: Marcus Grando <marcus@big.univali.br>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Hartmut Holz <hartmut.holz@arcormail.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Input/output error
In-Reply-To: <20011123112947.W1308@lynx.no>
Message-ID: <Pine.LNX.4.33.0111231641030.1106-100000@ids.big.univali.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

	I have this problem too, i execute fsck more 20 times and not 
resolv this problem.

	Execute badblocks(8) and not found bad blocks

	I note before linux-2.4.15-pre8 begin this problems.

	Changelog-pre8:
	 - Andrew Morton: fix ext3/minix/sysv fsync behaviour.

	Maybe? I don´t no.

Regards,

Marcus Grando


On Fri, 23 Nov 2001, Andreas Dilger wrote:

> On Nov 23, 2001  16:43 +0100, Hartmut Holz wrote:
> > On my machine (2.4.15 final) it is the same behaviour.  After reboot
> > the lock files (and only the lock files) are corrupt. With 2.4.14 and 
> > 2.4.13 everything works fine. gcc 2.96, e2fsck 1.25, aic7896/97
> > 
> > e2fsck output:
> > --------------
> > Pass 1: Checking inodes, blocks, and sizes
> > Pass 2: Checking directory structure
> > Entry 'kudzu' in /lock/subsys (30001) has deleted/unused inode 30005. 
> > Entry 'network' in /lock/subsys (30001) has deleted/unused inode 30006. 
> > Entry 'syslog' in /lock/subsys (30001) has deleted/unused inode 30007. 
> > Entry 'portmap' in /lock/subsys (30001) has deleted/unused inode 30008. 
> > Entry 'nfslock' in /lock/subsys (30001) has deleted/unused inode 30009. 
> > Entry 'syslogd.pid' in /run (38001) has deleted/unused inode 38009. 
> > Entry 'klogd.pid' in /run (38001) has deleted/unused inode 38010. 
> 
> I take it that this is after a normal shutdown where you are sure that
> the filesystem was unmounted cleanly?  It looks like a case where these
> files are deleted, but held open by a process.
> 
> Could you please try the following:
> - "telinit 1" to change into single user mode
> - make sure all of the above processes are stopped (check via ps, and
>   "/etc/rc.d/init.d/foo stop" for each one
> - "lsof | grep /var" to see if any files are still open on /var
> - umount /var
> - e2fsck -f /dev/hdX
> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Marcus Grando
Administrador de Rede
UNIVALI

