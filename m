Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314544AbSDSERD>; Fri, 19 Apr 2002 00:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314545AbSDSERC>; Fri, 19 Apr 2002 00:17:02 -0400
Received: from mark.mielke.cc ([216.209.85.42]:40200 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S314544AbSDSERB>;
	Fri, 19 Apr 2002 00:17:01 -0400
Date: Fri, 19 Apr 2002 00:12:08 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Stevie O <stevie@qrpff.net>
Cc: Larry McVoy <lm@bitmover.com>, Kent Borg <kentborg@borg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Versioning File Systems?
Message-ID: <20020419001208.A14615@mark.mielke.cc>
In-Reply-To: <20020418110558.A16135@borg.org> <20020418110558.A16135@borg.org> <20020418082025.N2710@work.bitmover.com> <5.1.0.14.2.20020418191904.028f1290@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 07:19:47PM -0400, Stevie O wrote:
> At 08:20 AM 4/18/2002 -0700, Larry McVoy wrote:
> >It's certainly a fun space, file system hacking is always fun.  There
> >doesn't seem to be a good match between file system operations and
> >SCM operations, especially stuff like checkin.  write != checkin.
> >But you can handle that with
> How about
>         fsync(fd) || close(fd) == checkin?

Source management systems usually work much better given explicit
control for the user.

ClearCase has MVFS to do what is being suggested. Compare:

    cat a.c                 # currently selected version of a.c
    cat a.c@@/main/5        # version 5 on the main branch

    cat a.c@@LINUX_2.4.18   # the version of a.c selected by the
                            # label 'LINUX_2.4.18'

Having a file system that implicitly performs these operations is
not very useful.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

