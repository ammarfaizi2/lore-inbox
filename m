Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313267AbSDDRNF>; Thu, 4 Apr 2002 12:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313270AbSDDRMz>; Thu, 4 Apr 2002 12:12:55 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:18821 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313267AbSDDRMs>; Thu, 4 Apr 2002 12:12:48 -0500
Date: Thu, 4 Apr 2002 19:12:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Carlson <justincarlson@cmu.edu>
cc: Abdij Bhat <Abdij.Bhat@kshema.com>, linux-kernel@vger.kernel.org
Subject: Re: error compiling kernel for mips
In-Reply-To: <1017861846.1133.285.camel@gs256.sp.cs.cmu.edu>
Message-ID: <Pine.GSO.3.96.1020404190340.27231A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Apr 2002, Justin Carlson wrote:

> Check out this line in the base level makefile:
> 
> ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e
> s/arm.*/arm/ -e s/sa110/arm/)
> 
> This actually looks broken for cross-compile, but I haven't been
> following the changes particularly closely...try using this instead:
> 
> ARCH := mips

 Or shortly:

$ make "ARCH=<arch>" "CROSS_COMPILE=<prefix>" <whatever>

Here <arch> is "mips" and <prefix> is whatever prefix is is used for your
cross-compiling toolchain (e.g. "mips-linux-" or "mipsel-linux-", etc.).

> Really, though if you're compiling for mips you should probably grab the
> mips-linux CVS sources here:
> 
>  cvs -d :pserver:cvs@oss.sgi.com:/cvs login
>    (Only needed the first time you use anonymous CVS, the password is
> "cvs")
>    cvs -d :pserver:cvs@oss.sgi.com:/cvs co <repository>
> 
> There's a 2.4 tagged branch that's probably closer to what you want. You
> can ask for mips-specific on linux-mips@oss.sgi.com, and you'll be much
> more likely to get a prompt and useful answer.

 Actually 2.4.19 should contain most bits from the current linux_2_4
branch from oss.  Just grab the current "-pre" version.

 Getting a CVS snapshot from oss is certainly a solution as well, but the
server seems to be broken for the last few days (including its CVS server,
its mailing list server and its web server).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

