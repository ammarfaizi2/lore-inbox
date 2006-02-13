Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWBMNQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWBMNQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWBMNQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:16:34 -0500
Received: from main.gmane.org ([80.91.229.2]:40680 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932426AbWBMNQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:16:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Is my SATA/400GB drive dying?
Date: Mon, 13 Feb 2006 22:16:08 +0900
Message-ID: <dsq0qp$egf$1@sea.gmane.org>
References: <Pine.LNX.4.64.0602130658110.21652@p34> <Pine.LNX.4.64.0602130659420.21772@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060209)
In-Reply-To: <Pine.LNX.4.64.0602130659420.21772@p34>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please try to not break the threading, just reply to your post.

Justin Piszcz wrote:
> There are different errors at the end of the lines:
> 
> 0xb/00/00 and 0x3/11/04
> 
> Anyone know what these mean?
> 
> [31230.223511] ata6: status=0x51 { DriveReady SeekComplete Error }
> [31230.223515] ata6: error=0x04 { DriveStatusError }
> [37209.844015] ata6: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ
> 0xb/00/00
> [37209.844022] ata6: status=0x51 { DriveReady SeekComplete Error }
> [37209.844026] ata6: error=0x04 { DriveStatusError }
> [37861.648959] ata6: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ
> 0xb/00/00
> [37861.648965] ata6: status=0x51 { DriveReady SeekComplete Error }
> [37861.648970] ata6: error=0x04 { DriveStatusError }
> [37978.030178] ata6: no sense translation for status: 0x51
> [37978.030185] ata6: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ
> 0x3/11/04
> [37978.030188] ata6: status=0x51 { DriveReady SeekComplete Error }
> 
> 
> On Mon, 13 Feb 2006, Justin Piszcz wrote:
> 
>> I turned off smartd and when I cat /dev/zero > /mnt/disk/file, I get
>> the following errors:
>>
>> [37978.030178] ata6: no sense translation for status: 0x51
>> [37978.030185] ata6: translated ATA stat/err 0x51/00 to SCSI
>> SK/ASC/ASCQ 0x3/11/04
>> [37978.030188] ata6: status=0x51 { DriveReady SeekComplete Error }

I know you are feeling uneasy at best, but I have more or less the same
problems with two Raptors (WD740GD) on two Asus P5GCD-V Deluxe (ICH6) MBs. I
had to pull them out of the box to use the boxes, because they were
constantly freezing...

Report is here:
http://linux.tar.bz/reports/oopses/char/2.6.15.1-K01_P4_server.3.dmesg
	(and the dirs above)

So far I got one or two "me too" responses, but that was all. I think the
last working kernel was 2.6.11, but that is a bit too old to test now and
then I was not using libata, AFAIR.

Now one of the boxes uses Seagate ST3250823AS (25d uptime) and the other an
old PATA WDC WD102BB (yes that is only 10GB!).

How reproducible is yours?

We might file to bugzilla? (So far I always had the attention on LKML quick
enough)

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

