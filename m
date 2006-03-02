Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWCBGHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWCBGHD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 01:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCBGHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 01:07:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:18307 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750812AbWCBGHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 01:07:01 -0500
Date: Wed, 1 Mar 2006 22:07:03 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [stable] Re: [patch 18/39] [PATCH] sys_mbind sanity checking
Message-ID: <20060302060703.GV3883@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org> <20060227223350.609924000@sorel.sous-sol.org> <20060302041031.GF19755@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302041031.GF19755@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> Gar..
> 
> mm/mempolicy.c: In function 'get_nodes':
> mm/mempolicy.c:527: error: 'BITS_PER_BYTE' undeclared (first use in this function)
> mm/mempolicy.c:527: error: (Each undeclared identifier is reported only once
> mm/mempolicy.c:527: error: for each function it appears in.)
> 
> About to retry a build with the below patch which should do the trick.
> (How did this *ever* build?)

Egads, this is a terrible release.  Thanks, that is the same macro
that's in Linus' tree which is the base I tested the original patch on,
and it's off on the configs I'm testing -stable with so I completely
missed the trivial brokeness.

thanks,
-chris
