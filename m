Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269313AbUJEPlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269313AbUJEPlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269301AbUJEPlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:41:04 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:40199 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269150AbUJEPhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:37:34 -0400
Date: Tue, 5 Oct 2004 16:37:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
Message-ID: <20041005163730.A19554@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20041005142001.GR2433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041005142001.GR2433@suse.de>; from axboe@suse.de on Tue, Oct 05, 2004 at 04:20:01PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 04:20:01PM +0200, Jens Axboe wrote:
> Hi,
> 
> The blacklist stuff is broken. When set_using_dma() calls into
> ide_dma_check(), it returns ide_dma_off() for a blacklisted drive. This
> of course succeeds, returning success to the caller of ide_dma_check().
> Not so good... It then uncondtionally calls ide_dma_on(), which turns on
> dma for the drive.
> 
> This moves the check to ide_dma_on() so we also catch the buggy
> ->ide_dma_check() defined by various chipset drivers.

Is this a bug introduced in the 2.6.9ish IDE changes or has it been there
for a longer time? 
