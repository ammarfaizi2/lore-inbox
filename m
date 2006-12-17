Return-Path: <linux-kernel-owner+w=401wt.eu-S1753113AbWLQWXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbWLQWXG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 17:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbWLQWXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 17:23:06 -0500
Received: from mail.enter.net ([216.193.128.40]:40484 "EHLO mmail.enter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbWLQWXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 17:23:05 -0500
X-Greylist: delayed 2181 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 17:23:05 EST
From: "D. Hazelton" <dhazelton@enter.net>
To: davids@webmaster.com
Subject: Re: GPL only modules
Date: Sun, 17 Dec 2006 16:46:40 -0500
User-Agent: KMail/1.9.5
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKGEPFAGAC.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEPFAGAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612171646.40655.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 December 2006 16:32, David Schwartz wrote:
> > I would argue that this is _particularly_ pertinent with regards to
> > Linux.  For example, if you look at many of our atomics or locking
> > operations a good number of them (depending on architecture and
> > version) are inline assembly that are directly output into the code
> > which uses them.  As a result any binary module which uses those
> > functions from the Linux headers is fairly directly a derivative work
> > of the GPL headers because it contains machine code translated
> > literally from GPLed assembly code found therein.  There are also a
> > fair number of large perhaps-wrongly inline functions of which the
> > use of any one would be likely to make the resulting binary
> > "derivative".
>
> That's not protectable expression under United States law. See Lexmark v.
> Static Controls and the analogous case of the TLP (ignore the DMCA stuff in
> that case, that's not relevant). If you want to make that kind of content
> protectable, you have to get it out of the header files.
>
> You cannot protect, by copyright, every reasonably practical way of
> performing a function. Only a patent can do that. If taking something is
> reasonably necessary to express a particular idea (and a Linux module for
> the ATI X850 card is an idea), then that something cannot be protected by
> copyright when it is used to express that idea. (Even if it would clearly
> be protectably expression in another context.)
>
> The premise of copyright is that there are millions of equally-good ways to
> express the same idea or perform the same function, and you creatively pick
> one, and that choice is protected. But if I'm developing a Linux module for
> a particular network card, choosing to use the Linux kernel header files is
> the only practical choice to perform that particular function. So their
> content is not protectable when used in that context. (If you make another
> way to do it, then the content becomes protectable in that context again.)
>
> IANAL.
>
> DS

Agreed. You missed the point. Since the Linux Kernel header files contain a 
chunk of the source code for the kernel in the form of the macros for locking 
et. al. then using the headers - including that code in your module - makes 
it a derivative work.

Actually, thinking about it, the way a Linux driver module works actually 
seems to make *ANY* driver a derivative work, because they are loaded into 
the kernels memory space and cannot function without having that done.

*IF* the "Usermode Driver" interface that is being worked on ever proves 
useful then, and only then, could you consider it *NOT* a derivative work. 
Because then the only thing it is using *IS* an interface, not complete 
chunks of the source as generated when the pre-processor finishes running 
through the file.

But as David said - IANAL

D. Hazelton
