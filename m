Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbTAaAsj>; Thu, 30 Jan 2003 19:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbTAaAsj>; Thu, 30 Jan 2003 19:48:39 -0500
Received: from [195.223.140.107] ([195.223.140.107]:47489 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267406AbTAaAsj>;
	Thu, 30 Jan 2003 19:48:39 -0500
Date: Fri, 31 Jan 2003 01:57:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: frlock and barrier discussion
Message-ID: <20030131005746.GA18538@dualathlon.random>
References: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net> <20030128230639.A17385@twiddle.net> <1043889355.10153.571.camel@dell_ss3.pdx.osdl.net> <20030129174133.A19912@twiddle.net> <20030130015219.GT1237@dualathlon.random> <20030130164120.A22148@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030130164120.A22148@twiddle.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 04:41:20PM -0800, Richard Henderson wrote:
> On Thu, Jan 30, 2003 at 02:52:19AM +0100, Andrea Arcangeli wrote:
> > you're missing xtimensec is a write.
> 
> Eh?  xtimensec is a register.

then it's fine, the register will be flushed to ram eventually and it
will be within the two wmb(), just write in the example also the line
where the xtimensec ""register"" is flushed to ram and it will be in the
right place

if the register isn't flushed to ram eventually, it will be discared and
the whole critical section is a noop from the point of view of the other
cpus and no wmb() or rmb() or mb() would be needed in the first place

Andrea
