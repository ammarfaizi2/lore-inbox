Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316060AbSEWEt2>; Thu, 23 May 2002 00:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316067AbSEWEt1>; Thu, 23 May 2002 00:49:27 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:40204
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316060AbSEWEt0>; Thu, 23 May 2002 00:49:26 -0400
Date: Wed, 22 May 2002 21:49:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: It hurts when I shoot myself in the foot
Message-ID: <20020523044933.GB4006@matchmail.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205221615.g4MGFCH30271@directcommunications.net> <acha7p$cge$1@cesium.transmeta.com> <20020523034821.GK458@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 09:48:21PM -0600, Andreas Dilger wrote:
> On May 22, 2002  16:39 -0700, H. Peter Anvin wrote:
> > Followup to:  <200205221615.g4MGFCH30271@directcommunications.net>
> > By author:    Chris <chris@directcommunications.net>
> > In newsgroup: linux.dev.kernel
> > > 
> > > I looked inside the box and found a Pentium II 400, and a Pentium II 450.
> > > 
> > > Oddly enough they run together as a 266.
> > 
> > The fact that they have different BogoMIPS figures indicate that that
> > is not really the case.  It looks more like the second processor is
> > running at 333 MHz or something.  You definitely have a bizarre box
> > here, and you probably should be running with the "notsc" option.
> > Heck, maybe you can reconfigure your mobo and actually run both
> > processors at 400 MHz.  You'd get quite a performance boost, too...
> 
> There was a kernel patch posted about5 or so months ago which would
> "handle" this setup (CPUs with the same clock speed, but different
> multipliers).  Alan Cox said it probably was a bad idea, so it wouldn't
> go into the kernel, but the patch may still be usable.
> 
> This is sometimes called "asymmetric multiprocessing", and the thread
> is at http://marc.theaimsgroup.com/?l=linux-kernel&m=98519070331478&w=4

I thought asymmetric multiprocessing would support CPUs with different
speeds.  ie, 400 & 450mhz.  How would you get different multipliers and same
Mhz when the CPUs are on the same FSB(ignoring AMD SMP where each processor
has an exclusive FSB, and this might be possible)?

IIRC, Linux supports SMP on CPUs with different stepping as long as the
features are the same, and even then it'll use the features of the boot CPU.
There was a patch to compare the different features on the CPUs available
and use the subset available on all processors.

Mike
