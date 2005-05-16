Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVEPUro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVEPUro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVEPUrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:47:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35743 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261865AbVEPUrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:47:36 -0400
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in
	node memory alignment
From: Dave Hansen <haveblue@us.ibm.com>
To: christoph <christoph@scalex86.org>
Cc: linux-mm <linux-mm@kvack.org>, shai@scalex86.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505161240240.13692@ScMPusgw>
References: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw>
	 <1116274451.1005.106.camel@localhost>
	 <Pine.LNX.4.62.0505161240240.13692@ScMPusgw>
Content-Type: text/plain
Date: Mon, 16 May 2005 13:47:19 -0700
Message-Id: <1116276439.1005.110.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 12:43 -0700, christoph wrote:
> On Mon, 16 May 2005, Dave Hansen wrote:
> > On Mon, 2005-05-16 at 12:05 -0700, christoph wrote:
> > > Memory for nodes on i386 is currently aligned on 2 MB boundaries.
> > > However, the buddy allocator needs pages to be aligned on
> > > PAGE_SIZE << MAX_ORDER which is 8MB if MAX_ORDER = 11.
> > 
> > Why do you need this?  Are you planning on allowing NUMA KVA remap pages
> > to be handed over to the buddy allocator?  That would be a major
> > departure from what we do now, and I'd be very interested in seeing how
> > that is implemented before a infrastructure for it goes in.
> 
> Because the buddy allocator is complaining about wrongly allocated zones!

Just because it complains doesn't mean that anything is actually
wrong :)

Do you know which pieces of code actually break if the alignment doesn't
meet what that warning says?

-- Dave

