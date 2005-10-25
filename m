Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVJYI1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVJYI1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 04:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVJYI1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 04:27:20 -0400
Received: from gold.veritas.com ([143.127.12.110]:9736 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932085AbVJYI1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 04:27:20 -0400
Date: Tue, 25 Oct 2005 09:26:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add notification of page becoming writable to VMA ops
In-Reply-To: <1130227159.8169.5.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0510250919270.6403@goblin.wat.veritas.com>
References: <1130168619.19518.43.camel@imp.csi.cam.ac.uk> 
 <1130167005.19518.35.camel@imp.csi.cam.ac.uk> 
 <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> 
 <7872.1130167591@warthog.cambridge.redhat.com>  <9792.1130171024@warthog.cambridge.redhat.com>
  <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com>
 <1130227159.8169.5.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Oct 2005 08:27:19.0637 (UTC) FILETIME=[EA424050:01C5D93D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2005, Anton Altaparmakov wrote:
> On Mon, 2005-10-24 at 20:11 +0100, Hugh Dickins wrote:
> 
> There really is quite a difference between mm/*.c in -mm and Linus
> kernel at present.  Is all this planned to be merged as soon as 2.6.14
> is out or is -mm just a playground for now with no mainline merge
> intentions?

It certainly won't all be merged as soon as 2.6.14 is out, some of it
has only just got into -mm.  Andrew's current intention is to merge
the early part of the changes soonish after 2.6.14 gets out, but he's
not likely to merge it all into 2.6.15.

But we aren't using -mm as a playground: it is likely to go forward,
provided it doesn't show regressions of some kind while it's in -mm.

> Just asking so I know whether to work against stock kernels or -mm for
> the moment...

I'd recommend -mm for now.  page_mkwrite will want a spell in there
too, won't it?

Hugh
