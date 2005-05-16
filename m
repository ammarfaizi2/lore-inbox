Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVEPU5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVEPU5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVEPU5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:57:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:24292 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261873AbVEPU5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:57:15 -0400
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in
	node memory alignment
From: Dave Hansen <haveblue@us.ibm.com>
To: christoph <christoph@scalex86.org>
Cc: linux-mm <linux-mm@kvack.org>, shai@scalex86.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505161253090.20839@ScMPusgw>
References: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw>
	 <1116274451.1005.106.camel@localhost>
	 <Pine.LNX.4.62.0505161240240.13692@ScMPusgw>
	 <1116276439.1005.110.camel@localhost>
	 <Pine.LNX.4.62.0505161253090.20839@ScMPusgw>
Content-Type: text/plain
Date: Mon, 16 May 2005 13:56:54 -0700
Message-Id: <1116277014.1005.113.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 12:55 -0700, christoph wrote:
> On Mon, 16 May 2005, Dave Hansen wrote:
> > > Because the buddy allocator is complaining about wrongly allocated zones!
> > 
> > Just because it complains doesn't mean that anything is actually
> > wrong :)
> > 
> > Do you know which pieces of code actually break if the alignment doesn't
> > meet what that warning says?
> 
> I have seen nothing break but 4 MB allocations f.e. will not be allocated 
> on a 4MB boundary with a 2 MB zone alignment. The page allocator always 
> returnes properly aligned pages but 4MB allocations are an exception? 

I wasn't aware there was an alignment exception in the allocator for 4MB
pages.  Could you provide some examples?

-- Dave

