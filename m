Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbUCUDN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 22:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbUCUDN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 22:13:57 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:60551 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S262854AbUCUDN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 22:13:56 -0500
Date: Sat, 20 Mar 2004 19:13:55 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040321031355.GB3930@dingdong.cryptoapps.com>
References: <20040320133025.GH9009@dualathlon.random> <Pine.LNX.4.58.0403200937500.1106@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403200937500.1106@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 09:39:51AM -0800, Linus Torvalds wrote:

> If a driver wants to map non-RAM pages, that's perfectly ok, but it
> MUST NOT happen through "nopage()". The driver should map them with
> "remap_page_range()", and thus never take a page fault for such
> pages at all.

This is what the fetchop driver does.


