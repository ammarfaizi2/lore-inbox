Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTEYQPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 12:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTEYQPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 12:15:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40100 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263455AbTEYQPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 12:15:31 -0400
Date: Sun, 25 May 2003 18:28:44 +0200
From: Jens Axboe <axboe@suse.de>
To: "Paulo Andre'" <fscked@iol.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Check copy_*_user return value in drivers/block/scsi_ioctl.c
Message-ID: <20030525162844.GJ812@suse.de>
References: <20030525172549.7df834f9.fscked@iol.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525172549.7df834f9.fscked@iol.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25 2003, Paulo Andre' wrote:
> Hi Jens,
> 
> Please find attached a trivial patch that checks both
> copy_to_user() and copy_from_user() returns values in scsi_ioctl.c,
> returning accordinly in case of a transfer error.

See above, we've already done access_ok() on the buffer so the
"unchecked" copy_to/from_user are done that way on purpose. I suppose it
could be made more explicit with __copy_to/from_user().

-- 
Jens Axboe

