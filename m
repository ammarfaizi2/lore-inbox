Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbVJHAxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbVJHAxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbVJHAxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:53:19 -0400
Received: from ozlabs.org ([203.10.76.45]:46771 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161027AbVJHAxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:53:19 -0400
Date: Sat, 8 Oct 2005 10:50:16 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: Brian Gerst <bgerst@didntduck.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix hotplug cpu on x86_64
Message-ID: <20051008005016.GG5210@krispykreme>
References: <43437DEB.4080405@didntduck.org> <434414C4.8020109@didntduck.org> <4345F656.9020601@didntduck.org> <20051007095041.GK6642@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007095041.GK6642@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> I also have a followon patch to avoid the extreme memory wastage
> currently caused by hotplug CPUs (e.g. with NR_CPUS==128 you currently
> lose 4MB of memory just for preallocated per CPU data). But that is
> something for post 2.6.14.

Im interested in doing that on ppc64 too. Are you currently only
creating per cpu data areas for possible cpus? The generic code does
NR_CPUS worth, we should change that in 2.6.15.

Anton
