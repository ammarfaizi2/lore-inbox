Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268831AbUIAAcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268831AbUIAAcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269083AbUIAA3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:29:14 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:45701 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S269058AbUHaTqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:46:04 -0400
Date: Tue, 31 Aug 2004 21:45:55 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040831194554.GA27158@hout.vanvergehaald.nl>
References: <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 09:08:07PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 30 Aug 2004, Tom Vier wrote:
> 
> > On Thu, Aug 26, 2004 at 09:48:04AM -0700, Linus Torvalds wrote:
> > >  - safely synchronize globally visible data structures
> > > That's quite fundamental. 99% of what a kernel does is exactly
> > > that. TCP would be in user space too, if it wasn't for
> > > _exactly_ this issue. A lot
> > 
> > What about microkernels? They do tcp in userspace.
> 
> No they don't. They do TCP in a separate address space from user
> space, that just also happens to be separate from the "microkernel
> address space".

The HP NonStop Server (formerly called Tandem) has an MPP architecture
and a message passing OS (the NonStop Kernel). On this OS the TCP/IP
stack is implemented as a library against which the application
software is linked. The ethernet controllers/drivers maintain a
routing table for routing incoming traffic to the right process.
So the TCP/IP stack is implemented in userspace on the NonStop
Server, I would say.

Regards,
Toon.
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
