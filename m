Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264871AbUFAR1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbUFAR1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUFAR1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:27:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:15039 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264871AbUFAR1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:27:52 -0400
Date: Tue, 1 Jun 2004 10:27:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
In-Reply-To: <16572.38987.239160.819836@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.58.0406011020310.14095@ppc970.osdl.org>
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se> <c892nk$5pf$1@terminus.zytor.com>
 <16572.38987.239160.819836@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Jun 2004, Mikael Pettersson wrote:
> 
> You're assuming pointers have uniform representation.

Are we?

I don't see any point where we cast any function pointers to anything 
else.

We cast data pointers all over the place, but that is actually guaranteed
to work in C for some "large enough" integer type, and "unsigned long" is
pretty much it. 

And even function pointers should be safeish. The fact that some broken
architecture (can you say "ia64"?) has totally idiotic calling conventions
and requires the caller to load the GP value is _their_ problem. The
architecture will either die or hide the fact that it's being silly. For
now it's hiding it.

Repeat after me: practice is more important than theory. A _lot_ more 
important.

		Linus
