Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbRGXOX3>; Tue, 24 Jul 2001 10:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbRGXOXU>; Tue, 24 Jul 2001 10:23:20 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:50359 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S267543AbRGXOXH>; Tue, 24 Jul 2001 10:23:07 -0400
Message-Id: <5.1.0.14.2.20010724151125.00a6a880@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 24 Jul 2001 15:21:29 +0100
To: alad@hss.hns.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: /boot partition creation
Cc: linux-kernel@vger.kernel.org, rshekhar@hss.hns.com
In-Reply-To: <65256A93.004BE747.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

At 13:37 24/07/01, alad@hss.hns.com wrote:
>     I am trying to install redhat 7.1 on my m/c that already has an 8.5gb 
> win NT partition.
>During partition configuration, I cannot create /boot as it says that "/boot
>cannot be created after 8.5G"
>I know the reason.. but don't know the remedy

Please note that this is not really a kernel topic... so this is the wrong 
list to ask... But anyway, I will try to give you a suggestion:

Try to install without making a separate /boot partition and leave yourself 
some space for that. Then use the created boot floppy to get into your 
linux install after finishing the installation if the normal boot process 
doesn't work.

Then edit /etc/lilo.conf adding the lba32 parameter to the file. Then rerun 
lilo and it should be able to boot fine from HD, the 8.5GB limit no longer 
should matter. - This should work unless you have some old bios...

You can then just manually create a partition, mount it somewhere, copy 
everything from /boot to it (cp -ar) then unmount it, rm -rf /boot, setup 
/etc/fstab to the new partition mount as /boot and type mount /boot. It 
should be all done. Then just rerun lilo and reboot to check it is all 
fine. It should be. - Just make sure that creating the /boot partition 
doesn't rename your other linux partitions and if it does, you need to 
update /etc/fstab accordingly before you reboot...

HTH,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

