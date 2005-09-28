Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVI1WBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVI1WBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVI1WBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:01:44 -0400
Received: from ns.firmix.at ([62.141.48.66]:12179 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751103AbVI1WBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:01:42 -0400
Subject: Re: fat / multi arch binaries?
From: Bernd Petrovitsch <bernd@firmix.at>
To: Antonio Vargas <windenntw@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <69304d110509281029a1b028a@mail.gmail.com>
References: <200509281918.56386.aj@dungeon.inka.de>
	 <69304d110509281029a1b028a@mail.gmail.com>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Wed, 28 Sep 2005 23:58:53 +0200
Message-Id: <1127944733.3340.6.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 19:29 +0200, Antonio Vargas wrote:
> On 9/28/05, Andreas Jellinghaus <aj@dungeon.inka.de> wrote:
[...]
> > does linux support binaries with code
> > for several architectures? I read that
> > elf allowes that, and for example
> > apple plans to use it on mac os X,
> > but I couldn't find anything whether
> > such binaries would work with linux
> > or not. can you tell me?
> 
> OSX begat from NeXT and NeXT had these same "fat binaries". They are not new :)

Yup. For 4 archs IIRC.

> > if linux supports that, it should
> > also work for merging x86 and x86_64
> > into one binary? would ther be a way
> 
> you don't want that ;)

ACK. It boils down to have n (i.e. lots of) cross-compilers installed.
Compiling needs n times as much time - you compile once for every
architecture. The binaries get much larger. You have to store and
transport them at startup (OK, this is pretty pathetic.) And then the
shared loader/kernel throws n-1 versions away.
On NeXT folks started to disable the FAT binaries just because of these
reasons.
ANd I hear the Intel-using world moan if they det on Debian >10 times as
large binaroes just to support MIPS and 68k ....

> > to run the 32bit version in the 64bit
> > kernel, if requested? are there any
> 
> 32bit user-space can run 100% on 64bit kernel, this is usual in sparc
> if i'm not mistaken

And on Linux too. OO.org is on the major distros only as 32bit available
and runs "natively" on x86_64.
Actually the example is not that good.

> > tools to create such binaries?
> >
> > with google I found info from 97
> > that indicades elf format has no
> > provision for fat binaries and linux
> > doesn't support them. is that still
> > true?
> 
> just remember that linux is mainly about source access, so having
> "fat" binaries is just wrong because the one-true-way is to get the
> sources and compile for your arch directly. this can be done by hand,
> semi-automated (aka gentoo) or automated (aka debian, fedora, etc...)
> by just installing from precompiled binaries

ACK. With apt-get/yum/portage/... most of the problems which were solved
with fat binaries a decade ago are already solved.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



