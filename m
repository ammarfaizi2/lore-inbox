Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312997AbSDSVmK>; Fri, 19 Apr 2002 17:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313054AbSDSVmJ>; Fri, 19 Apr 2002 17:42:09 -0400
Received: from ns.suse.de ([213.95.15.193]:20746 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312997AbSDSVmH>;
	Fri, 19 Apr 2002 17:42:07 -0400
Date: Fri, 19 Apr 2002 23:42:06 +0200
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: andrea@suse.de, ak@suse.de, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: SSE related security hole
Message-ID: <20020419234206.A15187@wotan.suse.de>
In-Reply-To: <20020419230454.C1291@dualathlon.random> <2459.131.107.184.74.1019252157.squirrel@www.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 02:35:57PM -0700, H. Peter Anvin wrote:
> >>
> >> Ummm...last I knew, fxrstor is *expensive*.  The fninit/xor regs setup
> >> is  likely *very* much faster.  Someone should check this before we
> >> sacrifice  100 cycles needlessly or something.
> >
> > most probably yes, fxrestor needs to read ram, pxor also takes some
> > icache and bytecode ram but it sounds like it will be faster.
> >
> > Maybe we could also interleave the pxor with the xorps, since they uses
> > different parts of the cpu, Honza?
> >
> 
> You almost certainly should.  The reason I suggested FXRSTOR is that it
> would initialize the entire FPU, including any state that future
> processors may add, thus reducing the likelihood of any funnies in the
> future.

That's also why I like it. 

-Andi
