Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWHYNJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWHYNJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWHYNJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:09:15 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:60390 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751029AbWHYNJO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:09:14 -0400
Date: Fri, 25 Aug 2006 05:56:33 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] 2.6.17.9 perfmon2 patch for review: PMU context switch support
Message-ID: <20060825125633.GE5330@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N86151000456@frankl.hpl.hp.com> <p73bqqb7nkd.fsf@verdi.suse.de> <20060825115625.GC5330@frankl.hpl.hp.com> <200608251420.31564.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608251420.31564.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 02:20:31PM +0200, Andi Kleen wrote:
> On Friday 25 August 2006 13:56, Stephane Eranian wrote:
> 
> > > I suppose some of those functions must be marked __kprobes
> > >  
> > Are there any guidelines as to why some functions must be ignored
> > by kprobes? I assume if meaans they cannot be instrumented.
> 
> It does yes.
> 
> In general anything that could cause kprobes to recurse is forbidden.

In the case of the PMU context switch, are you saying that you may
context switch as a consequence of hitting a (K)probe?

-- 

-Stephane
