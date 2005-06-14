Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFNFWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFNFWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 01:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVFNFWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 01:22:35 -0400
Received: from holomorphy.com ([66.93.40.71]:45543 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261151AbVFNFWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 01:22:33 -0400
Date: Mon, 13 Jun 2005 22:22:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: li nux <lnxluv@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: rmap.c: try_to_unmap_file(): VM_LOCKED not respected
Message-ID: <20050614052219.GH3879@holomorphy.com>
References: <20050614051405.42342.qmail@web33307.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614051405.42342.qmail@web33307.mail.mud.yahoo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 10:14:05PM -0700, li nux wrote:
> My application is using remap_file_pages and mlocks
> those pages.
> So in the code of  try_to_unmap_file (see below),
> I should never reach the call to try_to_unmap_cluster,
> because for those pages VM_LOCKED is always set.
> But, under heavy load I am seeing try_to_unmap_cluster
> is getting called. Stack:

Does your app use remap_file_pages() before mlock()?

If so, the VM may be trying to reclaim pages between the call to
remap_file_pages() and the call to mlock().


-- wli
