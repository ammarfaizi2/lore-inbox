Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313217AbSDKIjA>; Thu, 11 Apr 2002 04:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313268AbSDKIi7>; Thu, 11 Apr 2002 04:38:59 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:36363 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313217AbSDKIi7>; Thu, 11 Apr 2002 04:38:59 -0400
Message-ID: <3CB54B48.C51A3494@aitel.hist.no>
Date: Thu, 11 Apr 2002 10:37:28 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org,
        neilb@cse.unsw.edu.au, rgooch@ras.ucalgary.ca
Subject: Re: RAID superblock confusion
In-Reply-To: <200204101533.g3AFXwS09100@vindaloo.ras.ucalgary.ca> <20020410184010.GC3509@turbolinux.com> <200204101924.g3AJOp113305@vindaloo.ras.ucalgary.ca> <20020410193812.GE3509@turbolinux.com> <200204102037.g3AKbmT14222@vindaloo.ras.ucalgary.ca> <15540.59659.114876.390224@notabene.cse.unsw.edu.au> <20020411024111.GL23513@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
[...] 
> Ahh, but if you use initrd you can even have the ide and scsi drivers as
> modules.
> 
> What is needed is to make the disk modules depend on the raid modules (only
> if the raid code is enabled of course) so that modprobe can load the raid
> modules first.
> 
> Then you'd just need to make sure that if there are any block modules linked
> into the kernel that raid is also linked into the kernle instead of a module.
> 
> Is there some reason why this wouldn't work (except for CML1
> complications...)?

Having block devices depend on raid modules isn't the solution.
A user may have many block devices with raid on only a few
of them.

I think this sort of setup-specific dependencies belong in userspace,
i.e. /etc/conf.modules:

pre-install <block-driver-with-raid-partitions> insmod
<raid-modules-needed>


Helge Hafting
