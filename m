Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTCEFlf>; Wed, 5 Mar 2003 00:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTCEFlf>; Wed, 5 Mar 2003 00:41:35 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:63753
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262492AbTCEFld>; Wed, 5 Mar 2003 00:41:33 -0500
Date: Wed, 5 Mar 2003 00:49:55 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: ChristopherHuhn <c.huhn@gsi.de>
cc: linux-smp <linux-smp@vger.kernel.org>, "" <linux-kernel@vger.kernel.org>,
       Walter Schoen <w.schoen@gsi.de>, "" <support-gsi@credativ.de>
Subject: Re: Kernel Bug at spinlock.h ?!
In-Reply-To: <3E64B0EA.4080109@GSI.de>
Message-ID: <Pine.LNX.4.50.0303042133170.5867-100000@montezuma.mastecende.com>
References: <Pine.LNX.3.95.1030303103332.22802A-100000@chaos> <3E637CDC.3030409@GSI.de>
 <Pine.LNX.4.50.0303031248220.29455-100000@montezuma.mastecende.com>
 <3E64B0EA.4080109@GSI.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, ChristopherHuhn wrote:

> Newer means 2.4.21pre, since we are running 2.4.20?
> I assume that we will not upgrade the kernel before a new stable 
> release, since it is - should be - a production environment.
> 
> We have some indications, that our whole problem might be related to 
> kernel NFS and mixing between 2.2.21 and 2.4.20 in both directions.
> 
> I'll compile some more oopses and give you a report tomorrow.

Ok don't worry about upgrading kernels for now, (Disclaimer: I'm no NFS 
expert). it looks like there might have been a race here.

Code: Bad EIP value
[rpc_call_sync+121/164]
[rpc_run_timer+0/240]

It looks like a possible race with rpc_execute and possibly the timer, 
although i can't be certain where the other cpus are. Do the other oopses 
look somewhat similar? Could you supply them?

	Zwane
-- 
function.linuxpower.ca
