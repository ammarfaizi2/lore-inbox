Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132914AbREGSDZ>; Mon, 7 May 2001 14:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132765AbREGSDR>; Mon, 7 May 2001 14:03:17 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:9220 "EHLO
	Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S132757AbREGSDI>; Mon, 7 May 2001 14:03:08 -0400
Date: Mon, 7 May 2001 10:59:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010507105950.A771@opus.bloom.county>
In-Reply-To: <20010505192731.A2374@thyrsus.com> <E14wO7g-000240-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14wO7g-000240-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, May 06, 2001 at 01:58:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 01:58:49PM +0100, Alan Cox wrote:
> > # These were separate questions in CML1
> > derive MAC_SCC from MAC & SERIAL
> > derive MAC_SCSI from MAC & SCSI
> > derive SUN3_SCSI from (SUN3 | SUN3X) & SCSI
> 
> Not all Mac's use the SCC if they have serial
> Not all Mac's use the same SCSI controller

Yes, but in this case 'MAC' means m68k mac, which this _might_ be valid, but
I never did get Linux up and running on the m68ks I had..

But Alan's point is a good one.  There are _lots_ of cases you can't get away
with things like this, unless you get very fine grained.  In fact, it would
be much eaiser to do this seperately from the kernel.  Ie another, 
possibly/probably _not_ inkernel config tool which asks what machine you
have, picks lots of sane defaults and setups a kernel config for you.  This
is _sort of_ what PPC does right now with the large number of 'default 
configs' (arch/ppc/configs).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
