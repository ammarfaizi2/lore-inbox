Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSFOK5N>; Sat, 15 Jun 2002 06:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSFOK5M>; Sat, 15 Jun 2002 06:57:12 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:28936 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S315265AbSFOK5L>; Sat, 15 Jun 2002 06:57:11 -0400
Date: Sat, 15 Jun 2002 10:25:41 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
Message-ID: <20020615102541.L22429@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3D0A449C.5030304@mandrakesoft.com> <Pine.LNX.4.44.0206141803260.31514-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 14, 2002 at 06:25:15PM -0500, Kai Germaschewski wrote:
> We only request the regions we're going to use, so the others may even 
> stay unassigned and disabled.
[...]
> These functions return directly what we need: an address for 
> in/out[bwl], a cookie for read/write[bwl] - well, and the irq
> which however is only for informational purposes.

I like it! 

This also allows us to remove the anal checking & cleanup
duplicated in each and every driver to be removed.

So your solution will save lots of code at least in all PCI-only
drivers.

I even wrote my own routine that does exactly that, to save the code.

Some people can not use pci_enable_resources(), because sometimes
one of the resources is a PCI-Interface chip, that has a
different driver, which enabled one resource already itself.

So splitting this out alone is already a win.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
