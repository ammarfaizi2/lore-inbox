Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbVHXDLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVHXDLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 23:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVHXDLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 23:11:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:46042 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750939AbVHXDLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 23:11:55 -0400
From: Andi Kleen <ak@suse.de>
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] Add MCE resume under ia32
Date: Wed, 24 Aug 2005 05:12:35 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel> <p73pss4f6dj.fsf@verdi.suse.de> <1124848740.3622.1.camel@linux-hp.sh.intel.com>
In-Reply-To: <1124848740.3622.1.camel@linux-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508240512.35827.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 August 2005 03:59, Shaohua Li wrote:
> On Wed, 2005-08-24 at 03:52 +0200, Andi Kleen wrote:
> > Shaohua Li <shaohua.li@intel.com> writes:
> > > x86-64 has resume support. It uses 'on_each_cpu' in resume method,
> > > which is known broken. We'd better fix it.
> >
> > What is broken with it?
>
> It's a sysdev. The resume method is invoked with interrupt disabled.

But only local interrupt disabled, no? 

Hmm - didn't we have a WARN_ON(irqs_disabled()) in smp_call_function().

Anyways, it'll probably still work for now because the system should
be synchronized at this point.

-Andi
