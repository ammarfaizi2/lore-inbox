Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293190AbSCJTmd>; Sun, 10 Mar 2002 14:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293199AbSCJTmY>; Sun, 10 Mar 2002 14:42:24 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:64700 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S293190AbSCJTmH>; Sun, 10 Mar 2002 14:42:07 -0500
Message-Id: <200203101941.g2AJfSD19756@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <itai@siftology.com>
To: Hans Reiser <reiser@namesys.com>, Larry McVoy <lm@bitmover.com>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Date: Sun, 10 Mar 2002 21:41:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207132558.D27932@work.bitmover.com> <3C8B1B25.7000208@namesys.com>
In-Reply-To: <3C8B1B25.7000208@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 March 2002 10:36, Hans Reiser wrote:
> I think that if version control becomes as simple as turning on a plugin
> for a directory or file, and then adding a little to the end of a
> filename to see and list the old versions, Mom can use it.

IIRC that was a feature in systems from DEC even before
VMS (I'm talking about the late 70's).  eg. file.txt;2 was revision 2
of file.txt.

I don't know if this feature was in the file-system or in the text editor
that I have used.

The basic features were not even close to what you get from RCS or
SCCS.

>
> Besides, version control is useful for distributed filesystem designs
> (high-performance distributed parallel writes work better with version
> control in use.)

That's a different topic, and it depends on system's design. Distributed
filesystem may use some form of a file's version to control the caching
(or locking) of data. In that case just any monotonic value will do.
All the version control systems that I know use file granularity version
numbers (or tags), while for distributed file systems you may want to use
anything between single block and full directory granularity - depending
on the typical access patterns.

There are some recent discussions in the Linux Kernel mailing list
about adding "undelete" and ACL features. Well.. I think of "undelete"
as the most primitive form of a version control (you keep one version back).
Add support for extended attributes (where you can store some extra
metadata) and the rest can be done in the VFS layer. Still far away
from a full featured SCM...

-- Itai Nahshon
