Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUCXIae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 03:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbUCXIae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 03:30:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41601 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263104AbUCXI3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 03:29:48 -0500
Date: Wed, 24 Mar 2004 09:29:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] catch error when completing bio pairs
Message-ID: <20040324082945.GF3377@suse.de>
References: <405FE501.6030704@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405FE501.6030704@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22 2004, Mike Christie wrote:
> A couple of drivers can sometimes fail the first
> segments in a bio then requeue the rest of the request. In this
> situation, if the last part of the bio completes successfully
> bio_pair_end_* will miss that the beginging of the bio had
> failed becuase they just return one when bi_size is not yet
> zero. The attached patch moves the error value test before
> the bi_size to catch the above case.

Yup that's a bug, patch is correct.

-- 
Jens Axboe

