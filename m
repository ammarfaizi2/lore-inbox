Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261621AbSJYVvB>; Fri, 25 Oct 2002 17:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbSJYVvA>; Fri, 25 Oct 2002 17:51:00 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:968 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261621AbSJYVvA>; Fri, 25 Oct 2002 17:51:00 -0400
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Robert Love <rml@tech9.net>, "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com>
References: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 23:14:36 +0100
Message-Id: <1035584076.13032.96.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 22:50, Nakajima, Jun wrote:
> Sorry,
> 
> Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for example,
> is already doing it:

Could do
> 
> +#ifdef CONFIG_SMP
> +	if (cpu_has_ht) {
> +		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
> +		seq_printf(m, "threads\t\t: %d\n", smp_num_siblings);
> +	}
> +#endif


Im just wondering what we would then use to describe a true multiple cpu
on a die x86. Im curious what the powerpc people think since they have
this kind of stuff - is there a generic terminology they prefer ?

