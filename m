Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266158AbRGGNaq>; Sat, 7 Jul 2001 09:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbRGGNah>; Sat, 7 Jul 2001 09:30:37 -0400
Received: from pille1.addcom.de ([62.96.128.35]:58642 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S266158AbRGGNaZ>;
	Sat, 7 Jul 2001 09:30:25 -0400
Date: Sat, 7 Jul 2001 15:23:23 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Russell King <rmk@arm.linux.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6 PCMCIA NET modular build breakage
In-Reply-To: <20010707101657.C10927@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0107071520250.1054-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jul 2001, Russell King wrote:

> Seems like its something that appeared between 2.4.5 and 2.4.6.  Anyone
> know the correct fix, other than reversing the change?

It should be fine.

> Since all net cards are modules, object list for pcmcia_net.o is empty and
> kernel can't be linked.

Could you reproduce this? (I don't think you can)

Rules.make takes care of an empty $(obj-y) and builds an empty $(O_TARGET) 
file in this case, so linking this in should work fine.

--Kai

