Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136336AbRD2USw>; Sun, 29 Apr 2001 16:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136330AbRD2USd>; Sun, 29 Apr 2001 16:18:33 -0400
Received: from [63.95.87.168] ([63.95.87.168]:58375 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S136327AbRD2US3>;
	Sun, 29 Apr 2001 16:18:29 -0400
Date: Sun, 29 Apr 2001 16:18:27 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010429161827.B17539@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <3AEBF782.1911EDD2@mandrakesoft.com> <15083.64180.314190.500961@pizda.ninka.net> <20010429153229.L679@nightmaster.csn.tu-chemnitz.de> <200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca> <20010429221159.U706@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010429221159.U706@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Sun, Apr 29, 2001 at 10:11:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 10:11:59PM +0200, Ingo Oeser wrote:
[snip]
> The point is: The code in that "magic page" that considers the
> tradeoff is KERNEL code, which is designed to care about such
> trade-offs for that machine. Glibc never knows this stuff and
> shouldn't, because it is already bloated.
> 
> We get the full win here, for our "compile the kernel for THIS
> machine to get maximum performance"-strategy.
> 
> People tend to compile the kernel, but not the glibc.
> 
> Just let the benchmarks, Linus and Ulrich decide ;-)

The kernel can even customize the page at runtime if it needs to, such as
changing algorithims to deal with lock contention.

Of course, this page will need to present a stable interface to glibc, and
having both the code and a comprehensive jump-table might become tough in a
single page...
