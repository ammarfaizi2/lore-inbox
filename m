Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVAGT11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVAGT11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVAGT0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:26:03 -0500
Received: from peabody.ximian.com ([130.57.169.10]:27042 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261547AbVAGTZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:25:42 -0500
Subject: Re: [RFC] per thread page reservation patch
From: Robert Love <rml@novell.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Vladimir Saveliev <vs@namesys.com>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050107190545.GA13898@infradead.org>
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	 <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>
	 <1105019521.7074.79.camel@tribesman.namesys.com>
	 <20050107144644.GA9606@infradead.org>
	 <1105118217.3616.171.camel@tribesman.namesys.com>
	 <20050107190545.GA13898@infradead.org>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 14:21:16 -0500
Message-Id: <1105125676.9311.27.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 19:05 +0000, Christoph Hellwig wrote:

> int perthread_pages_reserve(int nrpages, int gfp)
> {
> 	LIST_HEAD(accumulator);
> 	int i;
> 
> 	list_splice_init(&current->private_pages, &accumulator);
> 
> Now the big question is, what's synchronizing access to
> current->private_pages?

Safe without locks so long as there is no other way to get at another
process's private_pages. ;)

Best,

	Robert Love


