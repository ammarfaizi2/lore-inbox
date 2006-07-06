Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWGFWyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWGFWyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWGFWyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:54:37 -0400
Received: from mga07.intel.com ([143.182.124.22]:44095 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750844AbWGFWyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:54:36 -0400
X-IronPort-AV: i="4.06,214,1149490800"; 
   d="scan'208"; a="62340540:sNHT29974630"
Date: Thu, 6 Jul 2006 15:47:11 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, perfmon@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [perfmon] Re: cpuinfo_x86 and apicid
Message-ID: <20060706154711.C13512@unix-os.sc.intel.com>
References: <20060706150118.GB10110@frankl.hpl.hp.com> <20060706091930.A13512@unix-os.sc.intel.com> <20060706200031.GA10685@frankl.hpl.hp.com> <20060706140613.B13512@unix-os.sc.intel.com> <20060706222543.GC10760@frankl.hpl.hp.com> <20060706223745.GD10760@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060706223745.GD10760@frankl.hpl.hp.com>; from eranian@hpl.hp.com on Thu, Jul 06, 2006 at 03:37:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 03:37:45PM -0700, Stephane Eranian wrote:
> Suresh,
> 
> On Thu, Jul 06, 2006 at 03:25:43PM -0700, Stephane Eranian wrote:
> > > 
> > Ah, yes I missed that. It works there two. I had something wrong
> > about how I accessed cpu_data. I am used to the elegant way we
> > do it on IA-64 but on x86_64 you have to index the cpu_data[]
> > array with smp_processor_id(). I was pointing to cpu_data[0]
> > on all processors.
> > 
> > For what I need, I can do cpuinfo_x86->apicid & 0x3 to identify
> > which thread is running. I can now remove some more code in perfmon2.
> > 
> I meant cpuinfo_x86->apicid & 0x1.

Instead of hard coding, can you get the size of the mask runtime from the
size of cpu_sibling_map[cpu]

And remember, physical/logical hotplug can change this sibling map.

thanks,
suresh
