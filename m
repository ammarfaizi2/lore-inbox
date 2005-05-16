Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVEPUyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVEPUyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVEPUyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:54:14 -0400
Received: from serv01.siteground.net ([70.85.91.68]:62114 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261879AbVEPUxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:53:50 -0400
Date: Mon, 16 May 2005 12:55:39 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-mm <linux-mm@kvack.org>, shai@scalex86.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in node
 memory alignment
In-Reply-To: <1116276439.1005.110.camel@localhost>
Message-ID: <Pine.LNX.4.62.0505161253090.20839@ScMPusgw>
References: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw> 
 <1116274451.1005.106.camel@localhost>  <Pine.LNX.4.62.0505161240240.13692@ScMPusgw>
 <1116276439.1005.110.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Dave Hansen wrote:

> > Because the buddy allocator is complaining about wrongly allocated zones!
> 
> Just because it complains doesn't mean that anything is actually
> wrong :)
> 
> Do you know which pieces of code actually break if the alignment doesn't
> meet what that warning says?

I have seen nothing break but 4 MB allocations f.e. will not be allocated 
on a 4MB boundary with a 2 MB zone alignment. The page allocator always 
returnes properly aligned pages but 4MB allocations are an exception? 

Some present or future hardware device or some other code may find that 
surprising and crash.
