Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbUDZUim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUDZUim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbUDZUim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:38:42 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:59281 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263185AbUDZUik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:38:40 -0400
Subject: Re: [PATCH 6/11] nfsacl-lazy-alloc
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1082975192.3295.76.camel@winden.suse.de>
References: <1082975192.3295.76.camel@winden.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083011918.15282.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 16:38:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 06:28, Andreas Gruenbacher wrote:
> Allow to allocate pages in the receive buffers lazily
> 
> Patch from Olaf Kirch <okir@suse.de>: Replies to the GETACL remote
> procedure call can become quite big, yet in the common case replies will
> be very small.  This patch checks of argument pages have already been
> allocated, and allocates pages up to the maximum length of the xdr_buf
> when this is not the case.

AFAICS, there is nothing to stop xdr_partial_copy_from_skb() from
writing beyond the end of xdr->pages[]. How do you propose to prevent
this?

Cheers,
  Trond
