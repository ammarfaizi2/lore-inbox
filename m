Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSJYTGG>; Fri, 25 Oct 2002 15:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261571AbSJYTGG>; Fri, 25 Oct 2002 15:06:06 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:664 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261569AbSJYTGC>;
	Fri, 25 Oct 2002 15:06:02 -0400
Date: Fri, 25 Oct 2002 20:13:56 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       chrisl@vmware.com, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] How to get number of physical CPU in linux from user space?
Message-ID: <20021025191356.GA11189@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	"Nakajima, Jun" <jun.nakajima@intel.com>, chrisl@vmware.com,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <F2DBA543B89AD51184B600508B68D4000EA170E9@fmsmsx103.fm.intel.com> <1035572950.1501.3429.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035572950.1501.3429.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 03:09:09PM -0400, Robert Love wrote:
 > +#ifdef CONFIG_SMP
 > +	seq_printf(m, "physical processor ID\t: %d\n", phys_proc_id[n]);
 > +	seq_printf(m, "number of siblings\t: %d\n", smp_num_siblings);
 > +#endif

Should this be wrapped in a if (cpu_has_ht(c)) { }  ?
Seems silly to be displaying HT information on non-HT CPUs.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
