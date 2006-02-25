Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWBYPcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWBYPcc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbWBYPcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:32:32 -0500
Received: from rtr.ca ([64.26.128.89]:31944 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161009AbWBYPcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:32:31 -0500
Message-ID: <44007892.9090002@rtr.ca>
Date: Sat, 25 Feb 2006 10:32:34 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <Pine.LNX.4.64.0602231838420.3374@p34>
In-Reply-To: <Pine.LNX.4.64.0602231838420.3374@p34>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> I have reproduced the error with the patched kernel!
> 
> Here it is:
> 
> [263864.109854] ata3: translated ATA stat/err 0x51/04 to SCSI 
> SK/ASC/ASCQ 0xb/00/00
> [263864.109861] ata3: status=0x51 { DriveReady SeekComplete Error }
> [263864.109866] ata3: error=0x04 { DriveStatusError }

Nope.. patch not present, as otherwise the line above would have
read something like this:

 > [263864.109854] ata3: translated op=0x21 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00

So we didn't get the extra info since the patch wasn't present.

Cheers
