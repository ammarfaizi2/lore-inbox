Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTCCPQC>; Mon, 3 Mar 2003 10:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbTCCPQC>; Mon, 3 Mar 2003 10:16:02 -0500
Received: from logic.net ([64.81.146.141]:45443 "EHLO logic.net")
	by vger.kernel.org with ESMTP id <S265543AbTCCPP7>;
	Mon, 3 Mar 2003 10:15:59 -0500
Date: Mon, 3 Mar 2003 09:26:26 -0600
From: "Edward S. Marshall" <esm@logic.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: diegocg@teleline.es, andrea@suse.de, hch@infradead.org,
       linux-kernel@vger.kernel.org, pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030303152626.GG16908@talus.logic.net>
References: <200303020223.SAA13660@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303020223.SAA13660@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 06:23:21PM -0800, Adam J. Richter wrote:
> 	Note that Subversion, in particular, is GPL incompatible and

http://subversion.tigris.org/project_license.html

I don't see anything particularly GPL-incompatible in there; looks pretty
much like a BSD-style license to me. Something that precludes SVN's use
by GPL'd projects, or precludes integration with GPL'd projects, is
something I'm sure CollabNet and the developers on the mailing list would
love to know about (along with all the Apache folks, since it's really
their license), considering that there's already at least on GPL'd
front-end for Subversion (gsvn), and plenty of GPL projects being hosted
in Subversion repositories.

(Not meant as a flame, please don't take it as such. I'd really like to
know where the Apache/Subversion license is "GPL-incompatible".)

> uses its own underlying repository format that isn't particularly
> compatible with anything else

Lacking an on-disk format that's actually useful for storing more
information than files and diffs, they invented one. I don't blame them.
The fun part, of course, is that svn is architected such that bolting up
to another repository storage system (say, an RDBMS, or even, horrors, a
bitkeeper-compatible SCCS derivative) is really just a matter of writing
the code (with a few caveats, obviously, but that's the basic idea).

"svnadmin dump" will provide a dumpfile of the repository, which could
be translated into another format, if that were desirable. Again, just a
simple matter of coding. ;-)

> and required a web server plus some
> minor web server extension when last I checked.

Not everyone is aware of this, but there's a new access method for svn
repositories that works with SSH, or as a standalone pserver-like scheme,
called "ra_svn". Translation: you no longer need Apache 2.0 and mod_dav
to access a Subversion repository; you just don't get some of the cool
features that using Apache gives you (such as all the access controls,
the availability of the repository via DAV and through a normal web
browser, etc).

This came about only a few milestones back, so it's not surprising that
everyone hasn't seen it yet. :-)

-- 
Edward S. Marshall <esm@logic.net>
http://esm.logic.net/

Felix qui potuit rerum cognoscere causas.
