Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132705AbRC2LDN>; Thu, 29 Mar 2001 06:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRC2LCw>; Thu, 29 Mar 2001 06:02:52 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:50713 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S132701AbRC2LCk>;
	Thu, 29 Mar 2001 06:02:40 -0500
Message-ID: <20010329130154.A8701@win.tue.nl>
Date: Thu, 29 Mar 2001 13:01:54 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>,
   Andreas Dilger <adilger@turbolinux.com>
Cc: Szabolcs Szakacsits <szaka@f-secure.com>,
   Martin Dalecki <dalecki@evision-ventures.com>,
   Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
   Jonathan Morton <chromi@cyberspace.org>,
   Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
In-Reply-To: <200103282138.f2SLcT824292@webber.adilger.int> <Pine.A32.3.95.1010329111147.63156A-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.A32.3.95.1010329111147.63156A-100000@werner.exp-math.uni-essen.de>; from Dr. Michael Weller on Thu, Mar 29, 2001 at 11:29:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 11:29:34AM +0200, Dr. Michael Weller wrote:
> On Wed, 28 Mar 2001, Andreas Dilger wrote:
> 
> > Szaka writes:
> > > On Tue, 27 Mar 2001, Andreas Dilger wrote:
> > > > Every time this subject comes up, I point to AIX and SIGDANGER - a signal
> > > > sent to processes when the system gets OOM.
> > > 
> > > And every time the SIGDANGER comes up, the issue that AIX provides
> > > *both* early and late allocation mechanism even on per-process basis
> > > that can be controlled by *both* the programmer and the admin is
> > > completely ignored. Linux supports none of these...
> 
> > If Linux provided both of those, then people would probably already be
> > happy.
> 
> Probably.

Two things are wrong.
1. Linux has an OOM killer.
2. The OOM killer has a bad behaviour.

Presently, with the proper kind of load, one can see a process killed
by OOM almost daily. That is totally unacceptable.
People are working on refining the algorithm so that blatant idiocies
where processes are killed while there is plenty of resources
are avoided. Good. Suppose it done. Then one thing is wrong.

1. Linux has an OOM killer.

A system with an OOM killer is unreliable. Linux must have a reliable
mode of operation, and that must be the default mode.

Now you assume that adding SIGDANGER would make people happy.
But it would be a rather unimportant addition.
It might help in some cases, but it falls in the category
of improving the OOM killer a little.

People will be happy when Linux is reliable by default.

Andries

[Never use planes where the company's engineers spend their
time designing algorithms for selecting which passenger
must be thrown out when the plane is overloaded.]
