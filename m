Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269928AbUJMXsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269928AbUJMXsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269930AbUJMXsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:48:16 -0400
Received: from capitol.mail.pas.earthlink.net ([207.217.120.180]:23968 "EHLO
	capitol.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S269928AbUJMXsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:48:06 -0400
Message-ID: <416D15BB.9020002@mcn.net>
Date: Wed, 13 Oct 2004 05:47:07 -0600
From: TimO <hairballmt@mcn.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Richard B. Johnson" <root@chaos.analogic.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.8 Hates DOS partitions
References: <Pine.LNX.4.61.0410131329110.3818@chaos.analogic.com> <20041013213519.GA3379@pclin040.win.tue.nl>
In-Reply-To: <20041013213519.GA3379@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Wed, Oct 13, 2004 at 01:31:34PM -0400, Richard B. Johnson wrote:
> 
> 
>>Only the DOS partitions and the swap are used in this new configuration.
>>This is a new "Fedora Linux 2" installation on a completely
>>different IDE hard disk, in which I have to enable boot disks in
>>the BIOS to boot the new system.
>>
>>Immediately after installing the new system I reverted (in the BIOS)
>>to the original to make sure that I was still able to boot the old
>>system and the DOS partition. Everything was fine.
>>
>>Then I installed linux-2.6.8 after building a new kernel with
>>the old ".config" file used as `make oldconfig`. Everything was
>>fine after that, also.
>>
>>I have now run for about a week and I can't boot the DOS partition
>>anymore!
>>
>>I can copy everything  from C: and D: from within Linux
>>and then re-do the DOS partitions, BUT.... bad stuff
>>will happen again unless the cause is found.
> 
> 
> Well, if you do and the same thing happens, we know that there is something
> reproducible here. That is always good to know. It might be that you did
> something a week ago and forgot all about it and now have a strange bug.
> 
> If this is reproducible, then there are lots of possible explanations.
> 
> Have you considered the numbering of the disks? You changed things in
> the BIOS. Did the Linux SCSI disk numbering remain the same?
> 
> Andries
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

Having experienced a similar but not exact situation; I'm going to
suggest that your BIOS is to blame.  (AMI?)  If you hadn't already
done a MBR restore; I would have suggested for you to remove the ATA
disk to see if you could once again boot to DOS.  You might remove
it anyway to see if a boot from DOS floppy will again allow you to
'see' the DOS D:\ partition.
   My situation actually arose from a motherboard swap; AOpen/Award/K7
--> GByte/AMI/AthlonXP.  Linux booted fine and ran for 2 weeks with-
out problem.  I could even see/read all the DOS/VFAT partitions just
fine.  It wasn't until I went to boot Win98 that I noticed the prob-
lem(Invalid system disk).  Booting from a floppy showed a "Drive not
ready" for C:(hda2); D:(hdc1) looked fine but became corrupt as soon
as I wrote to it, and E:(hdc2) didn't even show.  I made sure to
transfer the IDE settings exactly but no amount of war would allow
both systems to boot from the same hard drive(ATA)on the GByte/AMI
board and I eventually managed to trash the Linux / as well.  Another
motherboard with an Award/Pheonix Bios, a little restoration and all
is once again right with the(my) world.

oh, YMMV   :)
