Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313063AbSDCFqq>; Wed, 3 Apr 2002 00:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313064AbSDCFqg>; Wed, 3 Apr 2002 00:46:36 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:49422 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S313063AbSDCFqV>; Wed, 3 Apr 2002 00:46:21 -0500
Date: Tue, 2 Apr 2002 21:46:20 -0800 (PST)
From: Jauder Ho <jauderho@carumba.com>
X-X-Sender: jauderho@twinlark.arctic.org
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 vs. ext3 recovery after crash
In-Reply-To: <Pine.LNX.3.96.1020402225256.9671A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0204022144310.21070-100000@twinlark.arctic.org>
X-Mailer: UW Pine 4.44 + a bunch of schtuff
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill, you do know that it will do a full fsck every x mounts right?

[root@turtle /lib]# tune2fs -l /dev/hda6 | grep -i mount
Last mounted on:          <not available>
Last mount time:          Sun Mar  3 11:34:50 2002
Mount count:              1
Maximum mount count:      20

--Jauder

On Tue, 2 Apr 2002, Bill Davidsen wrote:

> I have a laptop (Dell Inspiron C600) which, like most Dell laptops,
> crashes every time I log out of X. On some occasions on reboot I get a
> message about replaying the journal, while occasionally I get a full ext2
> style multi-pass 12 minute recovery. I don't see why the ext3 isn't always
> used, I know it's going to crash, I always do a sync and wait ten seconds
> for journal writes, etc, to take place.
>
> I have tried all the usual, Redhat kernels, 2.4.17, 2.4.19, -aa, -ac,
> disable io-apc, disable apic, disable all power management, boot noapic
> (someone swore it wasn't enough to pull it out of the kernel ;-) all
> producing about 20% chance of slow reboot.
>
> Since I would have to spend my own money to replace this device with
> something functional before 2003, is there something I'm missing about why
> it does the slow cleanup? It was Redhat 7.1, updated fsutils and modutils,
> pcmcia packed, etc, to latest of Mar 15 this year, in case that matters.
> All kernels have ext3 compiled in, all work "most of the time."
>
> --
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

