Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWBJS1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWBJS1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 13:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWBJS1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 13:27:09 -0500
Received: from mx.pathscale.com ([64.160.42.68]:21406 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932170AbWBJS1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 13:27:08 -0500
Subject: Re: perfmon2 code review: 32-bit ABI on 64-bit OS
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
In-Reply-To: <20060210153608.GC28311@frankl.hpl.hp.com>
References: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net>
	 <1138221212.15295.35.camel@serpentine.pathscale.com>
	 <20060125222844.GB10451@frankl.hpl.hp.com>
	 <1138649612.4077.50.camel@localhost.localdomain>
	 <1138651545.4487.13.camel@camp4.serpentine.com>
	 <1139155731.4279.0.camel@localhost.localdomain>
	 <1139245253.27739.8.camel@camp4.serpentine.com>
	 <20060210153608.GC28311@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 10:27:02 -0800
Message-Id: <1139596023.9646.111.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 07:36 -0800, Stephane Eranian wrote:

> Many 64-bit Linux kernel do support running 32-bit native applications.
> That is the case on PPC64, MIPS64K, X86-64, for instance.

And sparc64 and s390.

>  One could well
> write a 32-bit monitoring tool on top of a 64-bit OS.

On some 64-bit arches (e.g. x86_64), most userspace code is 64-bit,
while on others (e.g. powerpc), most is 32-bit.  Reducing the number of
things that a userspace tool or library writer can trip over seems like
a good thing here, even if it slightly complicates perfmon's internals.

> Note that there are similar issues with the remapped sampling buffer.
> There, you need to explicitly compile your tool with a special option
> to force certain types to be 64-bit (size_t, void *).

It's pretty normal to just use 64-bit quantities in these cases, and
cast appropriately.

	<b

