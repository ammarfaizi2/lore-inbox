Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265424AbUGDGtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265424AbUGDGtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 02:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbUGDGtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 02:49:09 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:10625 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265424AbUGDGtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 02:49:06 -0400
Date: Sun, 4 Jul 2004 08:49:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Pawe__ Sikora <pluto@pld-linux.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [prefetch.h] warning: pointer of type `void *' used in arithmetic'
Message-ID: <20040704064920.GA1194@ucw.cz>
References: <200407031832.34780.pluto@pld-linux.org> <20040703171811.1f10c5df.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703171811.1f10c5df.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 05:18:11PM -0700, Andrew Morton wrote:
> Pawe__ Sikora <pluto@pld-linux.org> wrote:
> >
> > warning killed.
> 
> >  --- /var/tmp/linux/include/linux/prefetch.h.orig	2004-06-16 07:20:25.000000000 +0200
> >  +++ /var/tmp/linux/include/linux/prefetch.h	2004-07-03 18:28:10.478861720 +0200
> >  @@ -59,7 +59,7 @@
> >   {
> >   #ifdef ARCH_HAS_PREFETCH
> >   	char *cp;
> >  -	char *end = addr + len;
> >  +	char *end = (char *)addr + len;
> 
> What version of the compiler is generating this warning?

As far as I know, any gcc if and only if you pass "-Wpointer-arith" to
it. The kernel doesn't do that, leaving me wondering ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
