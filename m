Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWEKWSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWEKWSi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 18:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWEKWSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 18:18:38 -0400
Received: from mga05.intel.com ([192.55.52.89]:34317 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750854AbWEKWSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 18:18:38 -0400
TrustInternalSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.05,117,1146466800"; 
   d="scan'208"; a="35939728:sNHT112133504"
Date: Thu, 11 May 2006 15:17:59 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca, vatsa@in.ibm.com
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-ID: <20060511151759.A17155@unix-os.sc.intel.com>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com> <20060510230606.076271b2.akpm@osdl.org> <20060511095308.A15483@unix-os.sc.intel.com> <20060511171920.GB10833@localdomain> <20060511104030.A15782@unix-os.sc.intel.com> <20060511191939.GC10833@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060511191939.GC10833@localdomain>; from ntl@pobox.com on Thu, May 11, 2006 at 02:19:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 02:19:39PM -0500, Nathan Lynch wrote:
> > > just a bunch of handwaving so far, sorry.
> > 
> > Hand waving? Dont think that was intensional though.. i think we are trying
> > to address a real problem, if there is a reasonable alternate already
> > that we are not aware of, no problemo...
> 
> If the motivation for these patches is to minimize disruption of the
> workload when offlining a group of cpus, then I think the reasonable
> alternative is for the admin (or a script) to migrate sensitive
> tasks and interrupts to cpus that are not going to be offlined --
> before offlining any cpus.
> 
> On the other hand, I'm getting the feeling that the problem you're
> really trying to address is that offlining lots of cpus takes a long

Think i relied to the other thread... we can invent lots of goodies to keep
process and interrupt bouncing... but nothing is going to stop the 
kstopmachine() hammer for each logical cpu offline in any architecture:-(


