Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSGEH5D>; Fri, 5 Jul 2002 03:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSGEH5C>; Fri, 5 Jul 2002 03:57:02 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:10994 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315487AbSGEH5B>;
	Fri, 5 Jul 2002 03:57:01 -0400
Date: Fri, 5 Jul 2002 17:58:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sandy Harris <pashley@storm.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch,rfc] make depencies on header files explicit
Message-Id: <20020705175837.137f2479.sfr@canb.auug.org.au>
In-Reply-To: <3D253AAE.D73E1E07@storm.ca>
References: <Pine.LNX.4.33.0207032331010.31929-100000@gans.physik3.uni-rostock.de>
	<20020705111257.04d026b1.sfr@canb.auug.org.au>
	<3D253AAE.D73E1E07@storm.ca>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy,

On Fri, 05 Jul 2002 02:20:30 -0400 Sandy Harris <pashley@storm.ca> wrote:
>
> I thought conventional wisdom was that header files should never #include
> other headers, and .c files should explicitly #include all headers they
> need.

Conventional wisdom varies depending on whose conventions you are asking :-)

> Googling on "nested header" turns up several style guides that agree:
> http://www.cs.mcgill.ca/resourcepages/indian-hill.html
> http://www.doc.ic.ac.uk/lab/secondyear/cstyle/node5.html
> 
> and others that say it is controversial, can be done either way:
> http://www.eskimo.com/~scs/C-faq/q10.7.html

Yes, well I know it is controversial ...

> Am I just off base in relation to kernel coding style? Or would getting
> rid of header file nesting be a useful objective.

The CodingStyle file is silent on this.

I just find it a real pain sometimes trying to figure out what other
include files I need to when all I really want is one or two definitions
in one particular include file.  The same holds true when I am removing
or moving stuff from one place to another (especially when trying to
clean up some of the current mess).

Given that all kernel header files protect themselves from being included
multiple times, I think locality wins us something.

As I said, this is (just) my (humble) opinion.  :-)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
