Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315794AbSFESUa>; Wed, 5 Jun 2002 14:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSFESU2>; Wed, 5 Jun 2002 14:20:28 -0400
Received: from mark.mielke.cc ([216.209.85.42]:59912 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S315794AbSFESUA>;
	Wed, 5 Jun 2002 14:20:00 -0400
Date: Wed, 5 Jun 2002 14:13:25 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: John Cowan <jcowan@reutershealth.com>
Cc: Keith Owens <kaos@ocs.com.au>, Alexander.Riesen@synopsys.com,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, release 3.0 is available
Message-ID: <20020605141325.B23183@mark.mielke.cc>
In-Reply-To: <17931.1023231335@ocs3.intra.ocs.com.au> <200206050224.WAA00121@mail.reutershealth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 10:25:20PM -0400, John Cowan wrote:
> Keith Owens scripsit:
> > In order to do separate source and object correctly, kbuild 2.5
> > enforces the rule that #include "" comes from the local directory,
> > #include <> comes from the include path.  include/linux/zlib.h
> > incorrectly does #include "zconf.h" instead of #include <linux/zconf.h>,
> > breaking the rules.
> This is not the standard gcc behavior, however; quoted-includes
> can come from the include path, although the current directory
> is searched first.  The purpose of <>-includes is to suppress
> searching the current directory.

It raises the question 'who not always use #include "..."'?

In the case of a tool that generates dependencies for a source file,
the difference is sensibility.

In other cases, it is just common sense.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

