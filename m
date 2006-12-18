Return-Path: <linux-kernel-owner+w=401wt.eu-S1754575AbWLRUvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbWLRUvl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbWLRUvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:51:41 -0500
Received: from mmail.enter.net ([216.193.128.40]:45422 "EHLO mmail.enter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575AbWLRUvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:51:41 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: "Dave Neuer" <mr.fred.smoothie@pobox.com>
Subject: Re: GPL only modules
Date: Mon, 18 Dec 2006 12:46:49 -0500
User-Agent: KMail/1.9.5
Cc: davids@webmaster.com,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKGEPFAGAC.davids@webmaster.com> <200612171646.40655.dhazelton@enter.net> <161717d50612180747k5e40a802uf33203eca9515acc@mail.gmail.com>
In-Reply-To: <161717d50612180747k5e40a802uf33203eca9515acc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612181246.49504.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 10:47, Dave Neuer wrote:
> On 12/17/06, D. Hazelton <dhazelton@enter.net> wrote:
> > On Sunday 17 December 2006 16:32, David Schwartz wrote:
> > > > I would argue that this is _particularly_ pertinent with regards to
> > > > Linux.  For example, if you look at many of our atomics or locking
> > > > operations a good number of them (depending on architecture and
> > > > version) are inline assembly that are directly output into the code
> > > > which uses them.  As a result any binary module which uses those
> > > > functions from the Linux headers is fairly directly a derivative work
> > > > of the GPL headers because it contains machine code translated
> > > > literally from GPLed assembly code found therein.  There are also a
> > > > fair number of large perhaps-wrongly inline functions of which the
> > > > use of any one would be likely to make the resulting binary
> > > > "derivative".
> > >
> > > That's not protectable expression under United States law. See Lexmark
> > > v. Static Controls and the analogous case of the TLP (ignore the DMCA
> > > stuff in that case, that's not relevant). If you want to make that kind
> > > of content protectable, you have to get it out of the header files.
> > >
> > > You cannot protect, by copyright, every reasonably practical way of
> > > performing a function. Only a patent can do that. If taking something
> > > is reasonably necessary to express a particular idea (and a Linux
> > > module for the ATI X850 card is an idea), then that something cannot be
> > > protected by copyright when it is used to express that idea. (Even if
> > > it would clearly be protectably expression in another context.)
> > >
> > > The premise of copyright is that there are millions of equally-good
> > > ways to express the same idea or perform the same function, and you
> > > creatively pick one, and that choice is protected. But if I'm
> > > developing a Linux module for a particular network card, choosing to
> > > use the Linux kernel header files is the only practical choice to
> > > perform that particular function. So their content is not protectable
> > > when used in that context. (If you make another way to do it, then the
> > > content becomes protectable in that context again.)
> > >
> > > IANAL.
> > >
> > > DS
> >
> > Agreed. You missed the point. Since the Linux Kernel header files contain
> > a chunk of the source code for the kernel in the form of the macros for
> > locking et. al. then using the headers - including that code in your
> > module - makes it a derivative work.
>
> David didn't miss the point; Lexmark vs. Static Controls, however
> unintuitively, ruled that even _verbatim_ copying is not always
> copyright infringement in the case of software because of issues like
> the doctrine of scenes a faire. In the case of spinlocks, if the only
> way to accomplish atomic operations on an architecture is to use
> something like the assembler that the inclusion of spinlock.h injects
> into your binary, then according to Lexmark vs. Static Controls that
> makes that included code unprotectable by copyright.

Ah, okay. However I'm quite sure that there are more ways to accomplish the 
tasks handled by the code in the header files (in most cases). 

> Where I disagree with David (as I have publicly before on this list),
> is that he incorrectly applies the concept of "functional idea" to
> "write a linux kernel module." I don't believe that is a "functional
> idea" in the sense that is meaningful in the context of software
> copyright or patents (at least until someone writes a piece of
> software that writes kernel modules).

Agreed. And thanks for clarifying that.

DRH
