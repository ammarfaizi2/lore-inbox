Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264300AbUEDJqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUEDJqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 05:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264293AbUEDJqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 05:46:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25307 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264286AbUEDJqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 05:46:43 -0400
Date: Tue, 4 May 2004 10:46:42 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
Message-ID: <20040504094642.GL17014@parcelfarce.linux.theplanet.co.uk>
References: <16521.5104.489490.617269@laputa.namesys.com> <16529.56343.764629.37296@cse.unsw.edu.au> <409634B9.8D9484DA@melbourne.sgi.com> <16534.54704.792101.617408@cse.unsw.edu.au> <40973F7F.A9FA4F1@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40973F7F.A9FA4F1@melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 05:00:15PM +1000, Greg Banks wrote:
 
> Ok, how about this...it's portable, and not racy, but may perturb the
> logic slightly by also taking dentries off the unused list in the case
> where they already had d_count>=1.  I'm not sure how significant that is.
> In any case this also passes my tests.
 
a) ask RCU folks to review - the current logics in dcache.c is extremely
brittle as it is.

b) after rereading that code, I _really_ don't like the crap with "hashed
but disconnected" nfsd is pulling off.  Neil, care to give detailed reasons
why you are doing that?
