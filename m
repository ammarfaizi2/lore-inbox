Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUIATtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUIATtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUIATrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:47:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58759 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267445AbUIAToe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:44:34 -0400
Date: Wed, 1 Sep 2004 12:43:25 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Christoph Hellwig <hch@infradead.org>, lkml@lpbproductions.com,
       Timothy Miller <miller@techsource.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 3ware queue depth [was: Re: HIGHMEM4G config for 1GB RAM on desktop?]
Message-ID: <20040901194325.GA11762@beaverton.ibm.com>
References: <200408021602.34320.swsnyder@insightbb.com> <1094030083l.3189l.2l@traveler> <1094030194l.3189l.3l@traveler> <200409010233.31643.lkml@lpbproductions.com> <1094032735l.3189l.7l@traveler> <20040901110944.A10160@infradead.org> <1094036919l.3189l.11l@traveler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094036919l.3189l.11l@traveler>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 11:08:39AM +0000, Miquel van Smoorenburg wrote:

> +	/* make sure blockdev queue depth is at least 2 * scsi depth */
> +	if (SDptr->request_queue->nr_requests < 2 * max_cmds)
> +		SDptr->request_queue->nr_requests = 2 * max_cmds;

Why would you want nr_requests different (and larger) only for this
driver?

Is modifying nr_requests allowed?

-- Patrick Mansfield
