Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268898AbTGJDmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268903AbTGJDmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:42:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:38115 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S268898AbTGJDmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:42:40 -0400
Date: Thu, 10 Jul 2003 00:54:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC:  what's in a stable series?
In-Reply-To: <3F0CBC08.1060201@pobox.com>
Message-ID: <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>
References: <3F0CBC08.1060201@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jul 2003, Jeff Garzik wrote:

> Does it mean, no API changes except for security (or similarly severe) bugs?
> Does it mean, no userland ABI changes, but API changes affecting onto
> the kernel are ok?
> Does it mean, "just don't break things such that people are pissed off"?

My initial though on some new feature is to avoid it. We are a stable
release, after all.

The quota patches have been around for a long time, and Jan Kara has been
trying to include for sometime now (since 2.4.20/21). I tried to avoid it.

Now I realized the possible drawbacks of it are minimal (if any) compared
to the overall advantage it brings to Linux 2.4.

The same goes for ACPI, people have been trying to include it for a long
time, and I prefered to reject it until 2.4.22-pre.

Its a case-by-case problem.  You can't have a general rules like "no API
changes except for security (or similarly severe) bugs? Does it mean, no
userland ABI changes, but API changes affecting onto the kernel are ok?"

I reverted the direct IO patches because hch complained on me that they
change the direct IO API, and we really dont want that kind of
change, IMHO.

Trond/Christoph/you now have the direct_io2 possibility, which wouldnt
break the current API and still get us the desired "feature".

> I request the community's input, particularly those CC'd, for some sort
> of direction or consensus on this.
>
> In any case, I personally feel that increased stability of the API,
> coupled with the increased frequency of releases, will make the most
> people happy.  I would prefer some sort of 2.4.x API freeze, say
> post-2.4.22, but maybe that's too radical?

I also plan a 2.4.x API freeze. Maybe latter.

In general, I think each case is a case and has its tradeoffs which need
to be discussed and agreed on.
