Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbUJ1QCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbUJ1QCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUJ1P7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:59:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25818 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261742AbUJ1Puh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:50:37 -0400
Date: Thu, 28 Oct 2004 08:49:34 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: NUMA node swapping V3
In-Reply-To: <1275120000.1098978003@[10.10.2.4]>
Message-ID: <Pine.LNX.4.58.0410280845520.25586@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0410280820500.25586@schroedinger.engr.sgi.com>
 <1275120000.1098978003@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Martin J. Bligh wrote:

> I thought even the SGI people were saying this wouldn't actually help you,
> due to some workload issues?

Our tests show that this does indeed address the issue. There may still be
some off node allocation while kswapd is starting up which causes some
objections but avoiding these would mean significant modifications to
__alloc_pages. This is a fix until a better solution can be found which I
would estimate to be 3-6 months down the road given the difficulties
getting vm changes into the kernel.
