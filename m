Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTDOGDP (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 02:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTDOGDP (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 02:03:15 -0400
Received: from [196.41.29.142] ([196.41.29.142]:60156 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264308AbTDOGDO (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 02:03:14 -0400
Subject: Re: Oops: ptrace fix buggy
From: Martin Schlemmer <azarah@gentoo.org>
To: James Bourne <jbourne@hardrock.org>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304141515080.24383-100000@cafe.hardrock.org>
References: <Pine.LNX.4.44.0304141515080.24383-100000@cafe.hardrock.org>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1050387043.4061.38.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 15 Apr 2003 08:10:43 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 23:19, James Bourne wrote:
> On Mon, 14 Apr 2003, Jörn Engel wrote:
> 
> > So basically, neither the existing EXTRAVERSION nor my new FIXLEVEL
> > are checked. Any code could potentially break with -ac1 to -ac2 or
> > with .1 to .2.
> > 
> > Did anyone experience such problems with -ac already? There are far
> > more changes in -ac than there are in your patch.
> 
> Which brings the point as to why use a new variable unless you are going to
> actually modify LINUX_VERSION_CODE with it.  It actually makes more sense to
> just use EXTRAVERSION for this then.
> 
> Now, using EXTRAVERSION = .2 wouldn't be unrealistic...
> 

True, but then, most things expect a version with two '.' s.
And adding the extra '.2' breaks how they calculate the version.

Mozilla for example, strip off all non numbers and '.' s, and
then just cut the last '.' and number.  What ever is left, is
used to check what makefile should be used in the NSS stuff ...
Meaning, with a normal version, it would be:

 Makefile-2.4

With Jörn's, it would try to use:

 Makefile-2.4.20

which do not exits ...

Yes, mozilla is broken ;)  I never said you cannot set
EXTRAVERSION to '.2'.  All I said, was that its going
to break stuff, as many things expect, and only work
with a two '.' version ....


Regards,

-- 
Martin Schlemmer


