Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270462AbTGSAqD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 20:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270463AbTGSAqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 20:46:03 -0400
Received: from zero.aec.at ([193.170.194.10]:19986 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S270462AbTGSAqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 20:46:01 -0400
Date: Sat, 19 Jul 2003 02:57:18 +0200
From: Andi Kleen <ak@muc.de>
To: linas@austin.ibm.com
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, linas@linas.org
Subject: Re: KDB in the mainstream 2.4.x kernels?
Message-ID: <20030719005718.GA4596@averell>
References: <aJIn.3mj.15@gated-at.bofh.it> <m3smp3y38y.fsf@averell.firstfloor.org> <20030718193107.B45512@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718193107.B45512@forte.austin.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 07:31:08PM -0500, linas@austin.ibm.com wrote:
> > One argument i have against it: KDB is incredibly ugly code. 
> > Before it could be even considered for merging it would need quite a lot 
> > of cleanup.
> 
> What in particular?  I just looked at kdb/kdbmain.c and kdb/kdb_bt.c
> and it looks fine to me; fairly minimal even.  I don't know about 
> arch-specific code.  Is there a particular file you're complaining about?

Check the kdbsupport.c code too. 

All the code together for the i386 backtracer is approaching 1000 LOC and
it's quite ugly.

> Dedicating a partition that is unformated, and whose sole purpose
> in life is to record a dump -- that is a viable option, at least on
> servers, where high uptime is more important, and storage is cheap.

Typically you don't need a dedicated partition, you can dump on swap.
netdump does also dump over the network. This may be the safer choice
when you don't trust your block subsystem after crashes.

-Andi

