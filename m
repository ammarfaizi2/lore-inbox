Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317944AbSFNQGb>; Fri, 14 Jun 2002 12:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSFNQGa>; Fri, 14 Jun 2002 12:06:30 -0400
Received: from host213-121-105-182.in-addr.btopenworld.com ([213.121.105.182]:22416
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S317944AbSFNQG2>; Fri, 14 Jun 2002 12:06:28 -0400
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
From: Matthew Hall <matt@ecsc.co.uk>
To: Donald Becker <becker@scyld.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0206131201480.1828-100000@presario>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: ECSC Ltd.
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 14 Jun 2002 17:06:19 +0100
Message-Id: <1024070779.972.53.camel@smelly.dark.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bother you again Donald, but I'm still having problems,
The following error comes up when I make modules with the 1.06 version:

sundance.c: In function `sundance_probe1':
sundance.c:464: `pci_tbl' undeclared (first use in this function)
sundance.c:464: (Each undeclared identifier is reported only once
sundance.c:464: for each function it appears in.)
sundance.c: In function `cleanup_module':
sundance.c:1372: `pci_tbl' undeclared (first use in this function)
make[2]: *** [sundance.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

I've checked the code of sundance.c, pci-scan.h and kern_compat.c and
pci_tbl isn't defined or declared anywhere in these files, am I missing
something else, or going crazy?
Thanks in advance,

Matthew Hall

On Thu, 2002-06-13 at 17:12, Donald Becker wrote:
> You are still running the old driver, not the driver at
>    http://www.scyld.com/network/ethercard.html
>       ftp://www.scyld.com/pub/network/sundance.c
> 
> > Just in case you can provide any more insight into this I compiled the
> > alta-diag tool, for debugging purposes, the results of -aa, -ee and -mm
> > are attached, aswell as the full detection message from dmesg after
> > modprob'ing the module.
> 
> I never released a "1.01b" driver in January 2002.  The 1.01a driver was
> released about two years ago.  The current version is
> sundance.c:v1.06 1/28/2002
> 
> The diagnostic program is reading the correct station address, however
> the driver you are using is reading a bogus address.  I believe that
> that my driver release should correctly work with this card.
> 


