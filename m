Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135613AbRDXNi6>; Tue, 24 Apr 2001 09:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135610AbRDXNi5>; Tue, 24 Apr 2001 09:38:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19620 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135614AbRDXNhN>;
	Tue, 24 Apr 2001 09:37:13 -0400
Date: Tue, 24 Apr 2001 09:37:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: ttel5535@artax.karlin.mff.cuni.cz
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.21.0104241508370.11387-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0104240926290.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Tomas Telensky wrote:

> of linux distributions the standard daemons (httpd, sendmail) are run as
> root! Having multi-user system or not! Why? For only listening to a port
> <1024? Is there any elegant solution?

Sendmail is old. Consider it as a remnant of times when network was
more... friendly. Security considerations were mostly ignored - and
not only by sendmail. It used to be choke-full of holes. They were
essentially debugged out of it in late 90s. It seems to be more or
less OK these days, but it's full of old cruft. And splitting the
thing into reasonable parts and leaving them with minaml privileges
they need is large and painful work.

There are alternatives (e.g. exim, or two unmentionable ones) that are
cleaner. Besides, there are some, erm, half-promises that next major
release of sendmail may be a big cleanup. Hell knows what will come out
of that.

