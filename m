Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284258AbRLXALO>; Sun, 23 Dec 2001 19:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284263AbRLXALF>; Sun, 23 Dec 2001 19:11:05 -0500
Received: from ns.suse.de ([213.95.15.193]:16396 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284258AbRLXAKp>;
	Sun, 23 Dec 2001 19:10:45 -0500
Date: Mon, 24 Dec 2001 01:10:43 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5] support for NCR voyager 
 343x/345x/4100/51xx architecture
In-Reply-To: <200112231913.fBNJDgt01933@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112240106490.17860-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, James Bottomley wrote:

> Since the architecture support depends fairly intimitely on the existing i386
> code, I've slotted it into the i386 architecture directory rather than trying
> to create a separate one.
> http://www.hansenpartnership.com/voyager/files/voyager-2.5.1.diff
> All comments welcome.

Things like this...

+#ifdef CONFIG_VOYAGER
+       }
+#endif

*really* gross me out. One thing I intend to do at some point in
2.5 also is to split out the visws setup code to setup-visws.c or
the likes, as a, it's more or less unmaintained, and b, more
noisy ifdef's.

I'd be *so* much happier to see your patch with setup-voyager.c,
and a single ifdef in setup.c wrapping setup_voyager() or the likes.

On another related topic, the bootmem stuff in setup.c would be
so much nicer to be split into a bootmem.c imho.

This would also make sharing the x86 bootmem code with the x86-64
bootmem code a lot simpler.

comments ?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

