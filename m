Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSKZB0P>; Mon, 25 Nov 2002 20:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKZB0O>; Mon, 25 Nov 2002 20:26:14 -0500
Received: from dp.samba.org ([66.70.73.150]:5301 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265909AbSKZB0O>;
	Mon, 25 Nov 2002 20:26:14 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@freya.yggdrasil.com>
Subject: Re: modutils for both redhat kernels and 2.5.x 
In-reply-to: Your message of "Mon, 25 Nov 2002 18:59:45 CDT."
             <Pine.GSO.4.33.0211251830050.6708-100000@sweetums.bluetronic.net> 
Date: Tue, 26 Nov 2002 11:56:05 +1100
Message-Id: <20021126013330.93A962C365@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.33.0211251830050.6708-100000@sweetums.bluetronic.net> yo
u write:
> I would beg and plead with Linus to back that "crap" out of the kernel
> until such time as it has a snowball's chance of actually working ...
> anywhere.  As it stands, 2.5 is now 100% unusable until modules works
> again.

Funny, other people seem to be using it.

> Kernel symbol versioning no longer exists.

That this patch has not yet been merged is crippling your development
efforts HOW, exactly?  I was clearly mistaken when I thought that this
was low priority.

> Depmod no longer exists.

This is true.  It doesn't need to for 0.7, but it's being reintroduced
in 0.8 for speed.

> Modprobe blindly loads a string of modules without even looking to see
> if it's already loaded.

Yes, this is a bug (and one not reported by anyone, either).  Should
be fixed in 0.8.

> The command line args for modprobe are laughingly few (and none of
> the ones a redhat system needs to boot are implemented.)

Really?  I don't recall seeing a bug report from you about it.  My
Debian system boots fine.

> We're back to the flat module namespace (that patch of earth is now 100%
> salt...)

Um, we always had a flat module namespace.  *ALWAYS*.  We did put the
modules into subdirectories though.  Due to Adam Richter's hard work,
with 0.8 we can restore this (basically for the benifit of mkinitrd,
which I also don't use).

> And every single object that forms a module will need to be
> retooled to adhere to the new module API

Really?  How fascinating.  I must admit that I hadn't noticed that.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
