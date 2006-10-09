Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932933AbWJIP1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbWJIP1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbWJIP1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:27:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:32951 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932933AbWJIP1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:27:39 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Mon, 9 Oct 2006 17:27:32 +0200
User-Agent: KMail/1.9.4
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Howells <dhowells@redhat.com>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, sfr@canb.auug.org.au,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> <200610091652.26209.arnd.bergmann@de.ibm.com> <Pine.LNX.4.62.0610091705070.16048@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0610091705070.16048@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610091727.34780.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 October 2006 17:05, Geert Uytterhoeven wrote:
> 
> On Mon, 9 Oct 2006, Arnd Bergmann wrote:
> > On Monday 09 October 2006 15:09, Geert Uytterhoeven wrote:
> > > On Mon, 9 Oct 2006, Jan Engelhardt wrote:
> > > > 
> > > > Ouch ouch ouch. It should better be
> > > > 
> > > > typedef uint32_t __u32;
> > > 
> > > You mean
> > > 
> > > #ifdef __KERNEL__
> > > typedef __u32 u32;
> > > #else
> > > // Assumed we did #include <stdint.h> before
> > > typedef uint32_t __u32;
> > > #endif
> > 
> > Why should that be a valid assumption? Right now, it works
> > if you don't include stdint.h in advance.
> 
> According to C99 section 7.18 you need to include <stdint.h> first.

Sorry, I need to rephrase: you can include <linux/types.h> without
including <stdint.h> first, and many people do that.
Relying on uint32_t would mean we break existing source.

	Arnd <><
