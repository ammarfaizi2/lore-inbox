Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTIHQJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTIHQJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:09:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53918 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262665AbTIHQJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:09:33 -0400
Date: Mon, 8 Sep 2003 18:09:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jdike@addtoit.com
Subject: Re: Fix noop elevator request merging (in current 2.5 bk)
Message-ID: <20030908160939.GA31932@suse.de>
References: <20030908152915.GA29554@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908152915.GA29554@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08 2003, Oleg Drokin wrote:
> Hello!
> 
>    This patch is required otherwise in case if elv_try_last_merge
>    returns nonzero, we do not initialise *req, and subsequent BUG_ON()
>    in __make_request() will dies because req is NULL (or is just
>    uninitialised).  This stopped my UBD devices to work, that's how I
>    noticed ;)

Thanks, patch looks good.

-- 
Jens Axboe

