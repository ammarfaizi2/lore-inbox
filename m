Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbTDGOJt (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTDGOJt (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:09:49 -0400
Received: from [196.41.29.142] ([196.41.29.142]:23547 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263458AbTDGOIf (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:08:35 -0400
Subject: Re: correct to set -nostdinc and then include <stdarg.h> ?
From: Martin Schlemmer <azarah@gentoo.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Keith Owens <kaos@ocs.com.au>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <3E91866C.2000902@nortelnetworks.com>
References: <3E910172.8030406@nortelnetworks.com>
	 <23076.1049692512@kao2.melbourne.sgi.com>
	 <20030407074722.A9367@flint.arm.linux.org.uk>
	 <3E91866C.2000902@nortelnetworks.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049724971.4773.2493.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 07 Apr 2003 16:16:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 16:08, Chris Friesen wrote:
> Russell King wrote:
> > On Mon, Apr 07, 2003 at 03:15:12PM +1000, Keith Owens wrote:
> 
> >>On Mon, 07 Apr 2003 00:41:22 -0400, 
> >>Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> >>
> >>>I was trying to compile 2.5.66 with gcc 3.2.2.  It dies as soon as it tries to 
> >>>compile init/main.c because it is unable to find "stdarg.h" which is included by 
> >>>"include/linux/kernel.h".
> >>>
> > 
> > stdarg.h is part of the compiler specific includes.  We want to pick
> > up on these, so we use "-iwithprefix include" to add the compiler specific
> > includes back.
> 
> It doesn't seem to work with gcc 3.2.2 then.
> 
> > Unfortunately, there seems to be something wrong with GCC's ability to
> > determine where these includes really reside when GCC is installed in
> > a different location to the one it was configured with.  In other words,
> > don't do that.  Install GCC to the location where you told it to be
> > installed.
> 
> gcc was configured with a prefix of "/usr/local/gcc322" and installed using 
> "make install".  It still gave the error.  Is this a gcc bug?  I'm at work now, 
> but I can run the command you gave this evening to check the results.
> 
> 

It does work fine.  I for instance have gcc binary in
/usr/i686-pc-linux-gnu/gcc-bin/3.2 and the libraries
in /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2, which works
fine.

You might just have to give --bindir, etc to the exact locations.
Also, make sure you do not have symlinks, etc in /usr/bin, as they
sometimes 'confuses' gcc ...


-- 
Martin Schlemmer


