Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286242AbRLJMHU>; Mon, 10 Dec 2001 07:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286244AbRLJMHL>; Mon, 10 Dec 2001 07:07:11 -0500
Received: from cpe.atm0-0-0-122182.0x3ef30264.bynxx2.customer.tele.dk ([62.243.2.100]:60855
	"HELO fugmann.dhs.org") by vger.kernel.org with SMTP
	id <S286242AbRLJMG6>; Mon, 10 Dec 2001 07:06:58 -0500
Message-ID: <3C14A560.1020501@fugmann.dhs.org>
Date: Mon, 10 Dec 2001 13:06:56 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Freedman <freedman@ccmr.cornell.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS stale mount after chroot...
In-Reply-To: <20011209205707.A13073@ccmr.cornell.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the same, though I have not tried to chroot.

It happens when I have run mozilla from a NFS mounted fs.

Both client and server is 2.4.16, but I have had this problem with older 
kernels. NFSv3 support is compiled in both kernels.

lsof and fuser reports that no files are in use, but I'm unable to 
unmount the filesystem. Btw. The filesystem is mounted ro. (and exported 
ro). The exported filesystem is a reiser-fs.

I would really be greatfull if this issue was to be resolved.

Thanks in advance

Anders Fugmann

On 12/10/2001 02:57 AM, Daniel Freedman wrote:

> Hi,
> 
> It seems like I can generate reproducible stale NFS mounts by mounting
> a partition, chroot'ing into that mount, immediately exiting the
> chroot, and then finding myself unable to unmount the NFS partition.
> I'm pretty sure I've confirmed that nothing is using the partition
> (both with fuser and lsof) and even tried to force umount the
> partition (which seems like it should definitely umount it, rather
> than returning with the same "device is busy" errors), to no avail.
> The only method which I've used that seems to be able to get rid of
> this NFS mount, is to reboot the NFS client, and clearly that's not a
> good one at all.  If I'm missing something obvious here, my apologies
> in advance.  Also, if there's any further information I can provide,
> I'd be happy to help.  The dump of my procedure follows this message.
> 
> Thanks again and take care,
> Daniel
> 
> 


