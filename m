Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbSJYXx7>; Fri, 25 Oct 2002 19:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbSJYXx7>; Fri, 25 Oct 2002 19:53:59 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:47770 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261698AbSJYXx4>;
	Fri, 25 Oct 2002 19:53:56 -0400
Date: Sat, 26 Oct 2002 01:01:37 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Robert Love <rml@tech9.net>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Message-ID: <20021026000137.GA19673@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Robert Love <rml@tech9.net>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"'akpm@digeo.com'" <akpm@digeo.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'chrisl@vmware.com'" <chrisl@vmware.com>,
	"'Martin J. Bligh'" <mbligh@aracnet.com>
References: <F2DBA543B89AD51184B600508B68D4000EA1718C@fmsmsx103.fm.intel.com> <1035581420.734.3873.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035581420.734.3873.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 05:30:19PM -0400, Robert Love wrote:

 > +#ifdef CONFIG_SMP
 > +	if (cpu_has_ht) {
 > +		seq_printf(m, "physical processor ID\t: %d\n", phys_proc_id[n]);
 > +		seq_printf(m, "number of siblings\t: %d\n", smp_num_siblings);
 > +	}
 > +#endif

Something else looks suspect to me here.
smp_num_siblings is going to say the same value on every CPU in the
system. It's questionable whether we want to print it out n times.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
