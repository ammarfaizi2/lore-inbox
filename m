Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264706AbUD2OcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbUD2OcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUD2OcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:32:03 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:46826 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264604AbUD2O3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:29:44 -0400
Date: Thu, 29 Apr 2004 15:24:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 18 i_mmap_nonlinear
In-Reply-To: <1083246218.1804.1.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0404291516380.5661-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Apr 2004, James Bottomley wrote:
> On Thu, 2004-04-29 at 01:10, Hugh Dickins wrote:
> > That's right, arm and parisc do handle them differently: currently
> > arm ignores i_mmap (and I think rmk was wondering a few months ago
> > whether that's actually correct, given that MAP_SHARED mappings
> > which can never become writable go in there - and that surprise is
> > itself a very good reason for combining them), and parisc... ah,
> > what it does in Linus' tree at present is about the same for both,
> > but there are some changes on the way.
> 
> Actually, as I said before, parisc is reworking the cache flushing stuff

Yes, not forgotten, that's what I meant by saying some changes on the way.

> in our tree.  As things currently stand we've altered our map allocation
> so that we now treat i_mmap no differently from i_mmap_shared, so we'd

Ah, not quite so in what you last showed me, but no matter...

> be fine with merging them.

Great, thanks.  No need for you to refresh me: if I do go ahead with
merging them (not my current priority), it'll be obvious from whatever
patch I show against -mm, what change you'd want to make to your tree.

Hugh

