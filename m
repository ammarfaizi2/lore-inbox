Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbTH0P4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTH0PzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:55:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:29927 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263429AbTH0Py6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:54:58 -0400
Date: Wed, 27 Aug 2003 08:50:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: LGW <large@lilymarleen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: porting driver to 2.6, still unknown relocs... :(
Message-Id: <20030827085000.3726a502.rddunlap@osdl.org>
In-Reply-To: <3F4CCF85.1020502@lilymarleen.de>
References: <3F4CB452.2060207@lilymarleen.de>
	<20030827081312.7563d8f9.rddunlap@osdl.org>
	<3F4CCF85.1020502@lilymarleen.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 17:34:29 +0200 LGW <large@lilymarleen.de> wrote:

| Randy.Dunlap wrote:
| 
| >On Wed, 27 Aug 2003 15:38:26 +0200 LGW <large@lilymarleen.de> wrote:
| >
| >| Now I wonder, what would be an relocation type 0? The printk should also 
| >| print the type in clear text I think, but it just prints 0. 0 also does 
| >| not look very much like a valid value at all, or does it?

In 2.6.0, include/asm-i386/elf.h lists the ELF relocation types.
Type 0 is "R_386_NONE".  Apparently something is being generated
with "no relocation needed" if I interpret this correctly (?).

| >Maybe g++ generates something different?
| >Are parts of your driver in c++?
| >
| I think the g++ is the problem, but I'm not sure what it is.
| 
| The driver is mostly a wrapper around a generic driver released by the 
| manufacturer, and that's written in C++. But it worked like this for the 
| 2.4.x kernel series, so I think it has something todo with the new 
| module loader code. Possibly ld misses something when linking the object 
| specific stuff like constructors?

Maybe.  It probably wasn't meant to support C++.

Is the generic driver source code available?

| I don't think there are any other errors in the module (like 
| incompatible MODULE_stuff or missing statements), as it has been copied 
| from a patched alsa-0.9.6, and I diff'd the other drivers, not finding 
| much differences (if any).
| 
| Any ld parameters I could try? I already tried -Ur, but that lead to 
| nothing :(

--
~Randy
