Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUCDXlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUCDXlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:41:37 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:23086 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261974AbUCDXlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:41:32 -0500
Subject: Re: [PATCH] LBD fix for 2.6.3
From: Eric Sandeen <sandeen@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LBD list <lbd@gelato.unsw.edu.au>
In-Reply-To: <20040303230452.6854c830.akpm@osdl.org>
References: <Pine.LNX.4.44.0403040001460.24142-100000@stout.americas.sgi.com>
	 <20040303230452.6854c830.akpm@osdl.org>
Content-Type: text/plain
Organization: Eric Conspiracy Secret Labs
Message-Id: <1078443681.25762.30.camel@stout.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Mar 2004 17:41:22 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-04 at 01:04, Andrew Morton wrote:
> Actually, there more instances of this bug in buffer.c.

Another one, I think, unless I've missed something...


--- fs/buffer.c_1.3     2004-03-04 17:38:49.000000000 -0600
+++ fs/buffer.c 2004-03-04 17:37:13.000000000 -0600
@@ -1093,7 +1093,7 @@
  */
 static void
 init_page_buffers(struct page *page, struct block_device *bdev,
-                       int block, int size)
+                       sector_t block, int size)
 {
        struct buffer_head *head = page_buffers(page);
        struct buffer_head *bh = head;

-- 
Eric Sandeen      [C]XFS for Linux   http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.          651-683-3102

