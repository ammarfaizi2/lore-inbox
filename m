Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314554AbSEBPTU>; Thu, 2 May 2002 11:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314555AbSEBPTT>; Thu, 2 May 2002 11:19:19 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:60411 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314554AbSEBPTQ>; Thu, 2 May 2002 11:19:16 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0205020913390.32217-100000@chaos.physics.uiowa.edu> 
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 May 2002 16:18:42 +0100
Message-ID: <27186.1020352722@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kai@tp1.ruhr-uni-bochum.de said:
> > kbuild 2.5 deliberately does not support modversions, you can turn it
> > on but it does nothing.  The original implementation of modversions
> > does not fit with the way that people build kernels now (apply
> > patches, change configs, rebuild without make mrproper).  To do
> > modversions right needs a new version of modutils as well, there
> > is no chance of that work being started until kbuild 2.5 is in 
> > the kernel.

> I would like to object here. Getting dependencies right for
> modversions is very much possible in principle, after all modversions
> are generated in a deterministic process. (It's also possible in
> practise, though it's quite a bit of work).

To what are you objecting? You aren't disagreeing with Keith here. He 
merely said that there's no chance of him working on modversions until
the newer build system that's sane w.r.t. dependencies is incorporated.

> Modversions is really essential for distributions, where it's badly
> needed to keep users from causing hard to track down crashes by
> inserting self-compiled or obtained from whereever else modules into a
> kernel which was compiled with a different config.

Distributions are unlikely to be shipping 2.5 kernels. As long as 
modversions can be reimplemented properly by the time 2.6 is released, 
what's the harm in disabling it for a while?

It's hard enough to keep kbuild-2.5 up to date with recent kernels as it 
is; let's not keep moving the goalposts by adding new requirements for the 
initial adoption -- once it's in and the makefiles are maintaining 
themselves, we can concentrate on reimplementing the niche features.

--
dwmw2


