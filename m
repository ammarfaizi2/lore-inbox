Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130958AbRCFGVw>; Tue, 6 Mar 2001 01:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130962AbRCFGVd>; Tue, 6 Mar 2001 01:21:33 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:43791 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S130958AbRCFGV1>;
	Tue, 6 Mar 2001 01:21:27 -0500
Message-ID: <3AA4888F.77E3B422@candelatech.com>
Date: Mon, 05 Mar 2001 23:49:51 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Frédéric L. W. Meunier" <0@pervalidus.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened ? (No 
 such file or directory))
In-Reply-To: <20010305022117.C103@pervalidus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth, I was able to completely screw up my root FS
using redhat's Fisher beta kernel (2.2.18 + stuff).  I did this by
running a bad hdparm command while running a full GNOME desktop:
(This was not a good idea...and I know, and knew that...but....)

hdparm -X34 -d1 -u1 /dev/hda
(As found here: http://www.oreillynet.com/pub/a/linux/2000/06/29/hdparm.html?page=2


HD is a 40GB 7200 RPM Western Digital drive. (ATA-100 I believe)
that I just got from Fry's a few days ago...

fdisk was sort of able to recover most of the file system by
booting off of the CD in rescue mode and running fsck on /dev/hda, but
many files were not what they said they were, ie /sbin/ifup was
some other binary...  Some files turned into directories it
seems....

Sorry for the lame bug report, but I'm scared to try it again, and
I didn't realize the complexity of the problem when I simply powered
down my machine with the HD light on solid...

Thanks,
Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
