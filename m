Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbRHJIYl>; Fri, 10 Aug 2001 04:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266040AbRHJIYb>; Fri, 10 Aug 2001 04:24:31 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:41420 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S266006AbRHJIYR>; Fri, 10 Aug 2001 04:24:17 -0400
Date: Fri, 10 Aug 2001 11:24:20 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>,
        Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: using bug reports on vendor kernels
Message-ID: <20010810112419.A55231@niksula.cs.hut.fi>
In-Reply-To: <01080923020201.04501@idun> <m15Ux92-000PTaC@amadeus.home.nl> <20010809173459.A24128@ead45> <20010809224635.A19529@fenrus.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010809224635.A19529@fenrus.demon.nl>; from arjan@fenrus.demon.nl on Thu, Aug 09, 2001 at 10:46:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 10:46:35PM +0100, you [Arjan van de Ven] claimed:
> On Thu, Aug 09, 2001 at 05:34:59PM -0400, Bill Rugolsky Jr. wrote:
> 
> > The real question is why not include the documentation with the patch?
> > As Linus will probably tell you, patch is pretty smart about stripping out stray
> > commentary, e.g.,
> > 
> > 	patch -p1 < ~/mail/apply
> > 
> 
> Doesn't help the people who don't want to look at all the patches but just
> want an overview.... and the spec file where the patches are applied does
> have (mostly 1 liners) documentation.

I proposed this before, but what about having one standard PATCHES file in
the kernel source tree, with all the applied pathes would touch

After having built a kernel, I could come back after months and see at one
glance what patches I (or somebody else) had applied and in what order.

Something like

cat PATCHES
+++++++++++++++++
patch: ac5
summary: Alan Cox kernel patch collection
url: ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.2
date: 05.04.2001
email: laughing@shared-source.org
+++++++++++++++++
patch: ide-04052001
summary: Hedrick IDE patch
url: ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/2.2
date: 05.04.2001
email: andre@linux-ide.org
+++++++++++++++++
patch: proconfig
summary: /proc .config support
url:  http://www.it.uc3m.es/~ptb/proconfig/
date: 06.08.2000
email: ptb@it.uc3m.es

etc etc. Every applied patch would append its info to that file. I'm not
sure, though, how that could be accomplished with patch, but if anything
else fails, PATCHES/-directory might do the job. Although then you lose the
apply order information.

And the compiled kernel could automagically have 
2.2.18-ac5+ide-04052001+proconfig suffix (if that's feasible - it could
become quite long.)


-- v --

v@iki.fi
