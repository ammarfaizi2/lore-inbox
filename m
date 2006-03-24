Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWCXVjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWCXVjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWCXVjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:39:10 -0500
Received: from THUNK.ORG ([69.25.196.29]:28133 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750758AbWCXVjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:39:09 -0500
Date: Fri, 24 Mar 2006 16:39:05 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Valerie Henson <val_henson@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       pbadari@gmail.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, arjan@linux.intel.com,
       zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324213905.GG18020@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Valerie Henson <val_henson@linux.intel.com>,
	Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
	linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
	arjan@linux.intel.com, zach.brown@oracle.com
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober> <20060324192802.GK14852@schatzie.adilger.int> <20060324200131.GE18020@thunk.org> <20060324210033.GQ14852@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324210033.GQ14852@schatzie.adilger.int>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 02:00:33PM -0700, Andreas Dilger wrote:
> > This would be a prime candidate for trying to add the same sort of
> > userspace test framework which Rusty and company did for netfilter, so
> > we can try to test for race conditions, corner cases, etc.
> 
> Are you saying to make a filesystem test harness in userspace, or to
> add hooks into the kernel to trigger specific cases in the running
> kernel?

The former: a filesystem test harness in userspace, possibly with some
kernel code changes to make it easier to integrate it with the
userspace test harness.  It's very similar to what the Netfilter folks
did, and it has the advantage that we can do testing much more
quickly, especially in cases where we want to simulate crashes at
certain specific test points to make sure the journal recovery happens
correctly.

						- Ted
