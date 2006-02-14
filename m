Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbWBNJnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbWBNJnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030533AbWBNJnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:43:21 -0500
Received: from lucidpixels.com ([66.45.37.187]:38810 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030538AbWBNJnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:43:19 -0500
Date: Mon, 13 Feb 2006 20:18:47 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Re: Is my SATA/400GB drive dying?
In-Reply-To: <Pine.LNX.4.64.0602132016350.2607@p34>
Message-ID: <Pine.LNX.4.64.0602132018290.2607@p34>
References: <Pine.LNX.4.64.0602130658110.21652@p34> <Pine.LNX.4.64.0602132016350.2607@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spoke too fast.

Still get the errors:

[ 2311.980127] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[ 2311.980134] ata3: status=0x51 { DriveReady SeekComplete Error }
[ 2311.980138] ata3: error=0x04 { DriveStatusError }


But the drive speed is back to normal!

# hdparm -t /dev/sdc

/dev/sdc:
  Timing buffered disk reads:  154 MB in  3.01 seconds =  51.12 MB/sec
#

On Mon, 13 Feb 2006, Justin Piszcz wrote:

> The problem was I had too many SATA devices in my system, I removed two 
> drives and a Promise SATA/150 and then everything went back to normal, no 
> more errors and back to 50MB/s+.
>
>
> On Mon, 13 Feb 2006, Justin Piszcz wrote:
>
>> I turned off smartd and when I cat /dev/zero > /mnt/disk/file, I get the 
>> following errors:
>> 
>> [37978.030178] ata6: no sense translation for status: 0x51
>> [37978.030185] ata6: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 
>> 0x3/11/04
>> [37978.030188] ata6: status=0x51 { DriveReady SeekComplete Error }
>> 
>> 
>
