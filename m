Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTH0QeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTH0QeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:34:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:31123 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263567AbTH0QeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:34:21 -0400
Date: Wed, 27 Aug 2003 09:29:18 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: LGW <large@lilymarleen.de>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: porting driver to 2.6, still unknown relocs... :(
Message-Id: <20030827092918.0981fa71.rddunlap@osdl.org>
In-Reply-To: <3F4CD937.10204@lilymarleen.de>
References: <3F4CB452.2060207@lilymarleen.de>
	<20030827081312.7563d8f9.rddunlap@osdl.org>
	<3F4CCF85.1020502@lilymarleen.de>
	<1061999977.22825.71.camel@dhcp23.swansea.linux.org.uk>
	<3F4CD937.10204@lilymarleen.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 18:15:51 +0200 LGW <large@lilymarleen.de> wrote:

| Alan Cox wrote:
| 
| >On Mer, 2003-08-27 at 16:34, LGW wrote:
| >  
| >
| >>The driver is mostly a wrapper around a generic driver released by the 
| >>manufacturer, and that's written in C++. But it worked like this for the 
| >>2.4.x kernel series, so I think it has something todo with the new 
| >>module loader code. Possibly ld misses something when linking the object 
| >>specific stuff like constructors?
| >>    
| >>
| >
| >The new module loader is kernel side, it may well not know some of the
| >C++ specific relocation types. 
| >
| To you think it's possible to remove those relocations completely, so 
| that the whole C++ stuff is linked "without" any more open relocations?

Hopefully Rusty will see this and make some comments on it.

You could try using objdump to look for the item(s) that have this
relocation type (0).  That might help to see what is causing it.

Or you could modify the module loader to ignore relocation type 0...
and see what happens.

| After all, those are only "helper functions" that could be linked 
| "statically", or am I mistaken?
| 
| I don't have such deep knowledge of the C++ linking process, so I can't 
| answer that question myself.
| 
| The Generic Driver is not public available I think, but you could get it 
| here:
| http://space.virgilio.it/g_pochini@virgilio.it/ea.html (site with the 
| patches for alsa)
| http://space.virgilio.it/g_pochini@virgilio.it/eagd-0.6.0.tar.bz2 (the 
| original generic driver code)

--
~Randy
