Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268729AbUIGWoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268729AbUIGWoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbUIGWoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:44:20 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:2780 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268722AbUIGWoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:44:08 -0400
To: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Cc: Christer Weinigel <christer@weinigel.se>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Tonnerre <tonnerre@thundrix.ch>,
       Spam <spam@tnonline.net>, ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, Jamie Lokier <jamie@shareable.org>,
       Christoph Hellwig <hch@lst.de>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Chris Wedgwood <cw@f00f.org>
Subject: Re: silent semantic changes with reiser4
References: <200409070206.i8726vrG006493@localhost.localdomain>
	<413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
	<1183150024.20040907143346@tnonline.net>
	<413DD5B4.nailC801GI4E2@pluto.uni-freiburg.de>
	<m34qm9kbcl.fsf@zoo.weinigel.se>
	<413E3280.nailEK92X8CU7@pluto.uni-freiburg.de>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 08 Sep 2004 00:44:07 +0200
In-Reply-To: <413E3280.nailEK92X8CU7@pluto.uni-freiburg.de>
Message-ID: <m3n001its8.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de> writes:

> Excuse me, but there's really nothing broken here with POSIX and cp.
> You're just making an insulting talk about a part of the specification
> which currently serves GNU/Linux and other Unix-like environments very
> well, and has done so for about twelve years now.

"Broken" in the sense "POSIX mandates something that users wouldn't
expect".

> > cp could very well be modified to copy named streams except when
> > the option --posix is specified
> 
> Hey, you didn't ever even have a look at POSIX Shell & Utilities, did
> you? Then why are you making derogatory statements about it?

Those derogatory statments are really all in your mind.  

> > or the environment variale POSIXLY_CORRECT is set.
> 
> Cool, data loss depending upon an environment variable which is even
> currently used by many programs unaware of such results. This really
> sounds like good engineering to me.

How would you consider cp to cause "data loss" if it _besides_ copying
the normal stream _also_ copied any named streams or xattrs belonging
to the stream?  How would it cause data loss if cp started using a
theoretical copyfile syscall?  It may not be 100% according to POSIX,
but I'd definitely say that it does what the user expects.

Lots of GNU utilities already differ from POSIX mandated behaviour
because the authors of those utilities belive that the POSIX mandated
behaviour is confusing.

http://www.wlug.org.nz/POSIXLY_CORRECT

    POSIXLY_CORRECT is an environment variable that some programs use
    to follow strict POSIX standards behaviour, where that isn't the
    default.

    Probably the most well-known example of this is that POSIX states
    that filesystem blocks are 512 bytes per block, so the GNU
    fileutils such as df(1) and GNU tar(1) use 512 if the variable
    POSIXLY_CORRECT is set, and 1024 bytes per block by default.

    Many of the GNU tools comply with POSIX by default, except for
    where the author thinks the POSIX standard is wrong or dumb. :) As
    a result, some programs also check if a variable named
    POSIX_ME_HARDER is set as an acceptable alias for
    POSIXLY_CORRECT. See Democracy Triumphs in Disk Units.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
