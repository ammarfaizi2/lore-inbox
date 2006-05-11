Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWEKPVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWEKPVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWEKPVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:21:44 -0400
Received: from [81.2.110.250] ([81.2.110.250]:49106 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030247AbWEKPVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:21:43 -0400
Subject: Re: [RFC] Hugetlb demotion for x86
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Adam Litke <agl@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       linux-mm@kvack.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605111607250.24407@blonde.wat.veritas.com>
References: <1147287400.24029.81.camel@localhost.localdomain>
	 <20060510200516.GA30346@infradead.org>
	 <1147293156.24029.95.camel@localhost.localdomain>
	 <20060510204928.GA31315@infradead.org>
	 <1147297535.24029.114.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605111607250.24407@blonde.wat.veritas.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 16:33:49 +0100
Message-Id: <1147361629.26130.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-11 at 16:15 +0100, Hugh Dickins wrote:
> > For one: an application using lots of private huge pages should not be
> > prohibited from forking if it's likely to just exec a small helper
> > program.
> 
> This is an excellent use for madvise(start, length, MADV_DONTFORK).
> Though it was added mainly for RDMA issues, it's a great way for a
> program with a huge commitment to exclude areas of its address space
> from the fork, so making that fork much more likely to succeed.

Or fork using vfork() in that case which has even more wins and is a
more efficient if more hair-raising way of doing it

