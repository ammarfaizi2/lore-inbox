Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVCHHTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVCHHTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVCHHTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 02:19:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:49339 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261836AbVCHHRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 02:17:14 -0500
Date: Tue, 8 Mar 2005 12:56:50 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sct@redhat.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-ID: <20050308072650.GA3998@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050304160451.4c33919c.akpm@osdl.org> <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk> <20050307123118.3a946bc8.akpm@osdl.org> <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk> <20050307131113.0fd7477e.akpm@osdl.org> <1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk> <1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk> <20050307155001.099352b5.akpm@osdl.org> <20050308062827.GA3756@in.ibm.com> <20050307224618.1cae3425.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307224618.1cae3425.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 10:46:18PM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > 
> > yup, looks like the same issue we hit in wait_on_page_writeback_range 
> > during AIO work  - probably want to break out of the outer loop as well
> > when this happens.
> 
> The `next = page_index' before breaking will do that for us.
> 
> > 
> > How hard would it be to add an end_index parameter to the radix tree
> > lookup, since we seem to be hitting this in multiple places ?
> 
> Really easy if you do it ;)
> 
> Let's wait for this particular peiece of code to settle down, do a cleanup
> sometime?
> 

OK - we can postpone this (let me know if the interface in the patch
I just posted seems like the right direction to use when we go for the
cleanup).

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

