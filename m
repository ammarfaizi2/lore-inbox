Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132708AbRAJAd4>; Tue, 9 Jan 2001 19:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132446AbRAJAdr>; Tue, 9 Jan 2001 19:33:47 -0500
Received: from chiara.elte.hu ([157.181.150.200]:45324 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132706AbRAJAdc>;
	Tue, 9 Jan 2001 19:33:32 -0500
Date: Wed, 10 Jan 2001 01:33:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Hubert Mantel <mantel@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Change of policy for future 2.2 driver submissions
In-Reply-To: <20010109154908.F20539@suse.de>
Message-ID: <Pine.LNX.4.30.0101100128420.11738-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Hubert Mantel wrote:

> Right, but now there is a problem: Software RAID. The RAID code of
> 2.4.0 is not backwards compatible to the one in 2.2.18; if somebody
> has used 2.4.0 on softraid and discovers some problem, he can not
> switch back to some official 2.2 kernel. [...]

that is simply not true - at least for the RAID0 and LINEAR mdtools
arrays. You can start up 'new' RAID devices via mdtools just fine, even if
these new devices have RAID-superblocks. (because those superblocks are at
the end of the device, and ext2fs knows the true size of the filesystem.)

you have to keep two sets of configuration files (/etc/raidtab and
/etc/mdtab), but that is not new nor unreasonable. The tools do not clash
either.

[ the only category impacted are people who are still using the
RAID1/RAID4,5 code in the stock 2.2 kernel - i do believe the number of
these people is very low, and they should imminently upgrade to the 0.90
driver anyway, for stability and data integrity reasons. ]

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
