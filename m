Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTLAVPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbTLAVPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:15:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:50846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264147AbTLAVOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:14:14 -0500
Date: Mon, 1 Dec 2003 13:07:20 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Stan Zitello <stan_zitello@bellsouth.net>
Cc: linux-kernel@vger.kernel.org, tim@cyberelk.net
Subject: Re: IEEE1284 (Parallel Port) Kernel Build Problem
Message-Id: <20031201130720.0275bbee.rddunlap@osdl.org>
In-Reply-To: <20031128134649.2a5ecd26.stan_zitello@bellsouth.net>
References: <20031128134649.2a5ecd26.stan_zitello@bellsouth.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Nov 2003 13:46:49 -0500 Stan Zitello <stan_zitello@bellsouth.net> wrote:

| ** Please CC me on any replies, as I am not subscribed to the mailing list **
| 
| It appears that the build process for the parport.o and parport_pc.o kernel
| modules is not properly picking up the value of 'CONFIG_PARPORT_1284'.  Even
| though my .config file contains 'CONFIG_PARPORT_1284=y', a build of the kernel
| does not successfully include IEEE1284 support, as evidenced by this message
| in the system log file:
| 
| kernel: parport: IEEE1284 not supported in this kernel
| 
| I was able to generate a simple workaround, which I verified works, by adding 
| a "#define" to the relevant source code in drivers/parport/.  I would have
| preferred to have found the actual build problem, but I must admit to not being
| able to completely decipher the build process...sorry.
| 
| I am not sure if this is relevant, but you will notice that my entire parallel
| port support is via modules. The rest of the relevant entrys from .config:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
So IEEE1284 support is also built into those modules.

I used these same .config settings except with PARPORT_PC_PCMCIA not set
and the IEEE1284 code is compiled into the parport.o module file.
And it's not just the stubs for "IEEE1284 not supported in this kernel".

Are you sure that you have loaded the correct parport*.o modules?
If so, please post more of your kernel log file, showing the surrounding
messages as well.

| #
| # Parallel port support
| #
| CONFIG_PARPORT=m
| CONFIG_PARPORT_PC=m
| CONFIG_PARPORT_PC_CML1=m
| # CONFIG_PARPORT_SERIAL is not set
| # CONFIG_PARPORT_PC_FIFO is not set
| # CONFIG_PARPORT_PC_SUPERIO is not set
| CONFIG_PARPORT_PC_PCMCIA=m
| # CONFIG_PARPORT_AMIGA is not set
| # CONFIG_PARPORT_MFC3 is not set
| # CONFIG_PARPORT_ATARI is not set
| # CONFIG_PARPORT_GSC is not set
| # CONFIG_PARPORT_SUNBPP is not set
| # CONFIG_PARPORT_OTHER is not set
| CONFIG_PARPORT_1284=y
| 
| IF it helps:
| Linux llinuxi 2.4.22 #2 Wed Nov 26 13:39:27 EST 2003 i686 unknown
|  
| Gnu C                  3.2
| Gnu make               3.79.1
| util-linux             2.11u
| mount                  2.11u
| modutils               2.4.19
| e2fsprogs              1.27
| Linux C Library        2.2.5
| Dynamic linker (ldd)   2.2.5
| Linux C++ Library      5.0.0
| Procps                 2.0.7
| Net-tools              1.60
| Kbd		       1.06
| Sh-utils               2.0
| Modules Loaded         qcamvc_pp qcamvc videodev maestro3 rtc apm 3c59x ppp_deflate zlib_deflate ppp_async ppp_generic slhc lp parport_pc parport

--
~Randy
MOTD:  Always include version info.
