Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbRHCKlj>; Fri, 3 Aug 2001 06:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbRHCKlT>; Fri, 3 Aug 2001 06:41:19 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:8966 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S268511AbRHCKlQ>;
	Fri, 3 Aug 2001 06:41:16 -0400
Date: Fri, 03 Aug 2001 12:41:23 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux can't find partitions , again
To: david.balazic@uni.mb.si
Message-id: <3B6A7FD3.15549CB0@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3B6A739A.7D6197CD@uni-mb.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please, LKML people only reply to LKML ( and me ),
ignore the redhat address.
Redhat people , do the opposite.

Seems that my mail server discloses "BCC:" fields if there is no "To:" field ...
Sorry.

David Balazic wrote:
> 
> Hi!
> 
> Yesterday I did "nothing" (*) and then linux didn't boot anymore.
> It couldn't mount the root FS.
> After I fixed that , it couldn't turn on the swap partition.
> 
> This really pisses me off ! ( I am cool now, you should see me yesterday )
> 
> The problem was that the partitions were renumbered "randomly"
> and linux just can not deal with that. Before linux named the root FS
> partition hda6, but now he names it hda7. Off course the kernel still looks
> for hda6 and fails. After I fix LILO , it boots, but fails to turn on the swap
> as it was renamed from hda7 to hda5. I edit /etc/fstab and all is well.
> Until next time.
> 
> This has bitten me and my neighbour enough times that I wrote a kernel patch
> to fix ( 99% fix ) the first problem ( root-FS ) and I don't write kernel patches
> every week !
> I didn't address the second problem ( swap ).
> 
> The patch works by scanning all known partitions for a matching ext2 UUID ( or label ).
> Maybe a simpler solution would be to search the partition list for a particular
> disk ( hda ) for a partition which has a particular (start,size) pair ? ( less disk access,
> FS-type neutral , would work for the swap problem too )
> 
> Patch available at
> http://linux-patches.rock-projects.com/v2.2-f/uuid.html
> 
> Opinions ?
> 
> * - I created a partition on the free part of the disk, but after a minute
> I changed my mind an deleted it. I used the Disk Administrator tools undwr win2000
> 
> --
> David Balazic
> --------------
> "Be excellent to each other." - Bill & Ted
> - - - - - - - - - - - - - - - - - - - - - -
> 
> _______________________________________________
> Testers-list mailing list
> Testers-list@redhat.com


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
