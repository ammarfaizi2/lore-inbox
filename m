Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVJOFG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVJOFG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 01:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVJOFG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 01:06:29 -0400
Received: from gate.gau.hu ([192.188.242.65]:4232 "EHLO gate.gau.hu")
	by vger.kernel.org with ESMTP id S1751080AbVJOFG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 01:06:28 -0400
Date: Sat, 15 Oct 2005 07:06:26 +0200 (CEST)
From: Lajber Zoltan <lajbi@lajli.gau.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrew Walrond <andrew@walrond.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
In-Reply-To: <43508485.5040800@tmr.com>
Message-ID: <Pine.LNX.4.58.0510150648280.28439@lajli.gau.hu>
References: <200510071111.46788.andrew@walrond.org> <43508485.5040800@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2005, Bill Davidsen wrote:

> As others have noted, SATA is young and should not be used for hot-swap,
> at least in a production manner. I suggest the IBM ServeRAID controller
> as one solution for SCSI. I have a bunch of servers in various places
> around the country, and these have been good to me, work pretty well
> with typical failures, and IBM supports them.

We have about 7 serverraid card from 4L to 5i. All of them is sitting on
shelf. They are pain to manage, ipssend tool is weak, serverdirector
complicated. And they are slow, the Fusion MPT SCSI with sw raid
significant faster, as we measured with bonnie++. Even the old aic7892 is
faster (these built-in scsi controllers on xseries motherboards).

For example: an xseries 345, serverraid 5i, raid5 from 10k rpm U160 disk
read/write 30/12 MB/s. Same machine, same disk, with linux 2.6.x sw raid1
perform 40/26 MB/s. (this machine with QLA2340 FC HBA, emc cx700 storage:
116/67 MB/s).

For raid5, an other x345 with Fusion MPT, 10k rpm U320 discs, 2.6.x sw
raid 5 from 4 disk perform 110/75 MB/s, and this machine put out 127/85
on qla2340 FC HBA, emc cx700, raid5 from 8 10k rpm FC disks.

Beside this, the scsi hotswap works well in xSeries.

Bye,
-=Lajbi=----------------------------------------------------------------
 LAJBER Zoltan               Szent Istvan Egyetem,  Informatika Hivatal
 Most of the time, if you think you are in trouble, crank that throttle!
