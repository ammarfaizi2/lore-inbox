Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbREHHAX>; Tue, 8 May 2001 03:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbREHHAO>; Tue, 8 May 2001 03:00:14 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:53006 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131205AbREHHAE>;
	Tue, 8 May 2001 03:00:04 -0400
Date: Tue, 8 May 2001 08:59:41 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>, Tom Rini <trini@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010508085941.B17720@pcep-jamie.cern.ch>
In-Reply-To: <20010505192731.A2374@thyrsus.com> <E14wO7g-000240-00@the-village.bc.nu> <20010507105950.A771@opus.bloom.county> <20010507213140.I16535@thyrsus.com> <20010507184315.A2378@opus.bloom.county> <20010507215618.B21552@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010507215618.B21552@thyrsus.com>; from esr@thyrsus.com on Mon, May 07, 2001 at 09:56:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:
> Tom Rini <trini@kernel.crashing.org>:
> > Only sort-of.  There are some cases where you can get away with that.  
> > Probably.  eg If you ask for PARPORT, on x86 that means yes to PARPORT_PC,
> > always (right?)
> 
> Yes.  So the right answer there isn't to use a derivation but to say:
> 
> require X86 and PARPORT implies PARPORT_PC
> unless X86==n suppress PARPORT_PC
> 
> which forces PARPORT_PC==y and makes the question invisible on X86 machines,
> but leaves the question visible on all others.

Which is unfortunately wrong if you want the parport subsystem on x86
but won't be using the parport_pc driver with it.  I.e. you'll be using
some other driver which isn't part of the kernel tree.  Perhaps a
modified version of parport_pc, perhaps something else.

The default should be PARPORT_PC==y, but it's actually valid for some
applications to _require_ PARPORT_PC==n or PARPORT_PC==m.

-- Jamie

