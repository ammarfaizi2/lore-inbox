Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310614AbSCHA3O>; Thu, 7 Mar 2002 19:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310612AbSCHA3B>; Thu, 7 Mar 2002 19:29:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52487 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310618AbSCHA2h>;
	Thu, 7 Mar 2002 19:28:37 -0500
Message-ID: <3C880541.E04EFAB3@zip.com.au>
Date: Thu, 07 Mar 2002 16:26:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "Jonathan A. George" <JGeorge@greshamstorage.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 7 Mar 2002, Jonathan A. George wrote:
> 
> > I am considering adding some enhancements to CVS to address deficiencies
> > which adversely affect my productivity.
> 
> > ... I would like to know what the Bitkeeper users consider the minimum
> > acceptable set of improvements that CVS would require for broader
> > acceptance.
> 
> 1) working merges

Yes, cvs is poor at that.  This is a bugfix, not a feature request :)

> 2) atomic checkins of entire patches, fast tags

Yes.  changesets against a *group* of files (ie: a patch) needs
to become a first-class citizen.
 
> 3) graphical 2-way merging tool like bitkeeper has
>    (this might not seem essential to people who have
>    never used it, but it has saved me many many hours)

Current tkdiff is in fact very good at this.  So integration
with that may suit.

The problem I find is that I often want to take (file1+patch) -> file2,
when I don't have file1.  But merge tools want to take (file1|file2) -> file3.
I haven't seen a graphical tool which helps you to wiggle a patch into
a file.

> 4) distributed repositories
> 
> 5) ability to exchange changesets by email

These can probably be in version 2...

Probably the requirements of general developers differ from those
of tree-owners.  The general developer is always working against
the official tree.

This is a bit extreme perhaps but I'm currently working code which
consists of twelve changesets against 100 files.  Many of those
files are changed by multiple changesets.  So two things:

1: If I have two changesets applied to a file, and I make a change to
   that file, which changeset is it to be associated with?

2: The ability to move a set of changes from one changeset into
   another one.  ie: split that damn patch up!

But as a starting point I'd say: changesets as a first-class-concept,
and lots of integration with tkdiff.

-
