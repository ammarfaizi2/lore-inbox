Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751988AbWJWQNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbWJWQNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWJWQNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:13:53 -0400
Received: from witte.sonytel.be ([80.88.33.193]:55202 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751984AbWJWQNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:13:52 -0400
Date: Mon, 23 Oct 2006 18:13:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andi Kleen <ak@suse.de>, Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <Pine.LNX.4.64.0610230908570.3962@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0610231812290.1841@pademelon.sonytel.be>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <20061020091302.a2a85fb1.rdunlap@xenotime.net>
 <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be> <200610230059.23806.ak@suse.de>
 <Pine.LNX.4.62.0610231027130.1272@pademelon.sonytel.be>
 <Pine.LNX.4.64.0610230908570.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006, Linus Torvalds wrote:
> On Mon, 23 Oct 2006, Geert Uytterhoeven wrote:
> > > Would be a worthy goal imho. Can it be done with scripts? 
> > 
> > Making them self-contained or checking whether they are? :-)
> > 
> > The latter is simple, just compile each of them into dummy object files, which
> > should give no compile errors.
> 
> It's _not_ simple. Not at all.
> 
> We have tons of issues that depend on config variables and architecture 
> details. 

Indeed, so the config variables and architecture details should be handled in
the include files, not in the (multiple) users of those include files.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
