Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289912AbSAWREj>; Wed, 23 Jan 2002 12:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289911AbSAWRE3>; Wed, 23 Jan 2002 12:04:29 -0500
Received: from [24.64.71.161] ([24.64.71.161]:27889 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S289886AbSAWREQ>;
	Wed, 23 Jan 2002 12:04:16 -0500
Date: Wed, 23 Jan 2002 10:03:57 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: gspujar@hss.hns.com
Cc: linux-kernel@vger.kernel.org, achowdhry@hss.hns.com
Subject: Re: file system unmount
Message-ID: <20020123100357.K960@lynx.adilger.int>
Mail-Followup-To: gspujar@hss.hns.com, linux-kernel@vger.kernel.org,
	achowdhry@hss.hns.com
In-Reply-To: <65256B4A.0021662F.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <65256B4A.0021662F.00@sandesh.hss.hns.com>; from gspujar@hss.hns.com on Wed, Jan 23, 2002 at 11:38:35AM +0530
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23, 2002  11:38 +0530, gspujar@hss.hns.com wrote:
> I am using softdog in my application. One of the problems I am facing is,
> when the system comes up after the reboot forced by softdog, file system
> gets corrupted and fsck has to check. Some times fsck fails to force check
> the file system and the system enters in to run level 1, leading to manual
> intervention.
>
> Any idea how to unmount the file system before the system is rebooted by
> softdog, so that system always comes up properly without manual intervention.

That is like asking for advance notice of system failures -> can't be done.

What you really want is a journaled filesystem (e.g. ext3 or resierfs)
which avoids the lengthy/troublesome fsck stage.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

