Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWHYNRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWHYNRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWHYNRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:17:35 -0400
Received: from mail.suse.de ([195.135.220.2]:29600 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751279AbWHYNRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:17:35 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 10/18] 2.6.17.9 perfmon2 patch for review: PMU context switch support
Date: Fri, 25 Aug 2006 15:17:30 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, "S. P. Prasanna" <prasanna@in.ibm.com>
References: <200608230806.k7N86151000456@frankl.hpl.hp.com> <200608251420.31564.ak@suse.de> <20060825125633.GE5330@frankl.hpl.hp.com>
In-Reply-To: <20060825125633.GE5330@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608251517.30479.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 14:56, Stephane Eranian wrote:
> On Fri, Aug 25, 2006 at 02:20:31PM +0200, Andi Kleen wrote:
> > On Friday 25 August 2006 13:56, Stephane Eranian wrote:
> > 
> > > > I suppose some of those functions must be marked __kprobes
> > > >  
> > > Are there any guidelines as to why some functions must be ignored
> > > by kprobes? I assume if meaans they cannot be instrumented.
> > 
> > It does yes.
> > 
> > In general anything that could cause kprobes to recurse is forbidden.
> 
> In the case of the PMU context switch, are you saying that you may
> context switch as a consequence of hitting a (K)probe?

I hope not, but at least the current __switch_to is marked __kprobes
and I assume there was some reason for it and it will likely apply
to callees too. For details ask Prasanna (cc'ed).

-Andi
