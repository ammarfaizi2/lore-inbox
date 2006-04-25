Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWDYRzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWDYRzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWDYRzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:55:31 -0400
Received: from witte.sonytel.be ([80.88.33.193]:35560 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751186AbWDYRz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:55:29 -0400
Date: Tue, 25 Apr 2006 19:55:14 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Avi Kivity <avi@argo.co.il>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
In-Reply-To: <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>
Message-ID: <Pine.LNX.4.62.0604251952460.19752@pademelon.sonytel.be>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
 <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il>
 <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <444DCAD2.4050906@argo.co.il>
 <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006, Kyle Moffett wrote:
> On Apr 25, 2006, at 03:08:02, Avi Kivity wrote:
> > {
> >    spinlock_t::guard foo_guard(foo_lock);
> >    Foo item1;
> >    Foo item2;
> > }
> 
> Let me point out _again_ how unobvious and fragile the flow of code there is.
> Not to mention the fact that the C++ compiler can easily notice that item1 and
> item2 are never used and optimize them out entirely.  You also totally missed

Only if the constructor and destructor of Foo is inline. Else there may be side
effects.

This is commonly used for function scope debugging, and I never saw the
compiler optimize away any of these debug objects, even if they look unused to
the casual reader.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
