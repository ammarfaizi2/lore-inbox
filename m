Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWB1DdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWB1DdB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWB1DdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:33:00 -0500
Received: from ozlabs.org ([203.10.76.45]:31157 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932240AbWB1DdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:33:00 -0500
Date: Tue, 28 Feb 2006 14:32:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       kenneth.w.chen@intel.com,
       "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>, davem@davemloft.net,
       paulus@samba.org, benh@kernel.crashing.org, wli@holomorphy.com,
       lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       "tony.luck@intel.com" <tony.luck@intel.com>
Subject: Re: [PATCH] Enable mprotect on huge pages
Message-ID: <20060228033220.GA2570@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kenneth.w.chen@intel.com,
	"yanmin.zhang@intel.com" <yanmin.zhang@intel.com>,
	davem@davemloft.net, paulus@samba.org, benh@kernel.crashing.org,
	wli@holomorphy.com, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
	"tony.luck@intel.com" <tony.luck@intel.com>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com> <20060224142844.77cbd484.akpm@osdl.org> <20060226230903.GA24422@localhost.localdomain> <1141018592.1256.37.camel@ymzhang-perf.sh.intel.com> <1141022034.1256.44.camel@ymzhang-perf.sh.intel.com> <20060227173449.26c79a44.akpm@osdl.org> <1141097034.3898.10.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141097034.3898.10.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 11:23:54AM +0800, Zhang, Yanmin wrote:
> On Tue, 2006-02-28 at 09:34, Andrew Morton wrote:
> > "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> > >
> > > > > > > 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn_t support hugetlb
> > >  > > > > mprotect. My patch against 2.6.16-rc3 enables this capability.
> > > 
> > >  Based on David's comments, I worked out a new patch against 2.6.16-rc4.
> > >  Thank David.
> > > 
> > 
> > Please always send an updated changelog when sending an updated patch. 
> > Otherwise I have to go trolling back through the email thread to find it,
> > then work out what needs to be changed.
> Thanks for your kind reminder. I would do so next time.
> 
> > 
> > > 
> > >  I tested it on i386/x86_64/ia64. Who could help test it on other
> > >  platforms, such like PPC64?
> > 
> > I can do that - please send me your test app?
> I attach a test case. It will create directory /mnt/hugepages and delete it
> after testing automatically.
> 
> To run it by user root:
> #gcc -o mprotect_testcase mprotect_testcase.c
> #echo "5">/proc/sys/vm/nr_hugepages
> #./mprotect_testcase

If you could adapt this testcase to fit into the libhugetlbfs
testsuite, that would be really great (from
git://ozlabs.org/~dgibson/git/libhugetlbfs.git).  Otherwise I guess I
will..

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
