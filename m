Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267534AbUHEAkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267534AbUHEAkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 20:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267531AbUHEAkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 20:40:14 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:33756 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S267529AbUHEAkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 20:40:01 -0400
Message-ID: <411181DE.1050304@tomt.net>
Date: Thu, 05 Aug 2004 02:39:58 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 SATA (SCSI emulation) sw-raid1 - lockup when 1 drive is
 removed
References: <4111577A.9010901@geizhals.at>
In-Reply-To: <4111577A.9010901@geizhals.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marinos J. Yannikos wrote:
> A box with a stock 2.6.7 kernel using the Promise SX4 controller 
> (CONFIG_SCSI_SATA_SX4, i.e. libata driver) locks up completely when one 
> of the 2 drives in a raid 1 configuration is removed. I believe this is 
> not how raid 1 is supposed to work. ;-) swap was initially on the drive 
>   I removed only (/dev/sdb2), but I also tested this with swap on a raid 
> volume (/dev/md2 = /dev/sdb2 + /dev/sdc2)- the effect is exactly the 
> same in both cases.
> 
> The last message seen is: "ata1 DMA timeout", then the console stops 
> working. dmesg output and config.gz available at: 
> http://stuff.geizhals.at/misc/2004-08-04/
> 
> Perhaps there is a work-around or this issue can be resolved quickly 
> before one of the drives actually dies...

I've seen this same thing when S-ATA drives have really died on me while 
using 2.4.24-26+libata, computer just locks up even when used with md 
RAID1/RAID5. Though this is Intel ICH5("R"). Didn't have any time to get 
any more debugging done at those few times, though.

It's mostly just annoying to have to reset the machines, especially as 
this does not happen with the drivers/ide drivers (not verified with 
ich5 specificly).

-- 
André Tomt
