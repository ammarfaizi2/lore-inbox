Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSFMRDw>; Thu, 13 Jun 2002 13:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317780AbSFMRDv>; Thu, 13 Jun 2002 13:03:51 -0400
Received: from hm61.locaweb.com.br ([200.213.197.161]:35764 "HELO
	hm61.locaweb.com.br") by vger.kernel.org with SMTP
	id <S317536AbSFMRDu>; Thu, 13 Jun 2002 13:03:50 -0400
Message-ID: <20020613170349.5226.qmail@hm36.locaweb.com.br>
From: "Renato" <webmaster@cienciapura.com.br>
Date: Thu, 13 Jun 2002 14:03:49
To: "Leech, Christopher" <christopher.leech@intel.com>,
        linux-kernel@vger.kernel.org
Subject: RE: Problems with e1000 driver and ksoftirqd_CPU0
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C1540@orsmsx118.jf.intel.com>
X-Mailer: LocaWeb Mail
X-IPAddress: 200.192.44.199
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did the upgrade. It looks like it helped a lot. Right now I'm afraid that 
I'll have a CPU bottleneck soon... Do you have any benchmark of how much 
traffic, let's say on a Intel Dual Xeon 2Ghz, could handle ? Right now my 
traffic is almost 100Mbps and idle processing is about 50%.

Thanks !!

On Thu, 13 Jun 2002 09:54:03 -0700, "Leech, Christopher" 
<christopher.leech@intel.com> escreveu :

> De: "Leech, Christopher" <christopher.leech@intel.com>
> Data: Thu, 13 Jun 2002 09:54:03 -0700
> Para: "'Renato'" <webmaster@cienciapura.com.br>, linux-
kernel@vger.kernel.org
> Assunto: RE: Problems with e1000 driver and ksoftirqd_CPU0
> 
> Due to time constraints and wanting to have a stable and tested driver on
> the distribution, Red Hat's latest kernels have the last released version 
of
> e1000 before we started doing some major cleanup in preparation for 
merging
> e1000 into the standard kernel distribution.  One of the "features" that 
was
> removed since then is the use of a tasklet for receive buffer allocation,
> which under certain loads can be a horrible thing.
> 
> I would highly recommend trying e1000 4.2.17, either the version found in
> the latest 2.5 kernels or from Intel.  The version on Intel's site has 
some
> additional backwards compatibility code for 2.2 support and a few
> non-standard features that can easily be disabled at the top of the 
makefile
> if you don't want them.  On the plus side it's setup to easily build 
outside
> of the kernel source tree if you want to test it without patching and
> rebuilding the kernel.
> 
> J.A. Magallon posted a backport of the driver from 2.5 to 2.4 early last
> week @ http://giga.cps.unizar.es/~magallon/linux/driver/e1000-4.2.17-
k1.bz2
> 
> The latest version from Intel can always be found @
> http://support.intel.com/support/go/linux/e1000.htm
> 
> --
> Chris Leech <christopher.leech@intel.com>
> Network Software Engineer
> LAN Access Division, Intel Corporation
> 
> > -----Original Message-----
> > From: Renato [mailto:webmaster@cienciapura.com.br] 
> > Sent: Tuesday, June 11, 2002 3:50 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: Problems with e1000 driver and ksoftirqd_CPU0
> > 
> > 
> > Hi all,
> > 
> > I'm just using the latest kernel from RedHat - 2.4.18-4smp ( which I 
> > suppose it mostly -ac series ) and I'm having real problems with an 
> > Ethernet Gigabit network. It looks like "ksoftirqd_CPU0" eats 
> > up all the 
> > CPU processing with a traffic of just 55 Mbps !! ( it's not 
> > my hardware... 
> > I'm using a Dual Xeon 2Ghz and with kernel 2.4.9 it could 
> > handle easily 85 
> > Mbps ) 
> 
> 
> 
