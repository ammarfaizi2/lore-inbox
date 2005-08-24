Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVHXLX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVHXLX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbVHXLX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:23:28 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18619 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750878AbVHXLX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:23:28 -0400
Date: Wed, 24 Aug 2005 16:54:38 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050824112438.GA5197@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 07:43:42AM +0100, Al Viro wrote:
> On Tue, Aug 23, 2005 at 10:08:13PM -0700, Linus Torvalds wrote:
> 
> >   cpu_exclusive sched domains on partial nodes temp fix
> 
> ... breaks ppc64 since there we have node_to_cpumask() done as inlined
> function, not a macro.  So we get __first_cpu(&node_to_cpumask(...),...),
> with obvious consequences.
> 
> Locally I'm turning node_to_cpumask() into define, just to see what else
> had changed in the build, but we probably want saner solution for that
> one...

Not sure why this patch was included. I had reported yesterday that
it hangs up ppc64 on doing some exclusive cpuset operations. (I had
fixed the compile problem by having a temp for the cpumask variable)

So this patch is not ready to go in just yet. I am working on the fix,
hope to have it soon

	-Dinakar
