Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVA1GyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVA1GyW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 01:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVA1GyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 01:54:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20908 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261487AbVA1GyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 01:54:16 -0500
Date: Fri, 28 Jan 2005 07:54:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@maxeymade.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/sata write barrier support
Message-ID: <20050128065358.GA4800@suse.de>
References: <200501272242.j0RMgoP5016154@falcon30.maxeymade.com> <41F97299.2070909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F97299.2070909@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27 2005, Jeff Garzik wrote:
> Doug Maxey wrote:
> >On Thu, 27 Jan 2005 13:02:48 +0100, Jens Axboe wrote:
> >
> >>Hi,
> >>
> >>For the longest time, only the old PATA drivers supported barrier writes
> >>with journalled file systems. This patch adds support for the same type
> >>of cache flushing barriers that PATA uses for SCSI, to be utilized with
> >>libata. 
> >
> >
> >What, if any mechanism supports changing the underlying write cache?  
> >
> >That is, assuming this is common across PATA and SCSI drives, and it is 
> >possible to turn the cache off on the IDE drives, would switching the 
> >cache underneath require completing the inflight IO?
> 
> [ignoring your question, but it made me think...]
> 
> 
> I am thinking the barrier support should know if the write cache is 
> disabled (some datacenters do this), and avoid flushing if so?

Ehm it does, read the code :)

-- 
Jens Axboe

