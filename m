Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbTAaXa6>; Fri, 31 Jan 2003 18:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbTAaXa6>; Fri, 31 Jan 2003 18:30:58 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:9452 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S263326AbTAaXaz>;
	Fri, 31 Jan 2003 18:30:55 -0500
Date: Sat, 1 Feb 2003 00:40:21 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
Message-ID: <20030131234021.GE1541@werewolf.able.es>
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es> <3E3B066B.8010905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3E3B066B.8010905@pobox.com>; from jgarzik@pobox.com on Sat, Feb 01, 2003 at 00:27:39 +0100
X-Mailer: Balsa 2.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.02.01 Jeff Garzik wrote:
> J.A. Magallon wrote:
> > On 2003.01.31 Jeff Garzik wrote:
> > 
> >>On Fri, Jan 31, 2003 at 01:41:26PM -0600, Kai Germaschewski wrote:
> >>
> >>>Generally, we've been trying to not make perl a prequisite for the kernel 
> >>>build, and I'd like to keep it that way. Except for some arch specific 
> >>
> >>That's pretty much out the window when klibc gets merged, so perl will
> >>indeed be a build requirement for all platforms...
> >>
> > 
> > 
> > So in short, kernel people:
> > - do not want perl in the kernel build
> > - allow qt to pollute the kernel to have a decent gui config tool
> > - have to rewrite half perl features in C
> > - but perl will be needed anyways
> > 
> > instead of
> > - do all parsing in perl, that is what perl is for and what is mainly done
> >   in kconfig scripts
> > - do the config backend in perl, and...
> > - do the gui in perl-XXX, so you can have perl-GTK, perl-GTK2, perl-QT or 
> >   perl-Tk, even perl-Xaw (so you get rid of tcl/tk)
> > 
> > I really do not understand...
> 
> 
> Well, you appear to be taking the superset of opinions, which is 
> guaranteed to generate a paradox, I should think ;-)
> 
> Specifically regarding kconf, it does not require Qt; Qt is merely an 
> optional piece.
> 
> For Perl, yes I personally think it is needed anyway.  And re-creating 
> Perl's features in C, just to avoid Perl, is not the best technical 
> solution when developers already have Perl installed.
> 

As someone said, parsing and string processing is one of the jobs in kernel
config. Kernel gurus decided to rewrite the thing in C to avoid the lacks
in the current bash-ish kconfig, because writing logic for dependencies,
checks and so on is a pain...so let's rewrite the logic handling, _and_ the
string processing, btw.
The easies way (from my point of view): write Perl::KConfig in C to do the logic
hard work and build the big thing in perl. That will be putting a perl
interface on top of klibc ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))
