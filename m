Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131750AbRCQRwo>; Sat, 17 Mar 2001 12:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131759AbRCQRwe>; Sat, 17 Mar 2001 12:52:34 -0500
Received: from imladris.infradead.org ([194.205.184.45]:43278 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S131750AbRCQRwQ>;
	Sat, 17 Mar 2001 12:52:16 -0500
Date: Sat, 17 Mar 2001 17:51:28 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: <Andries.Brouwer@cwi.nl>, <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        <seberino@spawar.navy.mil>
Subject: Re: [PATCH] Improved version reporting
In-Reply-To: <200103170435.f2H4ZnB65925@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.30.0103171718530.22673-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert.

 >>>>>> +o  Mount              #   2.10e        # mount --version

 >>>>> Concerning mount: (i) the version mentioned is too old,

 >>> Exactly why? Mere missing features don't make for a required
 >>> upgrade. Version number inflation should be resisted.

 >> These days you can mount several filesystems at the same mount
 >> point. The old mount does not understand this at all. Recent
 >> versions of mount act better in this respect, even though it is
 >> still easy to confuse them.

 > The rule should be like this:

 >	List the lowest version number required to get
 >	2.2.xx-level features while running a 2.4.xx kernel.

That's a meaningless definition, and can only be taken as such. What
use would such a list be to somebody wishing (like I recently was) to
upgrade a system running the 2.0.12 kernel so it runs the 2.4.2
kernel instead?

The ONLY kernel version that any list can be meaningful for is that of
the kernel source tree it is a member of, and that leads to the
following definition for the versions to be included in such a list:

	List the lowest version number required to compile
	this kernel, and to allow the resulting kernel to
	be used as the heart of a running system.

Basically, required upgrades can fall into any of the following
categories, and need to be dealt with accordingly:

 1. Development tools used to compile and/or link the kernel.

 2. System libraries needed to run these development tools:

 3. System tools that interact intimately with the kernel. If
    the kernel interface changes in an incompatible way, these
    will also need to be updated.

 4. System tools that analyse kernel-supplied information and
    advise the user of the results.

 5. Other tools that are dependant on kernel version.

 6. Other tools that have been upgraded.

My opinion is that only tools that fall in category (6) should be
omitted from the list.

 > Remember what the purpose of the table is. It is a list of
 > REQUIRED upgrades. Failure to upgrade should result in a broken
 > system. So pppd must be listed, since somebody changed the
 > kernel API for 2.4.1.

 > If I run the mount command from Red Hat 6.2, using it as
 > intended for a 2.2.xx kernel, doesn't everything work? There
 > won't be any multi-mount confusion because 2.2.xx can't do that
 > anyway. There isn't any problem with NFSv3 either, since 2.2.xx
 > lacks NFSv3.

Whilst that's a good question, it misses the whole point of such a
list. Can I replace it with a more realistic one:

	If I take a random Linux-based system and boot it using
	the kernel I've just compiled using this kernel source
	tree, will it work? If not, what is the minimum that I
	need to upgrade to make it work?

Remember, there's absolutely NOTHING in ANY of the kernel source trees
that depends on what a particular user is running on their system
before they get that source tree.

 > Basically I ask: would existing scripts for a 2.2.xx kernel
 > break? If the old mount can still do what it used to do, then
 > "mount" need not be listed at all.

Replace that "a 2.2.xx" with "my current" and remove all restrictions
on what the current kernel is, and that becomes an important question.

After all, if I take the network print server I'm running with a
2.0.19 kernel and drop a 2.4.2 kernel in, will it work without any
other changes?

Best wishes from Riley.

