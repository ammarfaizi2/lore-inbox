Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWFLQnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWFLQnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWFLQnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:43:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22154 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751393AbWFLQnZ (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:43:25 -0400
Date: Mon, 12 Jun 2006 09:43:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of
 physical pages backing it
In-Reply-To: <1149903235.31417.84.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0606120941500.19214@schroedinger.engr.sgi.com>
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Rohit Seth wrote:

> There is currently /proc/<pid>/smaps that prints the detailed
> information about the usage of physical pages but that is a very
> expensive operation as it traverses all the PTs (for some one who is
> just interested in getting that data for each vma).

Adding a new counter to a vma may cause a bouncing cacheline etc. I 
would think that such a counter is far more expensive than occasional 
scans through the page table because someone is curious about the 
number of page in use. /proc/<pid>/numa_maps also uses these scans to 
determine dirty pages etc.


