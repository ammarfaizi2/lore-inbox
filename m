Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275566AbTHMVDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275568AbTHMVDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:03:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55781 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275566AbTHMVDg (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:03:36 -0400
Date: Wed, 13 Aug 2003 23:03:28 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Bradford <john@grabjohn.com>
Cc: jgarzik@pobox.com, davidsen@tmr.com, Linux-Kernel@vger.kernel.org,
       Riley@Williams.Name, szepe@pinerecords.com
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030813210328.GM569@fs.tum.de>
References: <200308132040.h7DKe7VK002065@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308132040.h7DKe7VK002065@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 09:40:07PM +0100, John Bradford wrote:
> > > The people who want Linux to be reliable won't be compiling their own
> > > kernels, typically.  Because, the people that _do_ compile their own
> > > kernels have sense enough to disable broken drivers :)  That's what Red
> > > Hat, SuSE, and others do today.
> >
> > It occurs quite often that you need e.g. the latest -pre or -ac to
> > support some of your hardware.
> >
> > These are situations when an average systems administrator has to 
> > compile his on kernel.
> 
> That is true.  The point is that I don't see how adding an arbitrary
> dependency on a CONFIG_BROKEN option actually helps in any way.
>...
> compile, there is a problem anyway.  If they are hidden under a
> CONFIG_BROKEN option, it's just an extra step to enable them, then
> compile with them enabled to get an error to post to LKML.
>...

You don't accidentially enable such an option.

Currently, I see every day reports about compile errors on
linux-kernel - reports for errors that are known and unfixed since 
several months.

A dependency on BROKEN is a clear mark that a compile error is already 
known.

My personal opinions:
- Ideally, every valid configuration should result in a kernel that
  both compiles and works.
- Every compile error gives a bad impression of the quality of the 
  Linux kernel.

Current 2.4 kernels are (on i386) relatively near to this ideal.

It's not only a technical aspect, it's also a marketing aspect.  With
many broken drivers it's easy for people to argue against Linux using
arguments like

  Look, what a crap Linux is, the developers even care whether the 
  kernel compiles.

> John.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

