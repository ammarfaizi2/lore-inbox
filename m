Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWDATFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWDATFG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 14:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWDATFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 14:05:06 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51961 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932155AbWDATFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 14:05:04 -0500
Date: Sat, 01 Apr 2006 13:03:59 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
In-reply-to: <5WEvy-7az-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>
Message-id: <442ECE9F.4020206@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5WD6n-5fR-9@gated-at.bofh.it> <5WD6n-5fR-11@gated-at.bofh.it>
 <5WD6n-5fR-13@gated-at.bofh.it> <5WD6n-5fR-15@gated-at.bofh.it>
 <5WD6n-5fR-17@gated-at.bofh.it> <5WD6n-5fR-7@gated-at.bofh.it>
 <5WEvy-7az-7@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
>>> hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>>> hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
>>
>> Hmm, are these new? Sure you don't have a bad IDE cable?
> 
> Oh, those aren't the errors I'm worried about; I've had those for a 
> while and they're harmless.  Those are due to the kernel running the IDE 
> controller at a higher-than-supported speed.  It gets errors for a 
> couple seconds and automatically drops the bus down to a lower and safer 
> speed.

That would be a bug, no? Sounds dangerous to rely on that.

>  The cable's aren't bad, I've tried at least 6 different 
> 80-conductor cables that all work fine in other systems.  The errors I 
> _am_ worried about are these:
> 
>> Mar 28 03:15:13 penelope kernel: hdi: status timeout: status=0xd0 { 
>> Busy }
>> Mar 28 03:15:13 penelope kernel: PDC202XX: Secondary channel reset.
>> Mar 28 03:15:13 penelope kernel: hdi: no DRQ after issuing MULTWRITE_EXT
>> Mar 28 03:15:13 penelope kernel: ide4: reset: success
>> Mar 28 03:30:13 penelope kernel: hdi: status timeout: status=0xd0 { 
>> Busy }
>> Mar 28 03:30:13 penelope kernel: PDC202XX: Secondary channel reset.
>> Mar 28 03:30:13 penelope kernel: hdi: no DRQ after issuing MULTWRITE_EXT
>> Mar 28 03:30:13 penelope kernel: ide4: reset: success

That sounds fishy to me. If the controller is having trouble 
communicating with the drive causing BadCRC errors, it could easily 
cause such errors as the above as well.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

