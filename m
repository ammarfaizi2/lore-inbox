Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbSKCOpA>; Sun, 3 Nov 2002 09:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbSKCOpA>; Sun, 3 Nov 2002 09:45:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9658 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262019AbSKCOo7>;
	Sun, 3 Nov 2002 09:44:59 -0500
Date: Sun, 3 Nov 2002 09:51:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <1036328636.29646.30.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0211030946300.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Nov 2002, Alan Cox wrote:

> The problem with this is its nontrivial to set up all the rules. Being
> able to use namespaces to revoke rights is a big help. If we were to add
> a capability for 'getting out of chroot' then we can also combine it
> with chroot to drop users into an unpriviledged universe from which they
> cannot escape because we took away the chroot stuff and we took away
> rawio and so on

No messing with chroot needed - just a way to irrevertibly turn off the
ability (for anybody) to do mounts/umounts in a given namespace and ability
to clone that namespace.  Then give them ramfs for root and bind whatever
you need in there.  No breaking out of that, since there is nothing below
their root where they could break out to...

