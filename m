Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTELDtW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTELDsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:48:23 -0400
Received: from dp.samba.org ([66.70.73.150]:7917 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261872AbTELDsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:48:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Jeremy Jackson" <jerj@coplanar.net>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Switch ide parameters to new-style and make them unique. 
In-reply-to: Your message of "Sun, 11 May 2003 10:59:59 -0400."
             <005201c317cd$febb2d00$7c07a8c0@kennet.coplanar.net> 
Date: Mon, 12 May 2003 12:21:26 +1000
Message-Id: <20030512040100.DA6992C0DC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <005201c317cd$febb2d00$7c07a8c0@kennet.coplanar.net> you write:
> I think at some point, the kernel command line parameters should be
> consolidated behind a single ata=hda,noprobe or ata=if0,io0x1f0,irq7 type
> parameter, instead of the hda= and ide0=.  Taking that one step furthur, a
> new syntax is needed, and having it go into 2.6 might pave the way for
> removing the old cruft in 2.8?

The idea behind module_param* is to promote conformity, so a module
foo will have command line params starting with "foo.", as well as
easing the burden of double-implementation on kernel coders.

Naturally, this transition will take a long time (ie. forever):
breaking command line params is not something to be done lightly, even
in a major point transition.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
