Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWGFWqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWGFWqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWGFWqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:46:06 -0400
Received: from palrel10.hp.com ([156.153.255.245]:16272 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1750819AbWGFWqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:46:03 -0400
Date: Thu, 6 Jul 2006 15:37:45 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: perfmon@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [perfmon] Re: cpuinfo_x86 and apicid
Message-ID: <20060706223745.GD10760@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060706150118.GB10110@frankl.hpl.hp.com> <20060706091930.A13512@unix-os.sc.intel.com> <20060706200031.GA10685@frankl.hpl.hp.com> <20060706140613.B13512@unix-os.sc.intel.com> <20060706222543.GC10760@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706222543.GC10760@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh,

On Thu, Jul 06, 2006 at 03:25:43PM -0700, Stephane Eranian wrote:
> > 
> Ah, yes I missed that. It works there two. I had something wrong
> about how I accessed cpu_data. I am used to the elegant way we
> do it on IA-64 but on x86_64 you have to index the cpu_data[]
> array with smp_processor_id(). I was pointing to cpu_data[0]
> on all processors.
> 
> For what I need, I can do cpuinfo_x86->apicid & 0x3 to identify
> which thread is running. I can now remove some more code in perfmon2.
> 
I meant cpuinfo_x86->apicid & 0x1.


-- 

-Stephane
