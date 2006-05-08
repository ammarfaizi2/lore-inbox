Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWEHGGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWEHGGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 02:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWEHGGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 02:06:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:19894 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932257AbWEHGGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 02:06:16 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32954542:sNHT127322657"
Subject: Re: [PATCH 6/10] i386 implementation of cpu bulk removal
From: Shaohua Li <shaohua.li@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605072301201.2496@montezuma.fsmlabs.com>
References: <1147067152.2760.85.camel@sli10-desk.sh.intel.com>
	 <Pine.LNX.4.64.0605072301201.2496@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 14:05:02 +0800
Message-Id: <1147068302.2760.92.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-07 at 23:02 -0700, Zwane Mwaikambo wrote:
> On Mon, 8 May 2006, Shaohua Li wrote:
> 
> > +config BULK_CPU_REMOVE
> > +	bool "Support for bulk removal of CPUs (EXPERIMENTAL)"
> > +	depends on HOTPLUG_CPU && EXPERIMENTAL
> > +	help
> > +	  Say Y if need the ability to remove more than one cpu during cpu
> > +	  removal. Current mechanisms may be in-efficient when a NUMA
> > +	  node is being removed, which would involve removing one cpu at a
> > +	  time. This will let interrupts, timers and processes to be bound
> > +	  to a CPU that might be removed right after the current cpu is
> > +	  being offlined.
> > +
> 
> Hello Shaohua,
> 	Is this config option a temporary/staging thing?
I think it's temporary. Bulk cpu removal could be default of CPU
hotplug.

Thanks,
Shaohua
