Return-Path: <linux-kernel-owner+w=401wt.eu-S1423009AbWLUSWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423009AbWLUSWl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423011AbWLUSWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:22:41 -0500
Received: from brick.kernel.dk ([62.242.22.158]:19066 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423009AbWLUSWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:22:41 -0500
Date: Thu, 21 Dec 2006 19:24:32 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: device-mapper development <dm-devel@redhat.com>, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, agk@redhat.com
Subject: Re: [dm-devel] Re: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request()  to be called from interrupt context
Message-ID: <20061221182432.GB17199@kernel.dk>
References: <20061220134848.GF10535@kernel.dk> <20061220.125002.71083198.k-ueda@ct.jp.nec.com> <20061220184917.GJ10535@kernel.dk> <20061220.165549.39151582.k-ueda@ct.jp.nec.com> <20061221075305.GD17199@kernel.dk> <458ACB69.8000603@cs.wisc.edu> <458ACEB1.3030406@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458ACEB1.3030406@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21 2006, Mike Christie wrote:
> Or the block layer code could set up the clone too. elv_next_request
> could prep a clone based on the orignal request for the driver then dm
> would not have to worry about that part.

It really can't, since it doesn't know how to allocate the clone
request. I'd rather export this functionality as helpers.

-- 
Jens Axboe

