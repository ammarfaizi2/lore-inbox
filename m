Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWATAun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWATAun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbWATAun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:50:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19873 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422707AbWATAum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:50:42 -0500
Date: Thu, 19 Jan 2006 16:49:57 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_list: Use of && instead || leads to unintended
 writing of pages
In-Reply-To: <20060119164341.0fb9c7e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601191648440.13602@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601191602260.13428@schroedinger.engr.sgi.com>
 <20060119164341.0fb9c7e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Andrew Morton wrote:

> The effects of this fix will be a) slightly improved memory allocator
> latency, b) somehat improved disk writeout patterns and c) somewhat
> increased risk of ooms.

If we do not operate in laptop mode and are not using zone_reclaim 
(!may_writepage) which is the common case then there will be no effect at 
all.

