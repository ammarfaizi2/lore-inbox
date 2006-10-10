Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWJJJh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWJJJh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbWJJJh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:37:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5087 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030180AbWJJJhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:37:25 -0400
Date: Tue, 10 Oct 2006 10:37:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SCSI sd: fix module init/exit error handling
Message-ID: <20061010093706.GJ395@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jeff@garzik.org>, linux-scsi@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20061004093254.GA15585@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004093254.GA15585@havoc.gtf.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 05:32:54AM -0400, Jeff Garzik wrote:
> 
> - Properly handle and unwind errors in init_sd().  Fixes leaks on error,
>   if class_register() or scsi_register_driver() failed.
> 
> - Ensure that exit_sd() execution order is the perfect inverse of
>   initialization order.
> 
> FIXME:  If some-but-not-all register_blkdev() calls fail, we wind up
> calling unregister_blkdev() for block devices we did not register.
> This was a pre-existing bug.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

Ok.

