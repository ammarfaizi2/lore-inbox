Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSBMPpk>; Wed, 13 Feb 2002 10:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSBMPpV>; Wed, 13 Feb 2002 10:45:21 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:44745 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S286893AbSBMPpO>; Wed, 13 Feb 2002 10:45:14 -0500
Message-Id: <200202131419.g1DEJeUJ001359@tigger.cs.uni-dortmund.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Tue, 12 Feb 2002 18:23:16 +0100." <E16ageE-0001Te-00@starship.berlin> 
Date: Wed, 13 Feb 2002 15:19:39 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> said:
> On February 12, 2002 05:38 pm, Bill Davidsen wrote:

[...]

> > No trick other than to read what I said in either of the previous posts...
> > the question was not how to avoid having the useful feature, but how to
> > put it somewhere to avoid increasing the kernel size. I suggested in the
> > modules directory, either as a text file or as a module.

> We are in violent agreement, I'm not sure where the misunderstanding came
> from.  Yes, the leading idea is to put it in a module.  In fact a patch
> exists, though it may have issues, it's been a while since I looked at
> it.

A module can get displaced as easily as a plain text file, and the wrong
"configutarion module" version won't do any good in any case.

Just teach /sbin/installkernel (or arch/i386/install.sh) to stash it away
somewhere. You'll need to fix arch/i386/Makefile to pass the name of
.config to the script (note that it now takes 3 or 4 arguments, to get
backwards compatibility when taking 3, 4 or 5 will be tricky, unless you
play games with the name of the files passed into it to figure out where
.config lives). Or call a new script  if it is there and only give that one
.config plus the standard stuff.
-- 
Horst von Brand			     http://counter.li.org # 22616
