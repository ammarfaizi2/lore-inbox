Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSLIULc>; Mon, 9 Dec 2002 15:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbSLIULc>; Mon, 9 Dec 2002 15:11:32 -0500
Received: from fe3.in.gr ([194.63.247.134]:61420 "EHLO fe3.in.gr")
	by vger.kernel.org with ESMTP id <S265960AbSLIULb> convert rfc822-to-8bit;
	Mon, 9 Dec 2002 15:11:31 -0500
Content-Class: urn:content-classes:message
From: <kernel@in.gr>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Date: Mon, 9 Dec 2002 22:19:03 +0200
Message-ID: <4bb901c29fc0$37d81340$0205030a@internal.ramnet.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Microsoft CDO for Windows 2000
Thread-Index: AcKfwDfYcAEiUQkcRZSB6b+qT71akQ==
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I confirm that 2.5 is much much much better. On a dual Pentium pro@180MHz i had 48 lames encoding wave to mp3 and X where responding as nothing has happening....
With 2.4 kaboom! Even the mouse slows down!

Nice work Ingo ;)

George


On Sun, 8 Dec 2002, Andrew Morton wrote:

> Yes, thanks.  Will we also be seeing the "interactivity estimator" fixes
> in 2.5?

yes, but i'd like to clarify one more thing - worst-case O(1)  
interactivity indeed is indeed very jerky (eg. the fast window moving
thing you noticed), but the normal behavior is much better than the old
scheduler's. Just try compiling the kernel with make -j4 under stock 2.4
and _everything_ in X will be jerky. With the O(1) scheduler things are
just as smooth as on an idle system - as long as your application does not
get rated CPU-intensive. [which happens too fast in the case you
described.] So we do have something in 2.5 that is visibly better in a
number of cases, and i want to preserve that - while fixing the
corner-cases discussed here. I'm working on it.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
