Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTEFVHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEFVHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:07:03 -0400
Received: from lakemtao04.cox.net ([68.1.17.241]:57051 "EHLO
	lakemtao04.cox.net") by vger.kernel.org with ESMTP id S261769AbTEFVGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:06:37 -0400
Message-ID: <3EB826B8.3030307@cox.net>
Date: Tue, 06 May 2003 16:18:48 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Riley Williams <Riley@Williams.Name>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] Zipdrive messages too much
References: <BKEGKPICNAKILKJKMHCAEENJCKAA.Riley@Williams.Name>
In-Reply-To: <BKEGKPICNAKILKJKMHCAEENJCKAA.Riley@Williams.Name>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that the zipdrive works perfectly in kernel 2.5.69-bk1 
without all of these messages. It floods me with these messages in 
2.4.21-rc1 though. That is why I think something got lost in a patch 
somewhere.

-David

Riley Williams wrote:
> Hi David.
> 
> I have a Zip-250 drive that works fine under Linux, but it's the EIDE model,
> not the parallel-SCSI version you appear to have. As a result, I don't know
> whether this is relevant, but...
> 
> I remember reading somewhere that there was a jumper on the parallel-SCSI
> zip drives that changed how it works, and I seem to recall that whilst the
> M$ Windows driver had no problem in either position, the Linux driver only
> worked in one position as the other was undocumented.
> 
> Not sure if that was ever sorted out as I haven't heard about it for
> years...
> 
> Best wishes from Riley.
> ---
>  * Nothing as pretty as a smile, nothing as ugly as a frown.
> 
> 
>  >>> Apr 23 11:41:35 aeon kernel: sda : READ CAPACITY failed.
>  >>> Apr 23 11:41:35 aeon kernel: sda : status = 1, message = 00, host = 0,
>  >>> driver = 08
>  >>> Apr 23 11:41:35 aeon kernel: Current sd00:00: sns = 70  2
>  >>> Apr 23 11:41:35 aeon kernel: ASC=3a ASCQ= 0
>  >>> Apr 23 11:41:35 aeon kernel: Raw sense data:0x70 0x00 0x02 0x00 0x00
>  >>> 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff
>  >>> 0xfe 0x01 0x00 0x00 0x00 0x00
>  >>> Apr 23 11:41:35 aeon kernel: sda : block size assumed to be 512 bytes,
>  >>> disk size 1GB.
>  >>> Apr 23 11:41:35 aeon kernel: sda: Write Protect is off
>  >>> Apr 23 11:41:35 aeon kernel:  sda: I/O error: dev 08:00, sector 0
>  >>> Apr 23 11:41:35 aeon kernel:  I/O error: dev 08:00, sector 0
>  >>> Apr 23 11:41:35 aeon kernel:  unable to read partition table
>  >>> Apr 23 11:41:35 aeon kernel: Device not ready.  Make sure there is a
>  >>> disc in the drive.
> 
>  > I added more SCSI logging support so the below is better info than the
>  > above. Sorry. Forgot the logging when I posted this. I knew it looked
>  > extra weird.
>  >
>  > sda : READ CAPACITY failed.
>  > sda : status = 1, message = 00, host = 0, driver = 08
>  > Current sd00:00: sense key Not Ready
>  > Additional sense indicates Medium not present
>  > sda : block size assumed to be 512 bytes, disk size 1GB.
>  > sda: Write Protect is off
>  >   sda: I/O error: dev 08:00, sector 0
>  >   I/O error: dev 08:00, sector 0
>  >   unable to read partition table
>  > Device not ready.  Make sure there is a disc in the drive.
>  >
>  > Hope this helps more.

