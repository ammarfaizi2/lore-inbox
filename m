Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTFBDCV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 23:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTFBDCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 23:02:21 -0400
Received: from miranda.zianet.com ([216.234.192.169]:3846 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S261797AbTFBDCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 23:02:18 -0400
Subject: Re: Question about style when converting from K&R to ANSI C.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1054519757.161606@palladium.transmeta.com>
References: <1054446976.19557.23.camel@spc>
	 <20030601132626.GA3012@work.bitmover.com>
	 <1054519757.161606@palladium.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054523726.19551.156.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Jun 2003 21:15:27 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 20:09, Linus Torvalds wrote:
> In article <20030601132626.GA3012@work.bitmover.com>,
> Larry McVoy  <lm@bitmover.com> wrote:
> >On Sat, May 31, 2003 at 11:56:16PM -0600, Steven Cole wrote:
> >> Proposed conversion:
> >> 
> >> int foo(void)
> >> {
> >>    	/* body here */
> >> }	
> >
> >Sometimes it is nice to be able to see function names with a 
> >
> >	grep '^[a-zA-Z].*(' *.c
> >
> >which is why I've always preferred
> >
> >int
> >foo(void)
> >{
> >	/* body here */
> >}	
> 
> That makes no sense.
> 
> Do you write your normal variable definitions like
> 
> 	int
> 	a,b,c;
> 
> too? No you don't, because that would be totally idiotic.
> 
> A function declaration is no different. The type of the function is very
> important to the function itself (along with the arguments), and I
> personally want to see _all_ of it when I grep for functions. 
> 
> You should just do
> 
> 	grep -i '^[a-z_ ]*(' *.c 
> 
> and you'll get a nice function declaration with the standard kernel
> coding style.
> 
> And I personally don't normally do "grep for random function
> declarations", that just sounds like a contrieved example.  I grep for
> specific function names to find usage, and then it's _doubly_ important
> to see that the return (and argument) types match and make sense.
> 
> So I definitely prefer all the arguments on the same line too, even if
> that makes the line be closer to 100 chars than 80.  The zlib K&R->ANSI
> conversion was a special case, and I'd be happy if somebody were to have
> the energy to convert it all the way (which implies moving comments
> around etc). 
> 
How is this? I don't know about the energy part as xor'ed with itself
leaves the value unchanged right now.

I've tried to follow Documentation/kernel-doc-nano-HOWTO.txt
as suggested by acme.

Putting all the arguments on the same line gives 103 characters, if I
counted correctly.  Others will be longer, so this is chosen as a folded
example.

Steven

--- linux/lib/zlib_inflate/inftrees.c.orig	2003-06-01 20:50:57.000000000 -0600
+++ linux/lib/zlib_inflate/inftrees.c	2003-06-01 20:58:51.000000000 -0600
@@ -288,14 +288,17 @@
   return y != 0 && g != 1 ? Z_BUF_ERROR : Z_OK;
 }
 
+/**
+ *	zlib_inflate_trees_bits:
+ *	@uIntf *c:                19 code lengths
+ *	@uIntf *bb:               bits tree desired/actual depth
+ *	@inflate_huft * FAR *tb:  bits tree result
+ *	@inflate_huft *hp:        space for trees
+ *	@z_streamp z:             for messages
+ */
 
-int zlib_inflate_trees_bits(
-	uIntf *c,               /* 19 code lengths */
-	uIntf *bb,              /* bits tree desired/actual depth */
-	inflate_huft * FAR *tb, /* bits tree result */
-	inflate_huft *hp,       /* space for trees */
-	z_streamp z             /* for messages */
-)
+int zlib_inflate_trees_bits(uIntf *c, uIntf *bb, inflate_huft * FAR *tb,
+	inflate_huft *hp, z_streamp z)
 {
   int r;
   uInt hn = 0;          /* hufts used in space */



