Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265422AbUGDGxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUGDGxM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 02:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUGDGxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 02:53:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:51400 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265422AbUGDGxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 02:53:00 -0400
Date: Sat, 3 Jul 2004 23:51:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: pluto@pld-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [prefetch.h] warning: pointer of type `void *' used in
 arithmetic'
Message-Id: <20040703235150.4b569f34.akpm@osdl.org>
In-Reply-To: <20040704064920.GA1194@ucw.cz>
References: <200407031832.34780.pluto@pld-linux.org>
	<20040703171811.1f10c5df.akpm@osdl.org>
	<20040704064920.GA1194@ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> On Sat, Jul 03, 2004 at 05:18:11PM -0700, Andrew Morton wrote:
> > Pawe__ Sikora <pluto@pld-linux.org> wrote:
> > >
> > > warning killed.
> > 
> > >  --- /var/tmp/linux/include/linux/prefetch.h.orig	2004-06-16 07:20:25.000000000 +0200
> > >  +++ /var/tmp/linux/include/linux/prefetch.h	2004-07-03 18:28:10.478861720 +0200
> > >  @@ -59,7 +59,7 @@
> > >   {
> > >   #ifdef ARCH_HAS_PREFETCH
> > >   	char *cp;
> > >  -	char *end = addr + len;
> > >  +	char *end = (char *)addr + len;
> > 
> > What version of the compiler is generating this warning?
> 
> As far as I know, any gcc if and only if you pass "-Wpointer-arith" to
> it. The kernel doesn't do that, leaving me wondering ...
> 

This discussion fell off the mailing list (grr).

The warning was encountered when building the nvidia driver, and it indeed
uses -Wpointer-arith.
