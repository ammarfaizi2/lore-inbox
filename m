Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSKZEhT>; Mon, 25 Nov 2002 23:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSKZEhT>; Mon, 25 Nov 2002 23:37:19 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:39846 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S262804AbSKZEhS>; Mon, 25 Nov 2002 23:37:18 -0500
Date: Mon, 25 Nov 2002 23:44:20 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <linux-kernel@vger.kernel.org>,
       "Adam J. Richter" <adam@freya.yggdrasil.com>
Subject: Re: modutils for both redhat kernels and 2.5.x 
In-Reply-To: <20021126013330.93A962C365@lists.samba.org>
Message-ID: <Pine.GSO.4.33.0211252320530.6708-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Rusty Russell wrote:
>> I would beg and plead with Linus to back that "crap" out of the kernel
>> until such time as it has a snowball's chance of actually working ...
>> anywhere.  As it stands, 2.5 is now 100% unusable until modules works
>> again.
>
>Funny, other people seem to be using it.

I'm using a fresh redhat 8.0 install.  With the standard modutils, nothing
loads.  With the updated 2.4.22 modutils, again, nothing loads.  With
module-init-tool 0.7, none of the redhat startup scripts will work because
they depend on "modprobe -c"

>> Kernel symbol versioning no longer exists.
>
>That this patch has not yet been merged is crippling your development
>efforts HOW, exactly?  I was clearly mistaken when I thought that this
>was low priority.

Well excuse me if I get more than a little ticked off after seeing people
break prefectly functional systems that have been so for years.  Did the
existing system need replacing?  Maybe.  Exactly what does a new "in
kernel module loader" provide that demands it be included in the kernel
right-this-very-minute?  What's so important that everything gets broken
right at the moment things are supposed to be settling down? (I often
wonder if Linus completely skipped source code management class.)

>> Depmod no longer exists.
>
>This is true.  It doesn't need to for 0.7, but it's being reintroduced
>in 0.8 for speed.

And along those lines, we don't "need" modules either.

>> Modprobe blindly loads a string of modules without even looking to see
>> if it's already loaded.
>
>Yes, this is a bug (and one not reported by anyone, either).  Should
>be fixed in 0.8.

You call it a bug; I call it a lame oversite.

>> The command line args for modprobe are laughingly few (and none of
>> the ones a redhat system needs to boot are implemented.)
>
>Really?  I don't recall seeing a bug report from you about it.  My
>Debian system boots fine.

Read the man page for "modprobe".  How much of your version comes anywhere
near that?  One cannot blindly change the command line interface of an
integral tool without knowing they are going to seriously break things.

>> We're back to the flat module namespace (that patch of earth is now 100%
>> salt...)
>
>Um, we always had a flat module namespace.  *ALWAYS*.  We did put the
>modules into subdirectories though.  Due to Adam Richter's hard work,
>with 0.8 we can restore this (basically for the benifit of mkinitrd,
>which I also don't use).

Really.  Then why the months of holy wars for and against directories?
And at various points throughout history, there have been totally separate
modules with the same name.

>> And every single object that forms a module will need to be
>> retooled to adhere to the new module API
>
>Really?  How fascinating.  I must admit that I hadn't noticed that.

So, are *you* going to go rewrite every single one of those drivers?
Don't, for one second, think the original author(s) and/or current
maintainer(s) are gonna flock to the "new way".  As I pointed out, there
are dozens of drivers that still haven't been converted to the new DMA
format -- and that's been on the table for a lot longer.

If Linus and company are happy to keep pushing 2.6/3.0/whatever back
several more years, then, by all means, keep re-inventing long accepted
core components and half integrated them a week after "feature freeze"
and "code freeze".

"Introducing, The New Wheel (tm)... 3.2% rounder than any previous wheel."

--Ricky


