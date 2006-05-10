Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWEJUcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWEJUcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWEJUcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:32:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5268 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932497AbWEJUcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:32:43 -0400
Subject: Re: [RFC] Hugetlb demotion for x86
From: Adam Litke <agl@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060510200516.GA30346@infradead.org>
References: <1147287400.24029.81.camel@localhost.localdomain>
	 <20060510200516.GA30346@infradead.org>
Content-Type: text/plain
Organization: IBM
Date: Wed, 10 May 2006 15:32:36 -0500
Message-Id: <1147293156.24029.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 21:05 +0100, Christoph Hellwig wrote:
> On Wed, May 10, 2006 at 01:56:40PM -0500, Adam Litke wrote:
> > The following patch enables demotion of MAP_PRIVATE hugetlb memory to
> > normal anonymous memory on the i386 architecture.
> 
> This is an awfully bad idea.  Applications should do smart fallback
> instead.  For the same reason we for example fail O_DIRECT requests
> we can fullfill instead of doing the half buffered I/O braindamage
> solaris does.

By smart fallback do you mean we should convert the hugetlb fault code
back to using VM_FAULT_SIGBUS and writing userspace sighandlers to do
the same thing I am, but in userspace?  FWIW I did implement that in
libhugetlbfs to try it out, but that seems much dirtier to me than
handling faults in the kernel.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

