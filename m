Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTFUQvx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 12:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbTFUQvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 12:51:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25605 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264961AbTFUQvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 12:51:52 -0400
Date: Sat, 21 Jun 2003 10:05:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [SPARSE] increase MAXNEST constant
In-Reply-To: <200306211353.43512.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44.0306211004180.2384-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Jun 2003, Arnd Bergmann wrote:
>
> The MAXNEST constant in sparse is currently too small for
> checking most of the kernel files.

Thanks, right you are. I fixed it a bit differently, in particular it 
doesn't need an "int", it really needs just one bit per level, but I left 
it at "char" instead.

>				 The deepest nesting
> I found in the kernel is 25, so MAXNEST=32 should probably
> be sufficient. It would be nice to check overruns here,
> but I did not know where to best do it.

I did that too (and I made the size of the nesting be 256, since changing 
it to a char means that it's fairly small).

		Linus

