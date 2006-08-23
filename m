Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWHWKuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWHWKuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWHWKuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:50:04 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:34252 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S964838AbWHWKuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:50:03 -0400
Date: Wed, 23 Aug 2006 03:39:56 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Message-ID: <20060823103956.GB697@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <p73fyfn7nzz.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73fyfn7nzz.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 12:19:44PM +0200, Andi Kleen wrote:
> > +config X86_64_PERFMON_AMD64
> > +	tristate "Support 64-bit mode AMD64 hardware performance counters"
> > +	depends on PERFMON
> > +	default m
> 
> No default m please.  If someone just presses return in make oldconfig
> with a new kernel they don't want all kinds of new random optional drivers.
> 
> I think I would prefer to call it _K8, because in theory new AMD CPUs
> might have difference performance counters.
> 
I have a second thought on this. AMD has architected the performance counters.
Their specification is not part of a model specific documentation but
part of the AMD64 architecure.  If they were to radically change the
way performance counters are defined, then the processor would violate the
architecture. They can certainely extened the architecture, e.g., have more
than 4 counters. Those new counters could be model-specific, in which case
I would create a model-specific PMU description for it. If they want
to extened the capability for all new processors, I think a cleaner
way would be to update the architecture and then we could update the
descsription we have.

What I don't not quite understand with the K7, K8 terminology is the
relation/dependencies with the AMD64 architecture specification.

--
-Stephane
