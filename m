Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWAQPCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWAQPCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWAQPCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:02:24 -0500
Received: from mail.dvmed.net ([216.237.124.58]:45995 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751157AbWAQPAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:00:32 -0500
Message-ID: <43CD0679.4070202@pobox.com>
Date: Tue, 17 Jan 2006 10:00:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
References: <11371658562541-git-send-email-htejun@gmail.com>
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tejun Heo wrote: > Hello, all. > > This patchset tries
	to fix data corruption bug caused by not handling > cache coherency
	during block PIO. This patch implements > blk_kmap/unmap helpers which
	take extra @dir argument and perform > appropriate coherency actions.
	These are to block PIO what dma_map/ > unmap are to block DMA
	transfers. > > IDE, libata, SCSI, rd and md are converted. Still left
	are nbd, loop > and pktcddvd. If I missed something, please let me
	know. > > Russell, can you please test whether this fixes the bug on
	arm? If > this fixes the bug and people agree with the approach, I'll
	follow up > with patches for yet unconverted drivers and documentation
	update. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
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

I ACK the libata portions, but I will let others ACK the overall 
patchset goal (hopefully the arch people).

	Jeff



