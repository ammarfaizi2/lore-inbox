Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWH0JhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWH0JhM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWH0JhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:37:11 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:32208 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751348AbWH0JhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:37:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=d2SrL2pJM9v13/nIJeOXfrxKvRJkwV8pmsf+xjGUGHg36DssH9cnuC+zmoXE9oMUtPVX2hN2gw7bLXzLqxdVW1fVS7XbhbGwNW+aLCWyW2P4Fzd17NV3SvFMxN2ScV0RyS9d+tK8sFup7I5LsXQZVXf+iPclMUA3Zzf/JiVbTL8=
Message-ID: <44F167C0.6020903@gmail.com>
Date: Sun, 27 Aug 2006 18:37:04 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: translated ATA stat/err 0x51/0c to ... PDC20376 (FastTrak 376)
 related cold freezes
References: <1156440866.29118.14.camel@localhost>
In-Reply-To: <1156440866.29118.14.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:
> Dear all,
> 
> I just upgraded to using 2 sata disks (both seagate drives
> ST3400832AS and ST3750640AS) on this asus a7v8x on-board promise fastrak
> 376 (PDC20376) controller. However, as soon as I do a lot of io (cp some
> G of files) I get swamped in 
> 
> ata1: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x0c { DriveStatusError }
> ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: error=0x0c { DriveStatusError }
> ...

Is the system usable after these messages?

> messages. For that it is enough to do it on a single drive or copy from
> drive to drive. This is on kernel 2.6.17.4, but I remember (when I was
> still using a single drive) this very same output to happen on 2.6.15.
> 
> Can anyone translate these dubious error messages to me ?
> 
> Here are more details about the system:
> 
> - the sata_promise driver version 1.04 is used

Can you give a shot at 2.6.18-rc4?

-- 
tejun
