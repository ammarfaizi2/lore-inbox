Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVBJCFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVBJCFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 21:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVBJCFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 21:05:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35716 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262009AbVBJCFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 21:05:03 -0500
Message-ID: <420AC138.1060005@pobox.com>
Date: Wed, 09 Feb 2005 21:04:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl>	 <4206F2E5.7020501@gmail.com>	 <200502070959.54973.bzolnier@elka.pw.edu.pl>	 <420AA476.1040406@gmail.com>	 <58cb370e050209162437808733@mail.gmail.com>	 <420AB049.4040705@gmail.com> <58cb370e05020917312994f531@mail.gmail.com>
In-Reply-To: <58cb370e05020917312994f531@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Thu, 10 Feb 2005 09:52:25 +0900, Tejun Heo <htejun@gmail.com> wrote:
> 
>>  Okay, another quick question.
>>
>>  To fix the io_32bit race problem in ide_taskfile_ioctl() (and later
>>ide_cmd_ioctl() too), it seems simplest to mark the taskfile with
>>something like ATA_TFLAG_IO_16BIT flag and use the flag in task_in_intr().
>>
>>  However, ATA_TFLAG_* are used by libata, and I think that, although
>>sharing hardware constants is good if the hardware is similar, sharing
>>driver-specific flags isn't such a good idea.  So, what do you think?
>>
>>  1. Add ATA_TFLAG_IO_16BIT to ata.h
>>  2. Make ide's own set of task flags, maybe IDE_TFLAG_* (including
>>     IDE_TFLAG_LBA48)
> 
> 
> Please add it to <ata.h> (unless Jeff complains loudly),
> I have a patch converting ide_task_t to use struct ata_taskfile
> (except ->protocol for now).

ACK


