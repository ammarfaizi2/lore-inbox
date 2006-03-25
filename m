Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWCYFN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWCYFN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 00:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWCYFN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 00:13:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47296 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750812AbWCYFN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 00:13:28 -0500
Date: Sat, 25 Mar 2006 10:43:00 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Valerie Henson <val_henson@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
       arjan@linux.intel.com, zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060325051259.GA11615@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober> <20060324192802.GK14852@schatzie.adilger.int> <20060324200131.GE18020@thunk.org> <20060324210033.GQ14852@schatzie.adilger.int> <20060324213905.GG18020@thunk.org> <20060324221656.GW14852@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324221656.GW14852@schatzie.adilger.int>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 03:16:56PM -0700, Andreas Dilger wrote:
> On Mar 24, 2006  16:39 -0500, Theodore Ts'o wrote:
> > On Fri, Mar 24, 2006 at 02:00:33PM -0700, Andreas Dilger wrote:
> > > Are you saying to make a filesystem test harness in userspace, or to
> > > add hooks into the kernel to trigger specific cases in the running
> > > kernel?
> > 
> > The former: a filesystem test harness in userspace, possibly with some
> > kernel code changes to make it easier to integrate it with the
> > userspace test harness.  It's very similar to what the Netfilter folks
> > did, and it has the advantage that we can do testing much more
> > quickly, especially in cases where we want to simulate crashes at
> > certain specific test points to make sure the journal recovery happens
> > correctly.
> 
> I seem to recall that the Stanford Metacompilation group (Dawson Engler)
> already wrote such a tool.  Not sure what sort of access there is for the

Yup, it is called FiSC (File System Checker) -- unlike the meta-compiler,
this one is based on model checking. I found it quite interesting based
on my reading of the paper. But I couldn't get any further in terms of
actually being able to play with it since it wasn't available publicly as
you point out.

> tool, whether public funding would grant access to the public, or if they
> are at least willing to make an online interface available (the group has
> spun out into "Coverity", and it seems unlikely it will be completely OSS).

Regards
Suparna

> 
> Cheers, Andreas
> --
> Andreas Dilger
> Principal Software Engineer
> Cluster File Systems, Inc.
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

