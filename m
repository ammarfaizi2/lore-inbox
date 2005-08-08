Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVHHPxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVHHPxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVHHPxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:53:10 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:29088 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932093AbVHHPxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:53:09 -0400
Date: Mon, 8 Aug 2005 16:52:52 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: How to reclaim inode pages on demand
Message-ID: <Pine.LNX.4.58.0508081650160.26013@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a direct reclaim strategy to free up large blocks of
contiguous pages. The part I have is working fine, but I am finding a
hundreds of pages that are being used for inodes that I need to reclaim. I
tried purging the inode lists using a variation of prune_icache() but it
is not working out.

Given a struct page, that one knows is an inode, can anyone suggest the
best way to find the inode using it and free it?

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
