Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUCIBZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 20:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUCIBZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 20:25:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:59529 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261429AbUCIBZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 20:25:33 -0500
Date: Mon, 8 Mar 2004 17:32:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Schlichter <thomas.schlichter@web.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
In-Reply-To: <200403090217.40867.thomas.schlichter@web.de>
Message-ID: <Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
References: <200403090043.21043.thomas.schlichter@web.de>
 <20040308161410.49127bdf.akpm@osdl.org> <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
 <200403090217.40867.thomas.schlichter@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Mar 2004, Thomas Schlichter wrote:
>
> Am Dienstag, 9. März 2004 01:32 schrieb Linus Torvalds:
> 
> ~~ snip ~~
> 
> > The warnings the extra "const" fixes is something like:
> >
> > 	int a;
> > 	const int b;
> >
> > 	min(a,b)
> >
> > where otherwise it would complain about pointers to different types when
> > comparing the type of the pointer. Or something.
> 
> OK, I tested it and gcc 3.3.1 does not complain about this. So with my patch, 
> the duplicate 'const' warning goes away here and no other warning occours...

Yeah, but do keep in mind that "something like" comment. I'm by no means 
sure that I remembered the exact reason correctly, and maybe they aren't 
really needed.

Also, I'm not convinced this isn't a gcc regression. It would be stupid to 
"fix" something that makes old gcc's complain, when they may be doing the 
right thing.

All that code was from early 2002 (around 2.4.9), so maybe somebody can 
find the full discussion on the linux-kernel archives from January 2002 or 
so?

			Linus
