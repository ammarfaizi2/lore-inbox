Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273608AbRIQNPt>; Mon, 17 Sep 2001 09:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273609AbRIQNPj>; Mon, 17 Sep 2001 09:15:39 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:30404 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S273608AbRIQNPY>; Mon, 17 Sep 2001 09:15:24 -0400
Date: Mon, 17 Sep 2001 14:15:47 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Jan Kara <jack@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4, 2.4-ac and quotas
In-Reply-To: <20010917145629.A18298@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0109171401490.20292-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm desperately looking for some recent documentation on quotas.
>>
>> We've recently upgraded our two Debian potato fileservers to 2.4 and
>> 2.4-ac (currently they're both running 2.4-ac so I can't check 2.4 atm)
>> and quotas have stopped working.

>  Before you can use new quota you have to convert old quotafiles to new
>ones. You can do this by convertquota(8) utility which is in the package.
>Or you can just run 'quotacheck -F vfsv0 -c <mountpoint>' to create completely
>new quota files with new quota format.

Thanks--over the weekend I appear to have that bit working. I still can't
add quotas to my shiny new ext3 partition though :(

$ touch /export01/aquota.user
$ umount /export01
$ mount /export01 -o usrquota
$ quotaon /export01
quotaon: using /export01/aquota.user on /dev/sda3: Invalid argument

The strace shows:
quotactl(0x10000, 0x8053fe8, 0, 0x8053fc8) = -1 EINVAL (Invalid argument)

Is there a recent HOWTO on this (maybe I've got it wrong)?

Cheers,

Matt

