Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUHFUfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUHFUfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUHFUfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:35:25 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:28657 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266170AbUHFUdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:33:45 -0400
Subject: schilling@fokus.fraunhofer.de, axboe@suse.de
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1091815347.1232.2529.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Aug 2004 14:02:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In several different emails, Joerg Schilling writes:

> Linux users like to call cdrecord -scanbus and they like to
> see _all_ SCSI devices from a single call to cdrecord.

If you really think so, you've been smoking crack.
Users _hate_ to call "cdrecord -scanbus". They don't
see why it should be needed. The normal reaction to
reading your documentation goes something like this:

"What the fuck? Can't I just give it a device name?"

Alternately:

"Uh... I don't have SCSI. I guess I need a different program."

Heck, you could do the silly -scanbus thing internally
if you must. Then users wouldn't get it wrong and wouldn't
have to screw with it.

> Looks like a typical answer from somebody who's thoughts
> are limited to a Linux environment. Take into account, that
> cdrecord runs on more than 30 different platforms and that
> several of these platforms do not have device nodes like
> UNIX has. Cdrecord has been implemented to use a portable
> addressing method.

I'm sure a Windows user would want to use something like
a drive letter. So... give it to them. Not even a Solaris
user would really want to use raw SCSI notation. On all
platforms, people want to use the native naming system.

> The fact that the Linux kernel does not return instance
> numbers for /dev/hd* SCSI devices makes it impossible to
> implement a unique address space :-(

We have a unique address space: the /dev directory

> If you like to compile an application that uses kernel interfaces,
> you need to make sure that both, the application and the kernel
> are compiled with the same "interface description" which is just
> the kernel include files.

No change to the kernel headers would allow you to produce
a binary on an old system that makes use of new features.
The only way this can work is if you bring your own headers.

I use kernel interfaces all the time in procps. For the old
and standard ones, I rely on the C library. For all the rest,
I have my own header files. This works great.

I can compile procps on a system with the 2.4.xx kernel
and 2.4.xx headers. Then, I can take this binary to a system
with the 2.2.xx or 2.6.x kernel and expect it to work great.
That's 3 major kernel revisions: 2.2.xx, 2.4.xx, and 2.6.x.
I'm not sure what your problem is... 

> I wish that discussions with the Linux kernel hackers would be as
> easy and fruitful as they are with the Solaris kernel hackers.

You're trying to force Linux developers to comply with Solaris
interfaces. You should try things the other way and see how far
you get. If you don't get far, you're being unfair. If you do
get far, well, isn't that good?

> Just make sure not to use a broken version from the SuSE source tree....

I wonder why SuSE felt they needed to patch your code.
While I've found that some vendors are really crazy about
breaking things, SuSE has been pretty good.

If everyone around you seems to be insane, maybe it's you.

> Let's see whether "Linux" is open enough to listen to the
> demands of the users......

How about cdrecord? Demands of the users:

1. tools built with headers derived from Linux 2.2.xx will
   take full advantage of Linux 2.6.xx features

2. in all cases, including SCSI, the /dev/* name is used
   (the Solaris and Windows users would love that as well)



