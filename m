Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTE3UfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbTE3UfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:35:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5133 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263998AbTE3UfQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:35:16 -0400
Date: Fri, 30 May 2003 13:48:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
In-Reply-To: <20030530204055.GB3308@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0305301344170.2421-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h4UKmCB12289
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 May 2003, Jörn Engel wrote:
> 
> I would agree with that strategy, if the zlib wasn't actively
> maintained anymore and we'd have to take over that part anyway.  But
> as it is, this will create extra work with little bonus on our side,
> except to set a better example maybe.
> 
> Linus, any insight to your reasons for this change?

I personally consider K&R prototypes to be useless, and downright evil. 
Any project who still has them is either lazy or still living in the 80's, 
and in either case I don't see any reason not to clean up the kernel side.

Besides, I'm not aware of any reason to ever really sync with zlib on that
level (the kinds of syncs I do foresee would be security issues or similar
if some exploit is found, but that's unlikely to be a major sync).

We've historically done other surgery to the zlib sources to make them a
bit more readable at times (the zlib allocator was just doing ridiculous
things, the kernel version was changed to allocate small structures
directly on the stack and embed others statically).

		Linus

