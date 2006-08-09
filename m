Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWHIRR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWHIRR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWHIRR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:17:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:32210 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751051AbWHIRR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:17:29 -0400
Subject: Re: [PATCH 3/6] unlink: monitor i_nlink
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060809171109.GC7324@infradead.org>
References: <20060809165729.FE36B262@localhost.localdomain>
	 <20060809165732.07F0AD16@localhost.localdomain>
	 <20060809171109.GC7324@infradead.org>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 10:17:19 -0700
Message-Id: <1155143839.19249.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 18:11 +0100, Christoph Hellwig wrote:
> On Wed, Aug 09, 2006 at 09:57:32AM -0700, Dave Hansen wrote:
> > 
> > When a filesystem decrements i_nlink to zero, it means that a
> > write must be performed in order to drop the inode from the
> > filesystem.
> > 
> > We're shortly going to have keep filesystems from being remounted
> > r/o between the time that this i_nlink decrement and that write
> > occurs.  
> > 
> > So, add a little helper function to do the decrements.  We'll
> > tie into it in a bit to note when i_nlink hits zero.
> > 
> > Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

> Note that we all (and especially Andrew :)) need to be carefull not to
> introduce unguarded i_nlink decrements again.  Dave, you'll probably need
> to do another audit when you introduce the real functionality.

Yup, I have my eyes on it.  git and mm commits should help as well.

-- Dave

