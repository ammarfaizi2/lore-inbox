Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUIOVxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUIOVxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIOVw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:52:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:13765 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267625AbUIOVvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:51:38 -0400
Date: Wed, 15 Sep 2004 14:55:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: andrea@novell.com, linux-kernel@vger.kernel.org, an.li.wang@intel.com
Subject: Re: truncate shows non zero data beyond the end of the inode with
 MAP_SHARED
Message-Id: <20040915145524.079a8694.akpm@osdl.org>
In-Reply-To: <20040915210106.GX9106@holomorphy.com>
References: <20040915122920.GA4454@dualathlon.random>
	<20040915210106.GX9106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Zeroing the final partial page during expanding truncate (flushing TLB)
> sounds like a reasonable half measure; we don't do anything at the moment.

Sure about that?  block_truncate_page() gets called.
