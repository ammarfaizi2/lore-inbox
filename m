Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVB1QMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVB1QMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVB1QMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:12:42 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:24472 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261670AbVB1QMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:12:34 -0500
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy + prezeroing
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050227134219.B4346ECE4@skynet.csn.ul.ie>
References: <20050227134219.B4346ECE4@skynet.csn.ul.ie>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 08:12:07 -0800
Message-Id: <1109607127.6921.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-27 at 13:42 +0000, Mel Gorman wrote:
> In the two following emails are the latest version of the placement policy
> for the binary buddy allocator to reduce fragmentation and the prezeroing
> patch. The changelogs are with the patches although the most significant change
> to the placement policy is a fix for a bug in the usemap size calculation
> (pointed out by Mike Kravetz). 
> 
> The placement policy is Even Better than previous versions and can allocate
> over 100 2**10 blocks of pages under loads in excess of 30 so I still
> consider it ready for inclusion to the mainline.
...

This patch does some important things for memory hotplug: it explicitly
marks the different types of kernel allocations, and it separates those
different types in the allocator.  When it comes to memory hot-remove
this is certainly something we were going to have to do anyway.  Plus, I
believe there are already at least two prototype patches that do this.  

Anything that makes future memory hotplug work easier is good in my
book. :)

-- Dave

