Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWDKFmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWDKFmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 01:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWDKFmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 01:42:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63553 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751190AbWDKFmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 01:42:37 -0400
Date: Tue, 11 Apr 2006 07:39:40 +0200
From: Jens Axboe <axboe@suse.de>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       steve.cameron@hp.com
Subject: Re: [PATCH 1/1] cciss: bug fix for crash when running hpacucli
Message-ID: <20060411053940.GJ3859@suse.de>
References: <20060410202541.GA28328@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410202541.GA28328@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10 2006, Mike Miller (OS Dev) wrote:
> PATCH 1/1
> 
> This patch fixes a crash when running hpacucli with multiple logical volumes
> on a cciss controller. We were not properly initializing the disk->queue
> and causing a fault.
> Thanks to Hasso Tepper for reporting the problem. Thanks to Steve Cameron
> for root causing the problem.
> Most of the patch just moves things around. The fix is a one-liner.
> 
> Signed-off-by: Mike Miller <mike.miller@hp.com>
> Signed-off-by: Stephen Cameron <steve.cameron@hp.com>

Thanks for nailing this one Mike! I'll add it to the upstream branch, it
should be included for 2.6.16.x as well.

-- 
Jens Axboe

