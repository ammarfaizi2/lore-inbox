Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVCAOEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVCAOEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVCAOEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:04:23 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:8214 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261912AbVCAOEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:04:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jTgrq1M1rigWiiPSGk5GH5WzayFns0QiVGueUqjynj7jcR6QziGq1xlB69NA56OTb0+/wZumtf1irzkD4cDAckLNM8u6ptsemik/2ew+u6dOHepXp+byaPEEu5REtqqoaZINPGuCJMAVULUNrr2f4NEEcvnvYWT9/eRTJTDoE/s=
Message-ID: <58cb370e05030106033d43e7bb@mail.gmail.com>
Date: Tue, 1 Mar 2005 15:03:39 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Szabolcs Berecz <szabi@mplayerhq.hu>
Subject: Re: [PATCH] ide_init_disk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503011443330.26569@mail.mplayerhq.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0503011443330.26569@mail.mplayerhq.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Already fixed by Andrew in 2.6.11-rc5-mm1.

Please always cc: me and linux-ide@vger.kernel.org on IDE patches.

Thanks.

On Tue, 1 Mar 2005 14:50:18 +0100 (CET), Szabolcs Berecz
<szabi@mplayerhq.hu> wrote:
> 
> My /dev/hdb showed up as /dev/hdq
> 
> The bug was introduced with bk-ide-dev.patch
> 
> Bye,
> Szabi
> 
> --- linux-2.6.11-rc4-mm1/drivers/ide/ide-probe.c.orig   2005-02-24 20:04:03.000000000 +0100
> +++ linux-2.6.11-rc4-mm1/drivers/ide/ide-probe.c        2005-02-27 23:52:54.000000000 +0100
> @@ -1269,7 +1269,7 @@
>  void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
>  {
>         ide_hwif_t *hwif = drive->hwif;
> -       unsigned int unit = drive->select.all & (1 << 4);
> +       unsigned int unit = drive->select.b.unit;
> 
>         disk->major = hwif->major;
>         disk->first_minor = unit << PARTN_BITS;
>
