Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWBMUha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWBMUha (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWBMUh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:37:29 -0500
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:46993 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S964876AbWBMUh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:37:28 -0500
Date: Mon, 13 Feb 2006 12:34:03 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: perfmon2 code review: 32-bit ABI on 64-bit OS
Message-ID: <20060213203403.GK11285@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net> <1138221212.15295.35.camel@serpentine.pathscale.com> <20060125222844.GB10451@frankl.hpl.hp.com> <1138649612.4077.50.camel@localhost.localdomain> <1138651545.4487.13.camel@camp4.serpentine.com> <1139155731.4279.0.camel@localhost.localdomain> <1139245253.27739.8.camel@camp4.serpentine.com> <20060210153608.GC28311@frankl.hpl.hp.com> <1139596023.9646.111.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139596023.9646.111.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan,

On Fri, Feb 10, 2006 at 10:27:02AM -0800, Bryan O'Sullivan wrote:
> 
> On some 64-bit arches (e.g. x86_64), most userspace code is 64-bit,
> while on others (e.g. powerpc), most is 32-bit.  Reducing the number of
> things that a userspace tool or library writer can trip over seems like
> a good thing here, even if it slightly complicates perfmon's internals.
> 
> > Note that there are similar issues with the remapped sampling buffer.
> > There, you need to explicitly compile your tool with a special option
> > to force certain types to be 64-bit (size_t, void *).
> 
> It's pretty normal to just use 64-bit quantities in these cases, and
> cast appropriately.
> 

So if I understand you correctly, you are saying it is best to have bitmasks
hardcoded to u64 and have the kernel cast to match the bitmap_*() interface.
This would not cause any alignment problems on neither 32-bit nor 64-bit system.


-- 

-Stephane
