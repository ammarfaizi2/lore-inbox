Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbVKQBpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbVKQBpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbVKQBp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:45:29 -0500
Received: from ozlabs.org ([203.10.76.45]:18336 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030584AbVKQBp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:45:29 -0500
Date: Thu, 17 Nov 2005 12:41:55 +1100
From: Anton Blanchard <anton@samba.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.15-rc1-git4 build failure on ppc64
Message-ID: <20051117014155.GA19128@krispykreme>
References: <1132188084.24066.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132188084.24066.103.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> I get following compile error on PPC64 - while trying to compile
> CONFIG_FLATMEM=y. 
> 
> arch/powerpc/mm/numa.c: In function `dump_numa_topology':
> arch/powerpc/mm/numa.c:516: error: `SECTION_SIZE_BITS' undeclared (first
> use in this function)
> arch/powerpc/mm/numa.c:516: error: (Each undeclared identifier is
> reported only once
> arch/powerpc/mm/numa.c:516: error: for each function it appears in.)
> make[1]: *** [arch/powerpc/mm/numa.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/powerpc/mm] Error 2

Looks like you are trying to compile NUMA=y, FLATMEM=y which is an
illegal combination. Andy has submitted patches to fix this but in the
meantime can you either make both on or both off?

Anton
