Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbTEMXOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbTEMXOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:14:34 -0400
Received: from holomorphy.com ([66.224.33.161]:14526 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263789AbTEMXOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:14:33 -0400
Date: Tue, 13 May 2003 16:26:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zach Brown <zab@zabbo.net>
Cc: Andrew Morton <akpm@digeo.com>, paulmck@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mjbligh@us.ibm.com
Subject: Re: [RFC][PATCH] Interface to invalidate regions of mmaps
Message-ID: <20030513232659.GC8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zach Brown <zab@zabbo.net>, Andrew Morton <akpm@digeo.com>,
	paulmck@us.ibm.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mjbligh@us.ibm.com
References: <20030513133636.C2929@us.ibm.com> <20030513152141.5ab69f07.akpm@digeo.com> <3EC17BA3.7060403@zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC17BA3.7060403@zabbo.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 04:11:31PM -0700, Zach Brown wrote:
> but on the other hand, this doesn't solve another problem we have with
> opportunistic lock extents and sparse page cache populations.  Ideally
> we'd like a FS specific pointer in struct page so we can associate pages
> in the cache with a lock, but I can't imagine suggesting such a thing
> within earshot of wli.  so we'd still have to track the dirty offsets to
> avoid having to pass through offsets 0 ... i_size only to find that one
> page in the 8T file that was cached.

Nah, don't worry about sizeof(struct page) anymore; I'll just jack up
PAGE_SIZE to compensate.


-- wli
