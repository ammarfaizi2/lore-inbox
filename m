Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSGNPCo>; Sun, 14 Jul 2002 11:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSGNPCn>; Sun, 14 Jul 2002 11:02:43 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3407 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316883AbSGNPCm>; Sun, 14 Jul 2002 11:02:42 -0400
Date: Sun, 14 Jul 2002 11:05:20 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207141505.g6EF5KH16282@devserv.devel.redhat.com>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <mailman.1026651901.18426.linux-kernel2news@redhat.com>
References: <mailman.1026651901.18426.linux-kernel2news@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I will violently oppose anything that implies that the IDE layer uses the
>>SCSI layer normally.  No way, Jose. I'm all for scrapping, but the thing
>>that should be scrapped is ide-scsi.
> 
> Nobody who has a technical backgroupd and knows what to do wuld ever
> make such a proposal.
> 
> Instead, there needs to be one or more SCSI HA driver as part of the
> SCSI stack. This driver also needs to deal with plain ATA in order
> to be able to coordinate access.
> 
> Jörg

Such driver would only work with ATAPI devices. Joerg, does not
seem to realize that the vast majority of IDE devices do not
support ATAPI at all. As a rule of thumb, winchesters do not,
CD-ROMs and such do, and tapes do too. To make a pseudo-HA
driver which speaks plain IDE and plugs into SCSI subsistem
would saddle the IDE with SCSI limitations, and add one more
layer for no benefit whatsoever.

-- Pete
