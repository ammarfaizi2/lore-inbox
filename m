Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbUBEFTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 00:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUBEFTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 00:19:12 -0500
Received: from web9704.mail.yahoo.com ([216.136.129.140]:32131 "HELO
	web9704.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264472AbUBEFTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 00:19:06 -0500
Message-ID: <20040205051905.19684.qmail@web9704.mail.yahoo.com>
Date: Wed, 4 Feb 2004 21:19:05 -0800 (PST)
From: Alok Mooley <rangdi@yahoo.com>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <1075924593.27981.458.camel@nighthawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Dave Hansen <haveblue@us.ibm.com> wrote:
> On Wed, 2004-02-04 at 10:54, Alok Mooley wrote:
> > --- Dave Hansen <haveblue@us.ibm.com> wrote:
> Depending on the quantity of work that you're trying
> to do at once, this
> might be unavoidable.  
> 
> I know it's a difficult thing to think about, but I
> still don't
> understand the precise cases that you're concerned
> about.  Page faults
> to me seem like the least of your problems.  A
> bigger issue would be if
> the page is written to by userspace after you copy,
> but before you
> install the new pte.  Did I miss the code in your
> patch that invalidated
> the old tlb entries?

This is a non issue for us right now, since we update
the ptes in a lock, & so no one can access it before
it is completely updated. Yes, we invalidate the old
tlb entries as well as the cache entries as reqd. on
some other architectures.

-Alok


__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
