Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVAHJix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVAHJix (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVAHJiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:38:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:65226 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262003AbVAHJGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:06:34 -0500
Date: Sat, 8 Jan 2005 01:06:30 -0800
From: Chris Wright <chrisw@osdl.org>
To: clameter@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: panic on bootup due to __GFP_ZERO patch
Message-ID: <20050108010629.M469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a panic during pidmap_init with a backtrace that looks
something like:

buffered_rmqueue
__alloc_pages
get_zeroed_page
pidmap_init
start_kernel

Reverting the __GFP_ZERO patch fixes the issue, haven't drilled down
any deeper yet to see what in the patch is causing the problem.  This is
x86 w/out HIGHMEM (and no NUMA).

Any ideas?

thanks,
-chris
