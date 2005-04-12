Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVDLCaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVDLCaC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 22:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVDLCaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 22:30:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:38298 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262004AbVDLC3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 22:29:55 -0400
Subject: Re: [PATCH] ppc32: refactor FPU exception handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <Pine.LNX.4.61.0504111639330.10171@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0504111639330.10171@blarg.somerset.sps.mot.com>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 12:28:35 +1000
Message-Id: <1113272915.5388.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 17:02 -0500, Kumar Gala wrote:
> Andrew,
> 
> Moved common FPU exception handling code out of head.S so it can be used 
> by several of the sub-architectures that might of a full PowerPC FPU.  
> 
> Also, uses new CONFIG_PPC_FPU define to fix alignment exception 
> handling for floating point load/store instructions to only occur if we 
> have a hardware FPU.
> 
> Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>


Andrew, please hold on this patch, it hasn't been properly discussed
with the relevant maintainer, that is Paul Mackerras.

I can see matter for debate in there, like the whole duplication of the
fast exception return path...

It's also touching quite sensitive bits of kernel code (head.S) that
needs careful auditing and testing before beeing pushed upstream.

Ben.


