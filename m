Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293119AbSCJRUg>; Sun, 10 Mar 2002 12:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293120AbSCJRUZ>; Sun, 10 Mar 2002 12:20:25 -0500
Received: from mercury.chembio.ntnu.no ([129.241.80.86]:26129 "EHLO
	mercury.chembio.ntnu.no") by vger.kernel.org with ESMTP
	id <S293119AbSCJRUU>; Sun, 10 Mar 2002 12:20:20 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RPM build target fixes
In-Reply-To: <E16k2v8-0006QY-00@the-village.bc.nu>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 10 Mar 2002 18:17:50 +0100
In-Reply-To: <E16k2v8-0006QY-00@the-village.bc.nu>
Message-ID: <m37kok8hq9.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > Thats exactly the opposite of what is expected
> > 
> > How so? Given that it actually cleans up after itself you are not left
> > with multiple .spec files in any directory? Or have I missed something?
> 
> Most source rpm packages come with a [packagename.spec] file without a 
> version.
> 

OK, so the .spec in the tarball should be without (for rpm -ta), and
the one left in %_topdir/SPECS should carry it?

Basically why I made the .spec files carry the version was that I have
several trees (linux-2.4-[ac|plain|clean|mystuff] and
linux-2.5-[dj|plain|clean]) and that way I can build the trees without
interfering with eachoter, as all the .spec files, tarballs, RPMs and
SRPMs will actually be named something like
kernel-$version-$extraversion. That way, if you build two trees they
wont stamp on eachother.

ttfn,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
