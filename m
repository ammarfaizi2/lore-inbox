Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbWH2Rvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbWH2Rvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWH2Rvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:51:36 -0400
Received: from brick.kernel.dk ([62.242.22.158]:50504 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965185AbWH2Rvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:51:36 -0400
Date: Tue, 29 Aug 2006 19:54:21 +0200
From: Jens Axboe <axboe@kernel.dk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] BLOCK: Permit block layer to be disabled [try #5]
Message-ID: <20060829175421.GS12257@kernel.dk>
References: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29 2006, David Howells wrote:
> 
> This set of patches permits the block layer to be disabled and removed from
> the compilation such that it doesn't take up any resources on systems that
> don't need it.
> 
> This set of patches is against the block git tree.
> 
> Changes in [try #5]:
> 
>  (*) Update to block GIT tree for 2.6.18-rc5.
> 
>  (*) Make USB_STORAGE depend on SCSI rather than selecting it.
> 
>  (*) Remove dependencies on BLOCK where there are also dependencies on SCSI.

Any remaining changes? Looks fine to me, although I wonder why you did
not kill the block_sync_page() completely in AFS. Christophs analysis
looked correct to me.

-- 
Jens Axboe

