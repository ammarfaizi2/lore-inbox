Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTFBQ0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTFBQ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:26:48 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:44254 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S264503AbTFBQ0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:26:43 -0400
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function
	declarations.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306020856450.19910-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0306020856450.19910-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054571980.3751.141.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 02 Jun 2003 10:39:41 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 09:59, Linus Torvalds wrote:
> On 2 Jun 2003, Juan Quintela wrote:
> > 
> > /**
> >  * foo - <put something there>
> >  * @bar: number of frobnicators
> >  * @baz: self-larting on or off
> >  * @userdata: pointer to arbitrary userdata to be registered
> >  *
> >  * Description: Please, fix me
> >  */
> > int foo(long bar, long baz)
> > {
> > ...
> > 
> > Looks like a better alternative to me.
> 
> Hey, if somebody were to send me a patch (hint hint), I'd happily apply 
> it.
> 
> 		Linus

I sent this last night as an example, except now the function
declaration is not wrapped.  How is this?

Steven

--- linux/lib/zlib_inflate/inftrees.c.orig	Mon Jun  2 10:15:29 2003
+++ linux/lib/zlib_inflate/inftrees.c	Mon Jun  2 10:16:47 2003
@@ -288,14 +288,16 @@
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
+int zlib_inflate_trees_bits(uIntf *c, uIntf *bb, inflate_huft * FAR *tb, inflate_huft *hp, z_streamp z)
 {
   int r;
   uInt hn = 0;          /* hufts used in space */



