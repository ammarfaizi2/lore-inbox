Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266630AbUHBQza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbUHBQza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUHBQza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:55:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34502 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266630AbUHBQz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:55:26 -0400
Date: Mon, 2 Aug 2004 17:12:35 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christoph Hellwig <hch@infradead.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, dipankar@in.ibm.com
Subject: Re: [patchset] Lockfree fd lookup 1 of 5
Message-ID: <20040802161235.GM12308@parcelfarce.linux.theplanet.co.uk>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802101350.GC4385@vitalstatistix.in.ibm.com> <20040802143825.A5073@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802143825.A5073@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 02:38:25PM +0100, Christoph Hellwig wrote:
> On Mon, Aug 02, 2004 at 03:43:52PM +0530, Ravikiran G Thirumalai wrote:
> > Here's the first patch.  This patch 'shrinks' struct kref by removing
> > the release pointer in the struct kref.  GregKH has applied this to his tree
> 
> What's the advantage of this kref API over opencoded atomic_t usage?

More interesting question is how much does it win compared to simple
switch to rwlock?
