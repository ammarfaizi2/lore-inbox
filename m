Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283795AbRLMLpH>; Thu, 13 Dec 2001 06:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283783AbRLMLo5>; Thu, 13 Dec 2001 06:44:57 -0500
Received: from hermes.domdv.de ([193.102.202.1]:49927 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S283782AbRLMLo4>;
	Thu, 13 Dec 2001 06:44:56 -0500
Message-ID: <XFMail.20011213124137.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20011213092908.6764@smtp.wanadoo.fr>
Date: Thu, 13 Dec 2001 12:41:37 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Kernel-2.4.17pre8 & invalidate: busy buffer
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Chen Shiyuan <csy@hjc.edu.sg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You will see this message with LVM too when issuing vgscan/vgchange.

On 13-Dec-2001 Benjamin Herrenschmidt wrote:
>>Hello,
>>
>>Currently while running on a RedHat Linux 7.2 box with kernel-
>>2.4.17pre8, whenever I run the "hdparm -t /dev/sda3" command, the 
>>following error message will appear around 33+ times 
>>in /var/log/messages as well as "dmesg" .
>>
>>invalidate: busy buffer
>>
>>The machine in question is a Dell PowerEdge 2550 with an AACRAID 
>>controller and 2 x 18GB HDs in RAID-1 configuration and /dev/sda3 being 
>>mount as / .
> 
> That's interesting. I've been seeing this message for some time now
> (I think since around 2.4.15 at least, maybe longer). I modified the
> printk to display the device number, and at that time, it seemed to
> always originate from the partition that had a mounted HFS volume.
> So I just added that to my (long) list of HFS bugs to fix when I
> find enough time to dive into it.
> 
> However, I just got a report from some users having the same message
> displayed when using parted and with no HFS partition (HFS filesystem
> not loaded). I personally see this messages when using/leaving MacOnLinux
> emulator (which is opening the block device of a partition that is also
> mounted), or when shutting down the box.
> 
> Al, any clue ? Something you want me to do to track it further down ?
> 
> Ben.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
