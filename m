Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbVLWCgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVLWCgI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVLWCgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:36:07 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:16997 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S1030383AbVLWCgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:36:06 -0500
Date: Fri, 23 Dec 2005 03:36:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: nfs invalidates lose pte dirty bits
Message-ID: <20051223023603.GY9576@opteron.random>
References: <20051222175550.GT9576@opteron.random> <1135294250.3685.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135294250.3685.16.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 06:30:49PM -0500, Trond Myklebust wrote:
> See the latest git release where we introduce the nfs_sync_mapping()
> helper.

So you also still break completely with threaded programs, did you
consider that while fixing the most obvious problem? Isn't that a
problem too? What about my suggestion of invalidate_inode_clean_pages?

Still I wonder if messing with ptes for invalidates is worth it.
