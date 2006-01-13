Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422714AbWAMPrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbWAMPrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWAMPrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:47:05 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:59319 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422714AbWAMPrE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:47:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VDWh9ZMSlT433bHkecfi+ObteKdYgbqT/cZ86binFgSKh9WLm3HC6HfQpi+WUF08ZD4At7ce1q5mdJmBfQLNX7ai0ztJdvLwcXxWhWhvC0xKQVYyoFthkPlpFLcwh4eyoXF2zFABHMec3w/FVWILswo0z6X1Qm+MvsX5JOGc3bQ=
Message-ID: <58cb370e0601130747x452fca8dr798c1372b78e58b4@mail.gmail.com>
Date: Fri, 13 Jan 2006 16:47:01 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
Cc: axboe@suse.de, rmk@arm.linux.org.uk, james.steward@dynamicratings.com,
       jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11371658562541-git-send-email-htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Tejun Heo <htejun@gmail.com> wrote:
> Hello, all.
>
> This patchset tries to fix data corruption bug caused by not handling
> cache coherency during block PIO.  This patch implements
> blk_kmap/unmap helpers which take extra @dir argument and perform
> appropriate coherency actions.  These are to block PIO what dma_map/
> unmap are to block DMA transfers.
>
> IDE, libata, SCSI, rd and md are converted.  Still left are nbd, loop
> and pktcddvd.  If I missed something, please let me know.
>
> Russell, can you please test whether this fixes the bug on arm?  If
> this fixes the bug and people agree with the approach, I'll follow up
> with patches for yet unconverted drivers and documentation update.

Looks fine, if it works you can add Acked-by: to the IDE patch.

Thanks!
Bartlomiej
