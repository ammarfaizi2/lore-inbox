Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSG3Bq1>; Mon, 29 Jul 2002 21:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSG3Bq1>; Mon, 29 Jul 2002 21:46:27 -0400
Received: from zero.tech9.net ([209.61.188.187]:24074 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S318184AbSG3Bq0>;
	Mon, 29 Jul 2002 21:46:26 -0400
Subject: Re: [PATCH] spinlock.h cleanup
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207291845470.945-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207291845470.945-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 29 Jul 2002 18:49:48 -0700
Message-Id: <1027993788.1617.411.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 18:46, Linus Torvalds wrote:

> Check that again. The old check was for "(__GNUC__ > 2)", ie it would only
> trigger for gcc-3 and up.

Err, right.

> > If I recall correctly, the fix was for older egcs compilers.
> 
> I've got this memory of fairly recent gcc's messing up on sparc, for
> example.

The problem is indeed fixed in 2.95... the problem is not with those
compilers on sparc but that sparc64 uses an old compiler (DaveM
recommends 2.91.66 for sparc64).

Consequently, I sent you a rediff of the patch - this time without
removing the compiler workaround.  It should be acceptable.

	Robert Love

