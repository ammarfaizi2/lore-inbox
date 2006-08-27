Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWH0QSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWH0QSU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWH0QSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:18:20 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:59113 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932157AbWH0QST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:18:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=O4vFj22gxun40RHQREXordY51GEbwg4x7Wlkt8AvcutGM7kP1pigVIXaPCBeGvWadD1sljPQC2GxUVIFh4LUBwW9nxokHGkauqHblc1EM3rQVEEkJgoMlGpwYKivDfZdztcCLEI2rO96OeO3zdvx+wCB4O1HM+AaocXdkYa0Les=
Message-ID: <44F1C5C5.3030504@gmail.com>
Date: Mon, 28 Aug 2006 01:18:13 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: translated ATA stat/err 0x51/0c to ... PDC20376 (FastTrak 376)
 related cold freezes
References: <1156440866.29118.14.camel@localhost>	 <44F167C0.6020903@gmail.com> <1156692788.12244.11.camel@localhost>
In-Reply-To: <1156692788.12244.11.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:
> On Sun, 2006-08-27 at 18:37 +0900, Tejun Heo wrote:
>> Soeren Sonnenburg wrote:
>>> Dear all,
>>>
>>> I just upgraded to using 2 sata disks (both seagate drives
>>> ST3400832AS and ST3750640AS) on this asus a7v8x on-board promise fastrak
>>> 376 (PDC20376) controller. However, as soon as I do a lot of io (cp some
>>> G of files) I get swamped in 
>>>
>>> ata1: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
>>> ata1: status=0x51 { DriveReady SeekComplete Error }
>>> ata1: error=0x0c { DriveStatusError }
>>> ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
>>> ata2: status=0x51 { DriveReady SeekComplete Error }
>>> ata2: error=0x0c { DriveStatusError }
>>> ...
>> Is the system usable after these messages?
> 
> Yes, however I got cold freezes from (time to time) after a while...

I see.  your drive is reporting error for some reason and libata is 
failing to recover.

>>> messages. For that it is enough to do it on a single drive or copy from
>>> drive to drive. This is on kernel 2.6.17.4, but I remember (when I was
>>> still using a single drive) this very same output to happen on 2.6.15.
>>>
>>> Can anyone translate these dubious error messages to me ?
>>>
>>> Here are more details about the system:
>>>
>>> - the sata_promise driver version 1.04 is used
>> Can you give a shot at 2.6.18-rc4?
> 
> I will, though I don't see much changes in that driver...

Ah.. right.  sata_promise isn't converted to new EH yet.  There's no 
reason to try -rc4.  Please stand by.

Thanks.

-- 
tejun
