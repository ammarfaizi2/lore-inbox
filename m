Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTEaAmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 20:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTEaAmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 20:42:03 -0400
Received: from miranda.zianet.com ([216.234.192.169]:38924 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264092AbTEaAmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 20:42:01 -0400
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function
	declarations.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0305301414210.2671-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305301414210.2671-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054342517.2901.78.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 30 May 2003 18:55:18 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-30 at 15:17, Linus Torvalds wrote:
> On Fri, 30 May 2003, Russell King wrote:
> >
> > On Fri, May 30, 2003 at 01:57:13PM -0600, Steven Cole wrote:
> > > +int foo(
> > > +	long bar,
> > > +	long day,
> > > +	struct magic *xyzzy
> > > +)
> > 
> > Is this really part of the kernel coding style?
> 
> No, but it's better than what it used to be.
> 
> Also, while I don't think we should try to maintain 1:1 behaviour with 
> the _worst_ offenses of zlib, I do think we should maintain comments etc, 
> and a lot of the zlib function declarations used to look like
> 
> 	int foo(bar, baz)
> 	long bar;		/* number of frobnicators */
> 	long baz;		/* self-larting on or off */
> 	{
> 		....
> 
> and the ANSI-fication changes this to
> 
> 	int foo(
> 		long bar,	/* number of frobnicators */
> 		long baz	/* self-larting on or off */
> 	)
> 	{
> 		...
> 
> which while not according to the coding-standard is at least a reasonable 
> compromize between having proper C function definitions and keeping the 
> code _looking_ more like the original.
> 
> 		Linus
> 
> 
OK, here is a modified version of the patch to CodingStyle which
explicitly notes the reason for this secondary style.

Steven

--- linux/Documentation/CodingStyle.orig	2003-05-30 18:41:05.000000000 -0600
+++ linux/Documentation/CodingStyle	2003-05-30 18:46:08.000000000 -0600
@@ -149,6 +149,23 @@
 and it gets confused.  You know you're brilliant, but maybe you'd like
 to understand what you did 2 weeks from now. 
 
+Function declarations should be new-style:
+
+int foo(long bar, long baz, struct magic *xyzzy)
+
+or when replacing old-style declarations which have comments:
+
+int foo(
+	long bar,
+	long baz,
+	struct magic *xyzzy	/* essential comment */
+)
+
+Old-style function declarations are deprecated:
+
+int foo(bar, baz, xyzzy)
+long bar, baz;
+struct magic *xyzzy;		/* essential comment */
 
 		Chapter 5: Commenting
 



