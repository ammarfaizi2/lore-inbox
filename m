Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131973AbRDTV0C>; Fri, 20 Apr 2001 17:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbRDTVZr>; Fri, 20 Apr 2001 17:25:47 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:50415 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131899AbRDTVZa>; Fri, 20 Apr 2001 17:25:30 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104202123.f3KLNWSm031572@webber.adilger.int>
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone
 paying attention?
In-Reply-To: <20010420195004.A5510@flint.arm.linux.org.uk> "from Russell King
 at Apr 20, 2001 07:50:04 pm"
To: Russell King <rmk@arm.linux.org.uk>
Date: Fri, 20 Apr 2001 15:23:32 -0600 (MDT)
CC: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> - Secondly, its very easy to miss stuff in the lkml hunk of email each
>   day when you have less than 4 hours to read it and think about it.
>   (note that architecture maintainers have to read mail from their
>   side which may not be on lkml, think about that, think about bug fixes,
>   possible impacts of fixes on other machines, etc etc).  Therefore,
>   copying their email address registered in the MAINTAINER file means
>   that they should not overlook your patch.

One of the issues for contacting each MAINTAINER is that this information
is out-of-line from the actual kernel tree.  The other is that the
description of what a maintainer is actually controlling is somewhat
vague.

How about the following:
- each directory has a MAINTAINERS file which lists parties with a
  vested interest in files in that directory (format is mostly the
  same as current)
- subdirectories which don't have a MAINTAINERS file use the MAINTAINERS
  file of the parent (or grandparent) directory
- each maintainer entry explicitly lists each file/directory that this
  person is interested in, maybe "F: {file | directory} ...".

I'm sure Eric can come up with a simple program to parse the MAINTAINER
file/tree.  If the program takes a kernel-tree relative filename and
spit out the name/email of the relevant maintainer (subsystem and port
specific mailing lists should also be included), that would make the 
job of finding out who to send patches to a whole lot easier.

My one gripe about the MAINTAINERS file is that it still lists Remy
Card as EXT2 maintainer, so we would probably need to do a find on
the whole kernel tree, email each address a list of files that they
"maintain" and wait until they complain, agree, or time out.  Once
the database is up-to-date, it simplifies the job of keeping maintainers
(and other interested parties) in the loop.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
