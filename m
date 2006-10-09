Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932927AbWJIPGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbWJIPGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932926AbWJIPGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:06:13 -0400
Received: from witte.sonytel.be ([80.88.33.193]:6815 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932923AbWJIPGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:06:12 -0400
Date: Mon, 9 Oct 2006 17:05:48 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Howells <dhowells@redhat.com>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, sfr@canb.auug.org.au,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
In-Reply-To: <200610091652.26209.arnd.bergmann@de.ibm.com>
Message-ID: <Pine.LNX.4.62.0610091705070.16048@pademelon.sonytel.be>
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0610091508240.16048@pademelon.sonytel.be>
 <200610091652.26209.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006, Arnd Bergmann wrote:
> On Monday 09 October 2006 15:09, Geert Uytterhoeven wrote:
> > On Mon, 9 Oct 2006, Jan Engelhardt wrote:
> > > 
> > > Ouch ouch ouch. It should better be
> > > 
> > > typedef uint32_t __u32;
> > 
> > You mean
> > 
> > #ifdef __KERNEL__
> > typedef __u32 u32;
> > #else
> > // Assumed we did #include <stdint.h> before
> > typedef uint32_t __u32;
> > #endif
> 
> Why should that be a valid assumption? Right now, it works
> if you don't include stdint.h in advance.

According to C99 section 7.18 you need to include <stdint.h> first.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
