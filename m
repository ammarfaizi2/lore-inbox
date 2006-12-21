Return-Path: <linux-kernel-owner+w=401wt.eu-S1161099AbWLUBDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWLUBDX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWLUBDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:03:23 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:58450 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161099AbWLUBDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:03:22 -0500
Date: Wed, 20 Dec 2006 19:03:19 -0600
To: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
Message-ID: <20061221010319.GE16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com> <1166579210.4963.15.camel@otta> <20061220211931.GB16860@austin.ibm.com> <1166650134.6673.9.camel@localhost.localdomain> <20061220230342.GC16860@austin.ibm.com> <1166656195.6673.23.camel@localhost.localdomain> <20061220234647.GD16860@austin.ibm.com> <20061221003658.GB3048@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221003658.GB3048@krispykreme>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 11:36:59AM +1100, Anton Blanchard wrote:
> 
> On Wed, Dec 20, 2006 at 05:46:47PM -0600, Linas Vepstas wrote:
> 
> > System assert at:  file: rtas_io_config.c  -- line: 195
> > rio_hub_num: 10
> > drawer_num: 6
> > phb_num: 3
> > buid: 7
> 
> Looks like a firmware assert. Did you pass in something dodgy to a
> config read/write op? Maybe a bad buid?

Same kernel runs fine on power5. Although it does have patches
applied, those very same patches boot fine when applied to a slightly
older kernel (2.6.19-rc4).  I haven't been messing with buids or 
pci config space (at least not intentionaly).

I'll try again with an unpatched, unmodified kernel. 

--linas
