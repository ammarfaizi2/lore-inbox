Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278450AbRK1RXZ>; Wed, 28 Nov 2001 12:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278381AbRK1RXQ>; Wed, 28 Nov 2001 12:23:16 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:32267 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S278450AbRK1RXD>;
	Wed, 28 Nov 2001 12:23:03 -0500
Date: Wed, 28 Nov 2001 18:22:59 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Journaling pointless with today's hard disks?
To: cw@f00f.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3C051D73.79AA08AB@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood (cw@f00f.org) wrote :

> On Sat, Nov 24, 2001 at 02:03:11PM +0100, Florian Weimer wrote: 
> 
>     When the drive is powered down during a write operation, the 
>     sector which was being written has got an incorrect checksum 
>     stored on disk. So far, so good---but if the sector is read 
>     later, the drive returns a *permanent*, *hard* error, which can 
>     only be removed by a low-level format (IBM provides a tool for 
>     it). The drive does not automatically map out such sectors. 
> 
> AVOID SUCH DRIVES... I have both Seagate and IBM SCSI drives which a 
> are hot-swappable in a test machine that I used for testing various 
> journalling filesystems a while back for reliability. 
> 
> Some (many) of those tests involved removed the disk during writes 
> (literally) and checking the results afterwards.

What do you mean by "removed the disk" ?

- rm /dev/hda ? :-)
- disconnect the disk from the SCSI or ATA bus ?
- from the power supply ?
- both ?
- something else ?

> 
> The drives were set not to write-cache (they don't by default, but all 
> my IDE drives do, so maybe this is a SCSI thing?) 
> 
> At no point did I ever see a partial write or corrupted sector; nor 
> have I seen any appear in the grown table, so as best as I can tell 
> even under removal with sustain writes there are SOME DRIVES WHERE 
> THIS ISN'T A PROBLEM. 
> 
> Now, since EMC, NetApp, Sun, HP, Compaq, etc. all have products which 
> presumable depend on this behavior, I don't think it's going to go 
> away, it perhaps will just become important to know which drives are 
> brain-damaged and list them so people can avoid them. 
> 
> As this will affect the Windows world too consumer pressure will 
> hopefully rectify this problem. 
> 
>   --cw 
> 
> P.S. Write-caching in hard-drives is insanely dangerous for 
>      journalling filesystems and can result in all sorts of nasties. 
>      I recommend people turn this off in their init scripts (perhaps I 
>      will send a patch for the kernel to do this on boot, I just 
>      wonder if it will eat some drives). 

-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
