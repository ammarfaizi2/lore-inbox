Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbUKXOvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbUKXOvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUKXOo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:44:58 -0500
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:19426 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S262742AbUKXOnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:43:12 -0500
Message-ID: <41A49DA5.9090900@ttnet.net.tr>
Date: Wed, 24 Nov 2004 16:41:41 +0200
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: status of cdrom patches for 2.4 ?
References: <41A3C391.8070609@ttnet.net.tr> <20041124074336.GB8718@logos.cnet> <20041124125319.GB13847@suse.de>
In-Reply-To: <20041124125319.GB13847@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Nov 24 2004, Marcelo Tosatti wrote:
> 
>>On Wed, Nov 24, 2004 at 01:11:13AM +0200, O.Sezer wrote:
>>
>>>Hi all:
>>>
>>>What are the status of the cdrom patches for 2.4 series?
>>>Namely the dvd patches which are dropped while in the
>>>27-rc era, and the cd-mrw patch which never had a chance
>>>trying to go in to 2.4. Jens? Mancelo?
>>
>>There were problems with the DVD-RW patches so I reverted them.

Yup.  Pat then posted a patch which supposedly fixed it by placing
something like
	else if (CDROM_CAN(CDC_DVD_RAM))
		ret = 0;
in cdrom_open_write():
http://marc.theaimsgroup.com/?t=109156838400001&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=109156820507518&w=2

Jens' MRW patch also introduces a new function: cdrom_dvdram_open_write
(which, in turn, calls cdrom_media_erasable), CDROM_CAN(CDC_DVD_RAM)
check in cdrom_open_write() is assigned to it; which again is supposed
to fix it.

>>Jens, what do you think?
> 
> 
> I don't think it's worth the bother, the support is in 2.6. And I don't
> want to maintain new atapi stuff for 2.4. Pat used to care about the
> patches, but as he is no longer with Iomega I don't think there's anyone
> to look after it.

Which is truly a pity. Yes I can understand that a maintainer needs
to concentrate on new trees etc, but it's pity.  Especially hearing
the pre-recorded "Hey 2.6 already has it, upgrade to it" message is
always nice ;)

Ozkan Sezer

