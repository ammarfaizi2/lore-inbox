Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262488AbTCRPHD>; Tue, 18 Mar 2003 10:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262489AbTCRPHD>; Tue, 18 Mar 2003 10:07:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6924 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262488AbTCRPHC>; Tue, 18 Mar 2003 10:07:02 -0500
Date: Tue, 18 Mar 2003 07:16:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: CaT <cat@zip.com.au>
cc: Roman Zippel <zippel@linux-m68k.org>, <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65
In-Reply-To: <20030318103557.GF504@zip.com.au>
Message-ID: <Pine.LNX.4.44.0303180714140.11305-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Mar 2003, CaT wrote:
> 
> Ahhh. So if I want module support but not use it as a module then I'm
> SOL?

Well, does it _work_ as a built-in? If it does, just send me a patch for 
the Kconfig file. 

A lot of the PCMCIA stuff (16-bit) historically _only_ works as modules,
because the old PCMCIA code depended on module unload to do a lot of the 
cleanups that the regular internal eject handling didn't do. But if that 
driver works for you built-in, then the Kconfig file itself is simply just 
wrong.

		Linus

