Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129822AbQKJQyi>; Fri, 10 Nov 2000 11:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131067AbQKJQyV>; Fri, 10 Nov 2000 11:54:21 -0500
Received: from Cantor.suse.de ([194.112.123.193]:27908 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129822AbQKJQyJ>;
	Fri, 10 Nov 2000 11:54:09 -0500
Date: Fri, 10 Nov 2000 17:54:05 +0100
From: Andi Kleen <ak@suse.de>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: richardj_moore@uk.ibm.com, Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Message-ID: <20001110175405.A14799@gruyere.muc.suse.de>
In-Reply-To: <80256993.0047077C.00@d06mta06.portsmouth.uk.ibm.com> <200011101624.LAA22004@tsx-prime.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011101624.LAA22004@tsx-prime.MIT.EDU>; from tytso@MIT.EDU on Fri, Nov 10, 2000 at 11:24:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 11:24:28AM -0500, Theodore Y. Ts'o wrote:
> Right.  So what you're saying is that GKHI is adding complexity to the
> kernel to make it easier for peopel to put in non-standard patches which
> exposes non-standard interfaces which will lead to kernels not supported
> by the Linux Kernel Development Community.  Right?

My understanding is that GKHI does not change the kernel at all, except
for the three hooks needed for dprobes. All GKHI hooks are implemented 
as dynamic probes, which are just like debugger breakpoints. 
A dynamic probes breakpoint does not require any source
changes, but you have to check the assembly to find the right point for
them (at least in the current version, I don't know if IBM is planning 
to support source level dprobes using the debugging information) 

IMHO GKHI does not make mainteance of additional modules any easier, because
you always have to recheck the assembly if the dynamic probe still fits
(which may in some cases even be more work than reporting source patches,
it is also harder when you want to cover multiple architectures) 

It will just help some people who have a unrational aversion against kernel
recompiles and believe in vendor blessed binaries.


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
