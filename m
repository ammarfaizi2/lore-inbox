Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTLPPej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 10:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTLPPei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 10:34:38 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:30610 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S261784AbTLPPeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 10:34:37 -0500
Message-ID: <3FDF2632.C83B80D7@bull.net>
Date: Tue, 16 Dec 2003 16:35:14 +0100
From: Jacky Malcles <Jacky.Malcles@bull.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr-FR,fr
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Bobby Hitt <Robert.Hitt@bscnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need Quota Support for Reiserfs Partition
References: <01a901c3c2a7$f5d8a9d0$0900a8c0@BOBHITT> <20031215085312.GD6613@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan,

do you know if quotas are working with ext3 FS ?
I'm using kernel 2.6.0test9 and quota-3.09-1
and I  can't turn them on,
quotaon command returns:
quotaon: using /users/aquota.user on /dev/sdc2 [/users]: No such process
quotaon: Quota format not supported in kernel.
...
many thanks,

Jan Kara wrote:
> 
>   Hi,
> 
> > I'm using Slackware Linux with kernel version 2.6.0-test11. All of my
> > partitions are Rieserfs. I now have a need to use quotas on a partition, but
> > according to the help screen using "make menuconfig" quotas are only
> > available under the ext2 file systems. Is there a patch to allow quotas
> > under rieserfs? One of my searches said that Reiserfs and quotas were
> > supported under 2.6.0, but when I try and mount the partition with this line
> > in /etc/fstab:
> >
> > /dev/hde2 /downloads reiserfs defaults,usrquota,grpquota 1 2
> >
> > I get this error:
> >
> > mount: wrong fs type, bad option, bad superblock on /dev/hde2,
> >        or too many mounted file systems
> >
> >
> > If I take the usrquota,grpquota off, the mount works fine.
>   AFAIK ReiserFS doesn't support quotas in 2.6 kernel. Chris Mason
> <mason@suse.com> maintains needed patches for 2.4 and is working on
> porting them to 2.6 but they are not yet ported.
> 
>                                                                         Honza
> 
> --
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
 Jacky Malcles    	     B1-173   Email : Jacky.Malcles@bull.net
 Tel : 04.76.29.73.14
