Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSGEHNV>; Fri, 5 Jul 2002 03:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSGEHNU>; Fri, 5 Jul 2002 03:13:20 -0400
Received: from mail.storm.ca ([209.87.239.66]:48865 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S315481AbSGEHNU>;
	Fri, 5 Jul 2002 03:13:20 -0400
Message-ID: <3D253AAE.D73E1E07@storm.ca>
Date: Fri, 05 Jul 2002 02:20:30 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch,rfc] make depencies on header files explicit
References: <Pine.LNX.4.33.0207032331010.31929-100000@gans.physik3.uni-rostock.de> <20020705111257.04d026b1.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:

> > It seems to be quite common to assume that sched.h and all the other
> > headers it drags in are available without declaration anyways. Since
> > I aim at invalidating this assumption by removing all unneccessary
> > includes, I have started to make dependencies on header files included
> > by sched.h explicit.
> > This is, again, just a small start, a patch covering the whole include/
> > subtree would be approximately 25 times as large. However, before I'll
> > dig into this further, I'd like to make sure I haven't missed some
> > implicit rules about which headers might be assumed available, or should
> > be included by the importing .c file, or something like that.
> > So any comments about this project are welcome.
> 
> Let me encourage you!  IMHO any source file (and here I include header
> files) should include all the header files it depends on.  This gives us
> at least some chance of keeping the headers consistant with their usage.
 
I thought conventional wisdom was that header files should never #include
other headers, and .c files should explicitly #include all headers they
need.

Googling on "nested header" turns up several style guides that agree:
http://www.cs.mcgill.ca/resourcepages/indian-hill.html
http://www.doc.ic.ac.uk/lab/secondyear/cstyle/node5.html

and others that say it is controversial, can be done either way:
http://www.eskimo.com/~scs/C-faq/q10.7.html

Am I just off base in relation to kernel coding style? Or would getting
rid of header file nesting be a useful objective.
