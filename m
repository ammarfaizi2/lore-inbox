Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRB1THP>; Wed, 28 Feb 2001 14:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRB1THG>; Wed, 28 Feb 2001 14:07:06 -0500
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:39175 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129184AbRB1TGz>; Wed, 28 Feb 2001 14:06:55 -0500
Date: Wed, 28 Feb 2001 11:06:52 -0800
Message-Id: <200102281906.f1SJ6qS02383@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <Pine.GSO.4.21.0102281302230.7107-100000@weyl.math.psu.edu>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001 13:07:29 -0500 (EST), Alexander Viro <viro@math.psu.edu> wrote:

> On Wed, 28 Feb 2001, David L. Parsley wrote:

>> Yeah, mount --bind is cool, I've been using it on one of my projects
>> today.  But - maybe I'm just not thinking creatively enough - what are
>> the advantages of mount --bind versus just symlinking?
> 
> 1) Correctly working ".." (obviously relevant only for directories)
> 2) Try to create symlinks on read-only NFS mount. For bonus points, try
> to do that one one client without disturbing everybody else.
> 3) Try to make it different for different users, for that matter.

And disadvantages: you can't have broken symlinks.

This actually turns out to be quite a bit of a problem when one tries
to use bind mounts with autofs. For one thing, it's perfectly legal
to have /autofs/foo as a symlink to /autofs/bar/foo, where /autofs/bar
is not yet mounted -- but a bind mount can't handle that...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
