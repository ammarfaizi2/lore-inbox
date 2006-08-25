Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWHYMN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWHYMN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 08:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWHYMN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 08:13:56 -0400
Received: from brick.kernel.dk ([62.242.22.158]:572 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751171AbWHYMNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 08:13:55 -0400
Date: Fri, 25 Aug 2006 14:16:21 +0200
From: Jens Axboe <axboe@kernel.dk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060825121621.GA24258@kernel.dk>
References: <32640.1156424442@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32640.1156424442@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24 2006, David Howells wrote:
> 
> Make it possible to disable the block layer.  Not all embedded devices require
> it, some can make do with just JFFS2, NFS, ramfs, etc - none of which require
> the block layer to be present.

Overall, this looks good. It's definitely something that has been talked
about for years (off and on), but nobody ever did. So thanks David!

When you respin this patch, care to do it against the 'block' branch of
the git block repo?

>      (*) The SCSI layer.  As far as I can tell, even SCSI chardevs use the
>      	 block layer to do scheduling.

SCSI uses the queue as the transport even for char devices, so yes you
have to leave all of SCSI behind.

-- 
Jens Axboe

