Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753408AbWKCRsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbWKCRsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbWKCRsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:48:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:50370 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753408AbWKCRsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:48:10 -0500
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.19-rc1: x86_64 slowdown in lmbench's fork
Date: Fri, 3 Nov 2006 18:47:49 +0100
User-Agent: KMail/1.9.5
Cc: tim.c.chen@linux.intel.com, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <1162485897.10806.72.camel@localhost.localdomain> <1162570216.10806.79.camel@localhost.localdomain> <m1lkmsxwk7.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkmsxwk7.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611031847.49222.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So unless there is some other array that is sized by NR_IRQs
> in the context switch path which could account for this in
> other ways.  It looks like you just got unlucky.


TLB/cache profiling data might be useful?
My bet would be more on cache effects.
 
> The only hypothesis that I can seem to come up with is that maybe
> you are getting an extra tlb now that you didn't use to.  
> I think the per cpu area is covered by huge pages but maybe not.

It should be.

-Andi
