Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271899AbTG2Omq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271900AbTG2Omq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:42:46 -0400
Received: from zero.aec.at ([193.170.194.10]:264 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S271899AbTG2Omo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:42:44 -0400
Date: Tue, 29 Jul 2003 16:41:29 +0200
From: Andi Kleen <ak@muc.de>
To: Erich Focht <efocht@hpce.nec.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>,
       torvalds@osdl.org
Subject: Re: [patch] scheduler fix for 1cpu/node case
Message-ID: <20030729144129.GA30393@averell>
References: <200307280548.53976.efocht@gmx.net> <3900670000.1059422153@[10.10.2.4]> <200307282218.19578.efocht@hpce.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307282218.19578.efocht@hpce.nec.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 10:18:19PM +0200, Erich Focht wrote:
> > > So x86_64 platforms
> > > (but not only those!) suffer and whish to switch off the NUMA
> > > scheduler while keeping NUMA memory management on.
> >
> > Right - I have a patch to make it a config option (CONFIG_NUMA_SCHED)
> > ... I'll feed that upstream this week.
> 
> That's one way, but the proposed patch just solves the problem (in a
> more general way, also for other NUMA cases). If you deconfigure NUMA
> for a NUMA platform, we'll have problems switching it back on when
> adding smarter things like node affine or homenode extensions.

That's one important point IMHO. Currently Opteron does not really 
need the NUMA scheduler, but it will be in future with such extensions.
This means it would be better if the current scheduler supports 
it already so that it can be easily extended.

Thanks for the patch.

-Andi
