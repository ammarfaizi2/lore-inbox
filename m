Return-Path: <linux-kernel-owner+w=401wt.eu-S1754180AbWLRPrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbWLRPrz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbWLRPrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:47:55 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:45312 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177AbWLRPrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:47:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OXbcCIqAl9zOL+c3pQuU0of5TkRcXFzcSca1veofd9ZiYfHpor1VJ6/59oB9h5jTz94/h4MwRjyxnR40MTBzXAFmeK6z+krCTDhrdG2znFW9U6pvMM7hgJm7V2d/qyvuB/igI86kryFuY17va8+FcDnHWxGTfsbdbhA4zHtp9Ko=
Message-ID: <161717d50612180747k5e40a802uf33203eca9515acc@mail.gmail.com>
Date: Mon, 18 Dec 2006 10:47:44 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: GPL only modules
Cc: davids@webmaster.com,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200612171646.40655.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <MDEHLPKNGKAHNMBLJOLKGEPFAGAC.davids@webmaster.com>
	 <200612171646.40655.dhazelton@enter.net>
X-Google-Sender-Auth: 5d26241b1414694e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/06, D. Hazelton <dhazelton@enter.net> wrote:
> On Sunday 17 December 2006 16:32, David Schwartz wrote:
> > > I would argue that this is _particularly_ pertinent with regards to
> > > Linux.  For example, if you look at many of our atomics or locking
> > > operations a good number of them (depending on architecture and
> > > version) are inline assembly that are directly output into the code
> > > which uses them.  As a result any binary module which uses those
> > > functions from the Linux headers is fairly directly a derivative work
> > > of the GPL headers because it contains machine code translated
> > > literally from GPLed assembly code found therein.  There are also a
> > > fair number of large perhaps-wrongly inline functions of which the
> > > use of any one would be likely to make the resulting binary
> > > "derivative".
> >
> > That's not protectable expression under United States law. See Lexmark v.
> > Static Controls and the analogous case of the TLP (ignore the DMCA stuff in
> > that case, that's not relevant). If you want to make that kind of content
> > protectable, you have to get it out of the header files.
> >
> > You cannot protect, by copyright, every reasonably practical way of
> > performing a function. Only a patent can do that. If taking something is
> > reasonably necessary to express a particular idea (and a Linux module for
> > the ATI X850 card is an idea), then that something cannot be protected by
> > copyright when it is used to express that idea. (Even if it would clearly
> > be protectably expression in another context.)
> >
> > The premise of copyright is that there are millions of equally-good ways to
> > express the same idea or perform the same function, and you creatively pick
> > one, and that choice is protected. But if I'm developing a Linux module for
> > a particular network card, choosing to use the Linux kernel header files is
> > the only practical choice to perform that particular function. So their
> > content is not protectable when used in that context. (If you make another
> > way to do it, then the content becomes protectable in that context again.)
> >
> > IANAL.
> >
> > DS
>
> Agreed. You missed the point. Since the Linux Kernel header files contain a
> chunk of the source code for the kernel in the form of the macros for locking
> et. al. then using the headers - including that code in your module - makes
> it a derivative work.

David didn't miss the point; Lexmark vs. Static Controls, however
unintuitively, ruled that even _verbatim_ copying is not always
copyright infringement in the case of software because of issues like
the doctrine of scenes a faire. In the case of spinlocks, if the only
way to accomplish atomic operations on an architecture is to use
something like the assembler that the inclusion of spinlock.h injects
into your binary, then according to Lexmark vs. Static Controls that
makes that included code unprotectable by copyright.

Where I disagree with David (as I have publicly before on this list),
is that he incorrectly applies the concept of "functional idea" to
"write a linux kernel module." I don't believe that is a "functional
idea" in the sense that is meaningful in the context of software
copyright or patents (at least until someone writes a piece of
software that writes kernel modules).

Dave
