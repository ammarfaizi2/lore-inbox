Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWH3VVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWH3VVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWH3VVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:21:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932073AbWH3VVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:21:09 -0400
Date: Wed, 30 Aug 2006 14:20:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] BLOCK: Make it possible to disable the block
 layer [try #6]
Message-Id: <20060830142045.c87f341e.akpm@osdl.org>
In-Reply-To: <1156971999.5787.12.camel@localhost>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
	<20060829180634.32596.4507.stgit@warthog.cambridge.redhat.com>
	<20060830124400.23ca9b38.akpm@osdl.org>
	<1156971999.5787.12.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 17:06:39 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > This function is misnamed and is implemented in the wrong place.  It's not
> > really a block thing at all.  If/when/soon NFS starts to implement it and
> > call it, things will need to be renamed and reshuffled.
> 
> Already done in the NFS git tree. See attached patch.

Right, I saw that, didn't know that you'd merged it yet.  Ho hum, yet
another reject to fix up.

I think your patch is a bit minimal: at adds blk_congestion_end() whereas
it'd make better sense longer-term to remove blk_congestion_wait() and
blk_congestion_end() altogether, replace them with something which is
somewhere else and which doesn't mention "blk".  I expected this to be done
four years ago ;)

But not now.  Nobody's allowed to touch anything else!
