Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSEVOOn>; Wed, 22 May 2002 10:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSEVOOl>; Wed, 22 May 2002 10:14:41 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:1714 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313906AbSEVOOk>;
	Wed, 22 May 2002 10:14:40 -0400
Date: Wed, 22 May 2002 16:12:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020522161259.A1060@ucw.cz>
In-Reply-To: <3CEB9465.6040409@evision-ventures.com> <Pine.GSO.4.21.0205220957320.2737-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 09:59:41AM -0400, Alexander Viro wrote:

> On Wed, 22 May 2002, Martin Dalecki wrote:
> 
> > So at least we know now:
> > 
> > 1. Kernel is bogous.
> > 2. util-linux is bogous.
> > 
> > IOCTL is ineed the way to go to implement such functionality...
> 
> For kbdrate???  sysctl I might see - after all, we are talking about
> setting two numbers.  ioctl() to pass a couple of integers to the kernel?
> No, thanks.

Sysctl won't be too good an idea if you have more than one keyboard.
It needs to be device-related, hence an ioctl.

-- 
Vojtech Pavlik
SuSE Labs
