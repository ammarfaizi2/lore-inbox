Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUJSBKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUJSBKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUJSBKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:10:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51599 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268236AbUJSBJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:09:38 -0400
Subject: Re: [PATCH 1/3] ext3 reservation remove stale window fix
From: Mingming Cao <cmm@us.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, "Stephen C. Tweedie" <sct@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20041018234126.GB28904@waste.org>
References: <1098140107.8803.1062.camel@w-ming2.beaverton.ibm.com> 
	<20041018234126.GB28904@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2004 18:11:16 -0700
Message-Id: <1098148283.9754.1090.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 16:41, Matt Mackall wrote:
> On Mon, Oct 18, 2004 at 03:55:04PM -0700, Mingming Cao wrote:
> > 
> > Before we changed the per-filesystem reservations from a linked list
> > to a red-black tree, in order to speed up the linear search from the
> > list head, we keep the current(stale) reservation window as a
> > reference pointer to skip the nodes prior to the current/stale
> > window node, when failed to allocate a new window in current group
> > and try to do allocation in next group.
> 
> One wonders whether a prio tree of the sort used by the current VMA
> searching code would be a better match to the problem than the
> red-black approach.

Could you please elaborate more? I think the current VMA code is using
red-black tree in their searching code(find_vma()).

