Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbRL1Vc6>; Fri, 28 Dec 2001 16:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284506AbRL1Vcr>; Fri, 28 Dec 2001 16:32:47 -0500
Received: from mout1.freenet.de ([194.97.50.132]:29355 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S284612AbRL1Vck>;
	Fri, 28 Dec 2001 16:32:40 -0500
Message-ID: <3C2CE373.3000806@athlon.maya.org>
Date: Fri, 28 Dec 2001 22:26:11 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011225
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C2CD326.100@athlon.maya.org> <3C2CD9EC.1D6C798E@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Andreas Hartmann wrote:
> 
>>Hello all,
>>
>>Again, I did a rsync-operation as described in
>>"[2.4.17rc1] Swapping" MID <3C1F4014.2010705@athlon.maya.org>.
>>
>>This time, the kernel had a swappartition which was about 200MB. As the
>>swap-partition was fully used, the kernel killed all processes of knode.
>>Nearly 50% of RAM had been used for buffers at this moment. Why is there
>>so much memory used for buffers?
>>
> 
> It's very strange.  The large amount of buffercache usage is to
> be expected from statting 20 gigs worth of files, but the kernel
> should (and normally does) free up that memory on demand.
> 
> Which filesystem(s) are you using?
> 
> Are you using NFS/NBD/SMBFS or anything like that?
> 

Basically, I'm using NFS and reiserfs. But I didn't use any file on NFS 
since the last reboot - and the NFS-shares haven't been mounted.

There are 2 IDE-Harddisks in this machine:
hda: WDC WD205AA, ATA DISK drive (40079088 sectors (20520 MB) w/2048KiB
				  cache, CHS=2494/255/63, UDMA(66))
hdb: WDC WD450AA-00BAA0, ATA DISK drive (87930864 sectors (45021 MB)
					w/2048KiB Cache,
					CHS=5473/255/63, UDMA(66))

On hda, I have got 7 partitions (plus one little "boot"-partition, which 
isn't mounted and a 200MB swap partition).
On hdb, I have got 12 partitions and one more, meanwhile 1GB swap partition.
All partitions are formated with reiserfs.


Regards,
Andreas Hartmann

