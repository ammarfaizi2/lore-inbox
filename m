Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWFTPpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWFTPpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWFTPpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:45:09 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:10113 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751337AbWFTPpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:45:07 -0400
Message-ID: <44981800.2000807@dgreaves.com>
Date: Tue, 20 Jun 2006 16:45:04 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: Re: LibPATA/ATA Errors Continue - Will there be a fix for this?
References: <Pine.LNX.4.64.0606200808250.5851@p34.internal.lan> <4497F1C7.2070007@rtr.ca> <449804EA.8030908@dgreaves.com>
In-Reply-To: <449804EA.8030908@dgreaves.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Some email archaeology later]

Back in March I was running 2.6.16 (with the opcode patch) and I sent an
email with the following info:

dmesg:
ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/04 to SCSI
SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }

Does that help with the diagnosis?

Also see my emails: SMART on SATA reporting errors?
  http://marc.theaimsgroup.com/?l=linux-ide&m=113933732903205&w=2

I did reply but got no response so I assumed I was just so far off base
that I was being ignored :)

David

David Greaves wrote:
> Mark Lord wrote:
>   
>> MMm.. probably "barrier" commands that the drive doesn't like.
>> Pity those messages don't also dump the failed opcode.
>>     
> For me:
> smartctl -data -o on /dev/sda
> produces this on 2.6.17-rc5
>
> (I thought the opcode patch went into 2.6.17...)
>
> ata1: PIO error
> ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x04 { DriveStatusError }
> ata1: PIO error
> ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x04 { DriveStatusError }
> ata1: PIO error
> ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x04 { DriveStatusError }
> ata1: PIO error
> ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x04 { DriveStatusError }
> ata1: PIO error
> ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x04 { DriveStatusError }
> ata1: PIO error
> ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x04 { DriveStatusError }
>
> David
>
>   
>>> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: status=0x51 {
>>> DriveReady SeekComplete Error }
>>> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: error=0x04 {
>>> DriveStatusError }
>>> Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: status=0x51 {
>>> DriveReady SeekComplete Error }
>>> Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: error=0x04 {
>>> DriveStatusError }
>>> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: no sense
>>> translation for status: 0x51
>>> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: status=0x51 {
>>> DriveReady SeekComplete Error }
>>> Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: no sense
>>> translation for status: 0x51
>>> Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: status=0x51 {
>>> DriveReady SeekComplete Error }
>>> Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: no sense
>>> translation for status: 0x51
>>> Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: status=0x51 {
>>> DriveReady SeekComplete Error }
>>>       
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   


-- 

