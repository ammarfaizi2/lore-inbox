Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbULAV41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbULAV41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbULAV41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:56:27 -0500
Received: from smtp07.web.de ([217.72.192.225]:9396 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S261465AbULAV4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:56:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <1101763996l.13519l.0l@werewolf.able.es>
	<Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr>
	<1101765555l.13519l.1l@werewolf.able.es>
	<20041130071638.GC10450@suse.de>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Wed, 01 Dec 2004 22:56:32 +0100
In-Reply-To: <20041130071638.GC10450@suse.de> (Jens Axboe's message of "Tue,
 30 Nov 2004 08:16:39 +0100")
Message-ID: <87eki9bs33.fsf@plailis.daheim.bs>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Mon, Nov 29 2004, J.A. Magallon wrote:
>> dev=ATAPI uses ide-scsi interface, through /dev/sgX. And:
>> 
>> > scsibus: -1 target: -1 lun: -1
>> > Warning: Using ATA Packet interface.
>> > Warning: The related Linux kernel interface code seems to be unmaintained.
>> > Warning: There is absolutely NO DMA, operations thus are slow.
>> 
>> dev=ATA uses direct IDE burning. Try that as root. In my box, as root:
>
> Oh no, not this again... Please check the facts: the ATAPI method uses
> the SG_IO ioctl, which is direct-to-device. It does _not_ go through
> /dev/sgX, unless you actually give /dev/sgX as the device name. It has
> nothing to do with ide-scsi. Period.
>
> ATA uses CDROM_SEND_PACKET. This has nothing to do with direct IDE
> burning, it's a crippled interface from the CDROM layer that should not
> be used for anything.  scsi-linux-ata.c should be ripped from the
> cdrecord sources, or at least cdrecord should _never_ select that
> transport for 2.6 kernels. For 2.4 you are far better off using
> ide-scsi.

Are you sure you don't mix ATA with ATAPI? I think ATA is equivalent to
dev=/dev/hdX. 

regards
Markus

