Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbREHG6V>; Tue, 8 May 2001 02:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbREHG6L>; Tue, 8 May 2001 02:58:11 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:58869 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S131157AbREHG6C>;
	Tue, 8 May 2001 02:58:02 -0400
Date: Tue, 8 May 2001 08:57:40 +0200
From: David Weinehall <tao@acc.umu.se>
To: "Eric S. Raymond" <esr@thyrsus.com>, Tom Rini <trini@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010508085739.A17485@khan.acc.umu.se>
In-Reply-To: <20010505192731.A2374@thyrsus.com> <E14wO7g-000240-00@the-village.bc.nu> <20010507105950.A771@opus.bloom.county> <20010507213140.I16535@thyrsus.com> <20010507184315.A2378@opus.bloom.county> <20010507215618.B21552@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010507215618.B21552@thyrsus.com>; from esr@thyrsus.com on Mon, May 07, 2001 at 09:56:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 09:56:18PM -0400, Eric S. Raymond wrote:
> Tom Rini <trini@kernel.crashing.org>:
> > Only sort-of.  There are some cases where you can get away with
> > that.  Probably.  eg If you ask for PARPORT, on x86 that means yes
> > to PARPORT_PC, always (right?)
> 
> Yes.  So the right answer there isn't to use a derivation but to say:
> 
> require X86 and PARPORT implies PARPORT_PC
> unless X86==n suppress PARPORT_PC
> 
> which forces PARPORT_PC==y and makes the question invisible on X86
> machines, but leaves the question visible on all others.

Yes, but there are quite a lot of people who don't want
parport/serial/whatever compiled into their kernels at all,
eventhough they have an x86. Think low-memory systems or similar.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
