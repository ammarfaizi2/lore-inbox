Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbTAFBuo>; Sun, 5 Jan 2003 20:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTAFBuo>; Sun, 5 Jan 2003 20:50:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:63646 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265657AbTAFBun>;
	Sun, 5 Jan 2003 20:50:43 -0500
Message-ID: <3E18E2F0.1F6A47D0@digeo.com>
Date: Sun, 05 Jan 2003 17:59:12 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>, Jan Kara <jack@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 - quota support
References: <20030106003801.GA522@mail.muni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2003 01:59:12.0519 (UTC) FILETIME=[3577C970:01C2B527]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> 
> Hello,
> 
> Is quota support currently broken?
> 
> Under 2.5.54 I got:
> # quotaon /
> using //aquota.user on /dev/hda1: No such device
> 
> /dev/hda1 is ext3 and aquota.user exists on it.
> 
> My config is:
> CONFIG_QUOTA=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> 

It works for me.

grab-n-build quota-3.08 from http://sourceforge.net/projects/linuxquota
# mke2fs -j /dev/sde5
# mount /dev/sde5 /mnt/sde5 -o quota
# quotacheck -F vfsv0 /dev/sde5
# quotaon /dev/sde5
# cd /mnt/sde5
# tar xfz ~/linux-2.4.19.tar.gz
# repquota /mnt/sde5

*** Report for user quotas on device /dev/sde5
Block grace time: 7days; Inode grace time: 7days
                        Block limits                File limits
User            used    soft    hard  grace    used  soft  hard  grace
----------------------------------------------------------------------
root      --   32828       0       0              3     0     0       
akpm      --  162104       0       0          11370     0     0
