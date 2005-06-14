Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVFNUR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVFNUR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVFNURz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:17:55 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:62826 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261324AbVFNURu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:17:50 -0400
Date: Tue, 14 Jun 2005 23:17:22 +0300 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@dhcppc0
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
cc: erik@harddisk-recovery.com, reiser@namesys.com, adilger@clusterfs.com,
       fs@ercist.iscas.ac.cn, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, matsui_v@valinux.co.jp,
       kikuchi_v@valinux.co.jp, fernando@intellilink.co.jp,
       kskmori@intellilink.co.jp, takenakak@intellilink.co.jp,
       yamaguchi@intellilink.co.jp, ext2-devel@lists.sourceforge.net,
       shaggy@austin.ibm.com, xfs-masters@oss.sgi.com,
       Reiserfs-Dev@namesys.com
Subject: Re: [RFD] FS behavior (I/O failure) in kernel summit
In-Reply-To: <20050615.021626.42934687.okuyamak@dd.iij4u.or.jp>
Message-ID: <Pine.LNX.4.61.0506142230460.8028@dhcppc0>
References: <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com>
 <20050614125130.GA30812@harddisk-recovery.com> <20050615.021626.42934687.okuyamak@dd.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Jun 2005, Kenichi Okuyama wrote:
>>>>>> "Eric" == Erik Mouw <erik@harddisk-recovery.com> writes:
> Eric> I'd rather have a filesystem which I can tell to warn me immediately
> Eric> about a problem and not make things worse by trying to continue.
> Eric> A mount option for Reiserfs like Andreas proposed would be a good idea.
>
> I 100% agree with you about how file system should act.

There are permanent and transient errors.

Removing a device is ENODEV and I think this is not closely related to any 
filesystem. Only Windows seems to detect this properly (the error messages 
are perhaps mistranslated by cygwin?)

If the device hits bad sectors then NTFS adds them to the $BadClust list 
on-the-fly and won't try to use them anymore, users don't notice anything 
unless asked. _Some_ bad sectors don't mean the disk is dying: not all 
disks have reserved zone, remapping or it's too small, etc. Many people
use NTFS having defected sectors without issues and no new ones develop
in time.

Thanks for your work. I think it's is important.

Cheers,
 	Szaka
