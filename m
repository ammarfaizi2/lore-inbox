Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313118AbSDSWS5>; Fri, 19 Apr 2002 18:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSDSWS4>; Fri, 19 Apr 2002 18:18:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34828 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313118AbSDSWS4>; Fri, 19 Apr 2002 18:18:56 -0400
Date: Sat, 20 Apr 2002 00:18:58 +0200
From: Jan Hubicka <jh@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Jan Hubicka <jh@suse.cz>
Subject: Re: SSE related security hole
Message-ID: <20020419221858.GF16856@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020418183639.20946.qmail@science.horizon.com.suse.lists.linux.kernel> <a9ncgs$2s2$1@cesium.transmeta.com.suse.lists.linux.kernel> <p73662naili.fsf@oldwotan.suse.de> <20020419140031.A25519@redhat.com> <20020419230454.C1291@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Apr 19, 2002 at 02:00:31PM -0400, Doug Ledford wrote:
> > On Fri, Apr 19, 2002 at 04:06:17PM +0200, Andi Kleen wrote:
> > > "H. Peter Anvin" <hpa@zytor.com> writes:
> > > > 
> > > > Perhaps the right thing to do is to have a description in data of the
> > > > desired initialization state and just F[NX]RSTOR it?
> > > 
> > > Sounds like the cleanest solution. The state could be saved at CPU bootup
> > > with just MXCSR initialized.
> > > 
> > > I'll implement that for x86-64.
> > 
> > Ummm...last I knew, fxrstor is *expensive*.  The fninit/xor regs setup is 
> > likely *very* much faster.  Someone should check this before we sacrifice 
> > 100 cycles needlessly or something.
> 
> most probably yes, fxrestor needs to read ram, pxor also takes some
> icache and bytecode ram but it sounds like it will be faster.
> 
> Maybe we could also interleave the pxor with the xorps, since they uses
> different parts of the cpu, Honza?

Yes, I guess that should help to at least some chips.
Definitly nothing to loose :)

Honza
