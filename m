Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSBMPyC>; Wed, 13 Feb 2002 10:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287306AbSBMPxv>; Wed, 13 Feb 2002 10:53:51 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:8073 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287134AbSBMPxk>;
	Wed, 13 Feb 2002 10:53:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Re: How to check the kernel compile options ?
Date: Wed, 13 Feb 2002 16:58:23 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200202131419.g1DEJeUJ001359@tigger.cs.uni-dortmund.de>
In-Reply-To: <200202131419.g1DEJeUJ001359@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b1nb-0001p5-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 03:19 pm, Horst von Brand wrote:
> Daniel Phillips <phillips@bonn-fries.net> said:
> > On February 12, 2002 05:38 pm, Bill Davidsen wrote:
> 
> [...]
> 
> > > No trick other than to read what I said in either of the previous posts...
> > > the question was not how to avoid having the useful feature, but how to
> > > put it somewhere to avoid increasing the kernel size. I suggested in the
> > > modules directory, either as a text file or as a module.
> 
> > We are in violent agreement, I'm not sure where the misunderstanding came
> > from.  Yes, the leading idea is to put it in a module.  In fact a patch
> > exists, though it may have issues, it's been a while since I looked at
> > it.
> 
> A module can get displaced as easily as a plain text file, and the wrong
> "configutarion module" version won't do any good in any case.

Not necessarily, check out the work on bootfs, I think this can be adapted to
suit the purpose.  If the config is in a module then we'd normally want that
module to be one of the modules that is included in the boot image.

> Just teach /sbin/installkernel (or arch/i386/install.sh) to stash it away
> somewhere.

If that were satisfactory then there would be nobody posting to this thread.

> You'll need to fix arch/i386/Makefile to pass the name of
> .config to the script (note that it now takes 3 or 4 arguments, to get
> backwards compatibility when taking 3, 4 or 5 will be tricky, unless you
> play games with the name of the files passed into it to figure out where
> .config lives). Or call a new script  if it is there and only give that one
> .config plus the standard stuff.

There is no good way to know where you have put those things.  We're looking
for a tight coupling between the kernel image and metadata that describes
what's in it - like a label on an electronic component: stuck right on it,
not filed away in a filing cabinet.

-- 
Daniel
