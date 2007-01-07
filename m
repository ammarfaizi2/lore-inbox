Return-Path: <linux-kernel-owner+w=401wt.eu-S932525AbXAGMrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbXAGMrh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 07:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbXAGMrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 07:47:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:23654 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525AbXAGMrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 07:47:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VshBdFQadpqYlR9HuJCshMfkMJan3ZMnIhNsac5EvnfPpW5i6AtK/M2lIenL/YO6UCWtLj9bAQ664ygnoV6r6gq8Mq9Bt2wtQwyRJ/6kse0SVUSj/8064mxSUSg/aC59/IDPimEAZSXDjWosih470NhouvCoyhL2P+hC5ikhwVo=
Message-ID: <45A092B7.4070301@gmail.com>
Date: Sun, 07 Jan 2007 15:27:03 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Mark Wagner <mark@lanfear.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sata_sil24 lockups under heavy i/o
References: <20070103173024.GB17650@freddy.lanfear.net> <20070104181601.GD17650@freddy.lanfear.net>
In-Reply-To: <20070104181601.GD17650@freddy.lanfear.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Mark Wagner wrote:
[--snip--]
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status e000.
[--snip--]
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hda: status timeout: status=0xd0 { Busy }
> ide: failed opcode was: unknown
> hdb: DMA disabled
> hda: no DRQ after issuing MULTWRITE_EXT
> ata3.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
> ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata4: hard resetting port
> ata2.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
> ata2.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata2: hard resetting port
> ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
> ata1.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata1.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
[--snip--]
> i2c_adapter i2c-0: Transaction error!
> i2c_adapter i2c-0: Transaction error!
> i2c_adapter i2c-0: Transaction error!

It seems like your system is falling apart.  Timeouts are occurring 
everywhere.  Either IRQ routing went wrong or your powersupply is not 
providing enough power.  Adding two more disks to sil24 doesn't change 
anything about IRQ routing.  If the system functioned okay w/ two disks 
attached to sil24, give your system a better power supply or rewire 
power cables such that each power lane is more equally loaded.

-- 
tejun

