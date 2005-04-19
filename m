Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVDSNHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVDSNHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 09:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVDSNHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 09:07:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:42452 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261168AbVDSNHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 09:07:03 -0400
Date: Tue, 19 Apr 2005 15:06:58 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: x86_64 NMI watchdog breakage in 2.6.12-rc2-mm3
Message-ID: <20050419130658.GB7715@wotan.suse.de>
References: <200504191054.j3JAsO5g013833@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504191054.j3JAsO5g013833@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is wrong because in general the number of actual CPUs is _less_
> than the number of configured CPUs (== NR_CPUS). Hence the code will
> now check the NMI counts of non-existent CPUs, complain that they are
> stuck, and disable the NMI watchdog. Actually the disablement is broken
> in this case, but that's a different issue.

Yes, I know. I have it already fixed in my tree, together with a lot 
of other NMI watchdog bugs (including some long standing ones inherited
from i386) I will post the full patchkit later.

Andrew, please dont apply any nmi watchdog changes for x86-64 right now.
I will fix the current breakage before .12

-Andi

