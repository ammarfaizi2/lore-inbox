Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267738AbUHEQBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267738AbUHEQBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUHEQBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:01:36 -0400
Received: from alea.erlm.siemens.de ([217.194.35.70]:57059 "EHLO
	alea.erlm.siemens.de") by vger.kernel.org with ESMTP
	id S267770AbUHEQBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:01:13 -0400
Message-ID: <DB51EBFA5812D611B6200002A528BC270379BF72@khes002a.khe1.siemens.de>
From: Kern Alexander <alexander.kern@siemens.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'alex.kern@gmx.de'" <alex.kern@gmx.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devic
	es
Date: Thu, 5 Aug 2004 18:00:55 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Thu, Aug 05 2004, Joerg Schilling wrote:
> 
>>>From: Jens Axboe <axboe@suse.de>
>>
>>>ATA method is misnamed, it's really SG_IO that is used. And you want to
>>>use that regardless of the device type, SCSI or ATAPI. There's no such
>>>thing as an ATA burner, and there's no need to differentiate between
>>>SCSI or ATAPI CD-ROM's when burning - SG_IO is the method to use. So
>>>forget browsing /proc/ide and other hacks.
>>
>>I am sorry but as Linux already has 6 different interfaces for sending 
>>Generic SCSI commands and thus, we are running out of names.
>>
>>Let me give you an advise: consolidate Linux so that is does only need
>>/dev/sg and fix the bugs in ide-scsi instead of constantly inventing new
>>unneeded interfaces.
> 
> 
> That's been the general direction for quite some time, just that SG_IO
> is the preferred method since that works all around. You were the one
> that merged support for the CDROM_SEND_PACKET interface, which has
> _never_ been advertised as a way to burn CDs in Linux. I'd suggest you
> remove that.
> 
Silly, as I suggested a patch to Joerg, it was the uniquely ability to burn
without
ide-scsi. And known you, it simply works, it let me to scan for burners(what
SG_IO cannot), it works
in 2.4.X and 2.6.X.

Make SG_IO better and CDROM_SEND_PACKET will die, without your suggestions.

Regards
Alex

P.S. I'm know that CDROM_SEND_PACKET has a overhead, by me it's 4%. I can
live with it.
