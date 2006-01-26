Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWAZR5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWAZR5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 12:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWAZR5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 12:57:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49610 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932375AbWAZR5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 12:57:53 -0500
Date: Thu, 26 Jan 2006 09:57:45 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 0/9] Critical Mempools
In-Reply-To: <1138217992.2092.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com>
References: <1138217992.2092.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2006, Matthew Dobson wrote:

> Using this new approach, a subsystem can create a mempool and then pass a
> pointer to this mempool on to all its slab allocations.  Anytime one of its
> slab allocations needs to allocate memory that memory will be allocated
> through the specified mempool, rather than through alloc_pages_node() directly.

All subsystems will now get more complicated by having to add this 
emergency functionality?

> Feedback on these patches (against 2.6.16-rc1) would be greatly appreciated.

There surely must be a better way than revising all subsystems for 
critical allocations.
