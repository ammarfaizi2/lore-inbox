Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWFKLNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWFKLNk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 07:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWFKLNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 07:13:40 -0400
Received: from lucidpixels.com ([66.45.37.187]:56485 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750775AbWFKLNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 07:13:39 -0400
Date: Sun, 11 Jun 2006 07:13:38 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>,
       David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de,
       smartmontools-support@lists.sourceforge.net
Subject: Re: LibPATA code issues / 2.6.16 (previously, 2.6.15.x)
In-Reply-To: <Pine.LNX.4.64.0604211704120.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606110712350.3276@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca>
 <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca>
 <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com>
 <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34>
 <Pine.LNX.4.64.0603050740500.3116@p34> <440B6CFE.4010503@rtr.ca>
 <440B76B4.5080502@pobox.com> <Pine.LNX.4.64.0604211511120.22768@p34>
 <44493023.4010109@pobox.com> <Pine.LNX.4.64.0604211226120.3701@g5.osdl.org>
 <444960CC.2000009@pobox.com> <Pine.LNX.4.64.0604211704120.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[4597362.011000] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[4597362.011000] ata3: status=0x51 { DriveReady SeekComplete Error }
[4597362.011000] ata3: error=0x04 { DriveStatusError }

Now under 2.6.16.20. (was doing an rsync from 1 drive (IDE) -> to this 
SATA) drive.

The SATA drive AFAIK does not have any issues, no bad sectors/etc, still 
the same drive as before, but this is the new one from the previous RMA.

Just FYI.


On Fri, 21 Apr 2006, Linus Torvalds wrote:

>
>
> On Fri, 21 Apr 2006, Jeff Garzik wrote:
>
>>
>> Agreed, though the original poster had already done a 400GB dd from
>> /dev/zero...
>
> Yes, but to a _file_ on the partition (ie he didn't overwrite any existign
> data, just the empty parts of a filesystem).
>
> I realize that it's not enough for the "re-allocate on write" behaviour,
> and for that you really _do_ need to re-write the whole disk to get all
> the broken blocks reallocated, but my argument was just that we should
> make sure to _tell_ people when they are overwriting all their old data ;)
>
> 		Linus
>
