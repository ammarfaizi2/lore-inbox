Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUF3Eo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUF3Eo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 00:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUF3Eo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 00:44:26 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:10914 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S266463AbUF3Enx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 00:43:53 -0400
Mail-Followup-To: SSlota@gmx.net,
  linux-kernel@vger.kernel.org
MBOX-Line: From george@galis.org  Wed Jun 30 00:43:52 2004
Date: Wed, 30 Jun 2004 00:43:52 -0400
From: George Georgalis <george@galis.org>
To: Sebastian Slota <SSlota@gmx.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
Message-ID: <20040630044352.GB8841@trot.local>
References: <20040625213433.GB6502@trot.local> <29181.1088498805@www29.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29181.1088498805@www29.gmx.net>
X-Time: trot.local; @238; Wed, 30 Jun 2004 00:43:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 10:46:45AM +0200, Sebastian Slota wrote:
>Tried Kernel with bk8:
> 
>root@t-rex root # cat /proc/mdstat
>Personalities : [raid0] [raid5] [multipath]
>md1 : active raid5 sdc3[2] sdb3[1] sda3[0]
>261730816 blocks level 5, 128k chunk, algorithm 2 [3/3] [UUU]
>
>md0 : active raid0 sdc2[2] sdb2[1] sda2[0]
>73256064 blocks 128k chunks
>
>unused devices: <none>
>
>root@t-rex root # hdparm -tT /dev/md0
>
>/dev/md0:
>Timing buffer-cache reads: 3896 MB in 2.01 seconds = 1935.71 MB/sec
>Timing buffered disk reads: 274 MB in 3.02 seconds = 90.68 MB/sec
>root@t-rex root # hdparm -tT /dev/md1
>
>/dev/md1:
>Timing buffer-cache reads: 3760 MB in 2.00 seconds = 1879.35 MB/sec
>Timing buffered disk reads: 206 MB in 3.01 seconds = 68.49 MB/secc 
>
>Copy a DVD to HD, both went OK!
>copy data from an ATA HD ( hda ) broke.
>
>I read from ppl they're running linux on some older hardware, maybe thats
>why it doesnt work... but ~25mb/s is nothing for me...
>Also I hear about some patches to limit the speed to ~30MB/s.


I was able to dd ~140 GB with SATA_SIL today, on a stock bk kernel, till
I ran out of disk, no errors. which was a pleasant unexpected surprise.

but when I checked "Timing buffered disk reads" it was around 25 MB/sec
not the ~52 MB/sec I saw before with the oops. The odd thing was this
disk was not in the blacklist so I don't know why it was running slower.

// George


-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

