Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVFCTJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVFCTJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVFCTJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:09:34 -0400
Received: from fmr21.intel.com ([143.183.121.13]:38020 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261209AbVFCTJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:09:24 -0400
Date: Fri, 3 Jun 2005 12:09:14 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, nanhai.zou@intel.com,
       rohit.seth@intel.com, rajesh.shah@intel.com
Subject: Re: [discuss] Re: [Patch] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050603120913.C29609@unix-os.sc.intel.com>
References: <20050602133256.A14384@unix-os.sc.intel.com> <20050602135013.4cba3ae2.akpm@osdl.org> <20050602151912.B14384@unix-os.sc.intel.com> <20050602154823.15141bfc.akpm@osdl.org> <20050602160603.C14384@unix-os.sc.intel.com> <20050603154839.GN23831@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050603154839.GN23831@wotan.suse.de>; from ak@suse.de on Fri, Jun 03, 2005 at 05:48:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 05:48:39PM +0200, Andi Kleen wrote:
> On Thu, Jun 02, 2005 at 04:06:04PM -0700, Siddha, Suresh B wrote:
> > On Thu, Jun 02, 2005 at 03:48:23PM -0700, Andrew Morton wrote:
> > > I know.  I'm claiming that this is conceptually wrong.
> > 
> > I def see your point. But this is too late for 2.6.12.  We want to get this 
> > fixed in 2.6.12.  We can do the cleanup at a more convenient time.
> 
> My feeling is that all of this is more for post 2.6.12. I still
> have not seen anything important that would get fixed by it.

Andi, This patch fixes two critical issues. One is the memory leak that 
can happen in syscall32_setup_pages because of a malicious app and 
another is the 32bit hugetlb application failure(which was also observed 
by a customer recently). More details are in my changeset comments.

Either we need to fix these issues independently for 2.6.12 or address
the issue globally(fixing all the corner cases).

thanks,
suresh
