Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271932AbRH2IkT>; Wed, 29 Aug 2001 04:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271933AbRH2IkJ>; Wed, 29 Aug 2001 04:40:09 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:28164 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S271932AbRH2IkB>; Wed, 29 Aug 2001 04:40:01 -0400
Date: Wed, 29 Aug 2001 10:40:17 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Pascal Schmidt <pleasure.and.pain@web.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Can't compile HiSaX into 2.2.20pre9 kernel
In-Reply-To: <Pine.LNX.4.33.0108290222470.890-100000@neptune.sol.net>
Message-ID: <Pine.LNX.4.33.0108291038500.18233-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001, Pascal Schmidt wrote:

> On Wed, 29 Aug 2001, Pascal Schmidt wrote:
> 
> > The strange thing is, the drivers/isdn/isdn.a included above defines
> > the symbol:
> > /usr/src/linux-2.2.20pre9 # nm -a drivers/isdn/isdn.a | grep HiSax_setup
> > 0000043c t HiSax_setup
> 
> Whooops, silly me. The problem is of course that the small "t" indicates
> that HiSax_setup is a local symbol here, where it should be global and
> shown as "T". It works with 2.2.19 because there HiSax_setup is a global
> symbol.
> 
> Fix should be easy, though I don't know how to fix it. ;)

In drivers/isdn/hisax/config.c, remove the "static" in the line

static void HiSax_setup(...)

I'll send a patch to Alan, thanks for reporting.

--Kai


