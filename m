Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751934AbWJWLgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWJWLgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWJWLgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:36:25 -0400
Received: from brick.kernel.dk ([62.242.22.158]:64023 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751934AbWJWLgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:36:25 -0400
Date: Mon, 23 Oct 2006 13:37:29 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
Message-ID: <20061023113728.GM8251@kernel.dk>
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21 2006, Martin Peschke wrote:
> This patch set makes the block layer maintain statistics for request
> queues. Resulting data closely resembles the actual I/O traffic to a
> device, as the block layer takes hints from block device drivers when a
> request is being issued as well as when it is about to complete.
> 
> It is crucial (for us) to be able to look at such kernel level data in
> case of customer situations. It allows us to determine what kind of
> requests might be involved in performance situations. This information
> helps to understand whether one faces a device issue or a Linux issue.
> Not being able to tap into performance data is regarded as a big minus
> by some enterprise customers, who are reluctant to use Linux SCSI
> support or Linux.
> 
> Statistics data includes:
> - request sizes (read + write),
> - residual bytes of partially completed requests (read + write),
> - request latencies (read + write),
> - request retries (read + write),
> - request concurrency,

Question - what part of this does blktrace currently not do? In case
it's missing something, why not add it there instead of putting new
trace code in?

-- 
Jens Axboe

