Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282050AbRKZTfM>; Mon, 26 Nov 2001 14:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282427AbRKZTcW>; Mon, 26 Nov 2001 14:32:22 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:50450 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S282381AbRKZTaS>;
	Mon, 26 Nov 2001 14:30:18 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111261929.UAA31258@nbd.it.uc3m.es>
Subject: Re: Possible md bug in 2.4.16-pre1
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <000c01c1769c$187cc390$9865fea9@pcsn630778> "from Alok K. Dhir at
 Nov 26, 2001 12:02:13 pm"
To: "Alok K. Dhir" <alok@dhir.net>
Date: Mon, 26 Nov 2001 20:29:57 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alok K. Dhir wrote:"
> On kernel 2.4.16-pre1 software RAID (tested with levels 0 and 1 on the
> same two drives), it is not possible to "raidstop /dev/md0" after
> mounting and using it, even though the partition is unmounted.  Attempts

Raid has been in quite a shocking state for a long while and
often there seems nor rhyme nor reason to its behaviour. If you want
to stick your machine in an endless loop, just try initialising a
mirror raid device with only one of its two components currently
working. 

> are rejected with "/dev/md0: Device or resource busy".  Even shutting

ya, ya. Try raidhotsetfaulty for good luck and then try raidhotremove.
(curse, splutter. Will the authors ever write some docs that make
sense. And also document the interactions with lvm).

> down to single user mode does not release the device for stopping.  I
> had to reboot to single user mode, then I was able to stop it,

You just said you couldn't?

> unconfigure it, etc.
> 
> Testing the throughput of Linux's software raid in levels raid1 and
> raid0 with various chunksizes was somewhat more tedious because of this

You ain't kidding. It's a nightmare to test upon.

> Here is my (current) raidtab:
> 
> Raiddev			/dev/md0
> raid-level			0
> nr-raid-disks		2
> chunk-size			64k
> persistent-superblock	1
> nr-spare-disks		0
> device			/dev/sda2
> raid-disk			0
> device			/dev/sdb1
> raid-disk			1

That's a standard setup. It's not even confusing to me! Try it over lvm
logical partitions and other raid devices (snicker).

Peter
