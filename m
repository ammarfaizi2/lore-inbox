Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTEaEyv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 00:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTEaEyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 00:54:51 -0400
Received: from miranda.zianet.com ([216.234.192.169]:47121 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264143AbTEaEyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 00:54:50 -0400
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function
	declarations.
From: Steven Cole <elenstev@mesatop.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20030531031231.GE5783@conectiva.com.br>
References: <Pine.LNX.4.44.0305301414210.2671-100000@home.transmeta.com>
	 <1054342517.2901.78.camel@spc>  <20030531031231.GE5783@conectiva.com.br>
Content-Type: text/plain
Organization: 
Message-Id: <1054357685.2899.109.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 30 May 2003 23:08:05 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-30 at 21:12, Arnaldo Carvalho de Melo wrote:
[snippage]
> > > and the ANSI-fication changes this to
> > > 
> > > 	int foo(
> > > 		long bar,	/* number of frobnicators */
> > > 		long baz	/* self-larting on or off */
> > > 	)
> > > 	{
> > > 		...
> > > 
> > > which while not according to the coding-standard is at least a reasonable 
> > > compromize between having proper C function definitions and keeping the 
> > > code _looking_ more like the original.
> > > 
> > > 		Linus
> > > 
> > > 
> > OK, here is a modified version of the patch to CodingStyle which
> > explicitly notes the reason for this secondary style.
> 
> In the cases where there are documentation for the paramenters isn't it better
> to just bite the bullet and use the kerneldoc style?
> 
> Documentation/kernel-doc-nano-HOWTO.txt
> 
> - Arnaldo
> 

Of course it would be better if code were documented in a consistent and
canonical style.  The Documentation/kernel-doc-nano-HOWTO.txt method
should probably have a one line mention in Chapter 5: Commenting, like
this:

--- linux/Documentation/CodingStyle.orig	2003-05-30 18:41:05.000000000 -0600
+++ linux/Documentation/CodingStyle	2003-05-30 22:47:55.000000000 -0600
@@ -164,7 +164,7 @@
 small comments to note or warn about something particularly clever (or
 ugly), but try to avoid excess.  Instead, put the comments at the head
 of the function, telling people what it does, and possibly WHY it does
-it. 
+it.  See Documentation/kernel-doc-nano-HOWTO.txt for details.
 
 
 		Chapter 6: You've made a mess of it


My purpose with the original patch was to canonify the unusual style
discussed above. 

The note about the old-style K&R prototypes being deprecated is probably
redundant and may be unnecessary, unless someone is copying and pasting
from some old System V code, and we all know that makes about as much
sense as Boeing secretly looking over the blueprints for the Douglas
DC-3.

Steven

