Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262054AbSJITs6>; Wed, 9 Oct 2002 15:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262060AbSJITs6>; Wed, 9 Oct 2002 15:48:58 -0400
Received: from h52544c185a20.ne.client2.attbi.com ([24.147.42.69]:8578 "EHLO
	luna.pizzashack.org") by vger.kernel.org with ESMTP
	id <S262054AbSJITs4>; Wed, 9 Oct 2002 15:48:56 -0400
Date: Wed, 9 Oct 2002 15:54:39 -0400
From: "Derek D. Martin" <lkml@pizzashack.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [prolly a bit OT] programming network interfaces
Message-ID: <20021009195439.GI2753@pizzashack.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

First, I've no desire to waste a lot of the lists time with off-topic
threads, so if there is a better place to ask this question, by all
means let me know where that is, and I'll do so.  Obviously off-list
replies are quite welcome as well.  I have searched in numerous places
for the information I'm looking for, unsuccessfully.  This list is a
likely plentiful source of people who either know the answer, or know
where to find it; the only such source I'm familiar with...

I'm interested in writing a version of the ifconfig and route
programs.  I need to be able to list all the interfaces on the system,
and obtain relevant statistics, and routing information.  I'd prefer
to use a method other than processing the /proc filesystem, as my
understanding is that its format has a tendency to change.  It would
be preferable to use a mechanism that requires little or no
maintenance.

Some might ask why I want to do this, since these programs already
exist, as do newer alternatives that take advantage of newer advanced
routing features of the kernel.  To those, my answer is:

  - I'm unemployed...  =8^)
  - as an academic exercise
  - the existing ifconfig and route are a bit buggy/lack functionality
    (like route flush, etc.)
  - As my background is  Unix system administration, I believe Linux
    should have versions of these tools that work as other Unix admins
    would expect them to (more or less) whether or not
    different/better tools exist...

Up to now, I've been focusing on ifconfig, but I'll obviously have
questions about how to accomplish what's necessary for the route
command as well.  Having focused on ifconfig however, those are the
questions I have had an opportunity to formulate more clearly.

I'm somewhat (but not overly) familiar with the SIOCGIFCONF and
related ioctls, as well as the if_nameindex() family.  AFIACT This
particular function only returns the list of active interfaces, so
obviously isn't quite suitable.  Likewise with the SIOCGIFCONF ioctl.
I originally thought to use if_indextoname() to loop through the
interfaces until a null was found, but my experimentation shows that
the kernel does not guarantee the interface names to be stored in
consecutive non-null indexes.  I have thusfar been unable to find
documentation that explains in detail how these functions and ioctls
work (actually getting this far involved quite a bit of time searching
on-line as well as poking through some existing code and /usr/include).

I'm primarily concerned with supporting newer systems with a >= 2.4
kernel, and newer glibc.  It'd be nice to be able to support older
systems too (with or without modification), but it won't break my
heart not to.

So, my 2 questions are:

 - is there a mechanism available to do this that does not involve
   processing /proc?
 - is there suitable documentation somewhere that explains how this
   mechanism is used, if it exists?

And failing the second, a third:

 - is there some kind soul who is willing to take the time to explain
   to me how to do this?

Thanks in advance.

- -- 
Derek D. Martin
http://www.pizzashack.org/
GPG Key ID: 0x81CFE75D

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9pIl/djdlQoHP510RAn+CAJ4wpP0+UTaLLFzTjZpt4r+lheL7ugCggxu+
DocANcceNX3bpsn7SkrfJuk=
=QqBA
-----END PGP SIGNATURE-----
