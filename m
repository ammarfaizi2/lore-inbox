Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbSKCD5j>; Sat, 2 Nov 2002 22:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSKCD5j>; Sat, 2 Nov 2002 22:57:39 -0500
Received: from mail.gurulabs.com ([208.177.141.7]:33690 "EHLO
	mail.gurulabs.com") by vger.kernel.org with ESMTP
	id <S261601AbSKCD5h>; Sat, 2 Nov 2002 22:57:37 -0500
Date: Sat, 2 Nov 2002 21:04:07 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "davej@suse.de" <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0211022101090.20616-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Alexander Viro wrote:

> 	<shrug> that can be done without doing anything to filesystem.
> Namely, turn current "nosuid" of vfsmount into a mask of capabilities.
> Then use bindings instead of links.  *Note* - binary _is_ marked suid,
> mask tells which capabilities _not_ to gain.  It's OK - attempt to
> link(2) to the thing using binding will see that oldname and newname
> are within different vfsmounts, so instead of link to suid-root binary
> you get -EXDEV.

Any thoughts on how /usr/bin/(rpm|dpkg) copes with setting up the binding
when installing a package?

Dax


