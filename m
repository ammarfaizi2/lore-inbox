Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWG3R1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWG3R1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWG3R1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:27:39 -0400
Received: from khc.piap.pl ([195.187.100.11]:31926 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932377AbWG3R1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:27:38 -0400
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Nikita Danilov" <nikita@clusterfs.com>,
       "Joe Perches" <joe@perches.com>, "Martin Waitz" <tali@admingilde.org>,
       "Jan-Benedict Glaw" <jbglaw@lug-owl.de>,
       "Christoph Hellwig" <hch@infradead.org>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Valdis Kletnieks" <Valdis.Kletnieks@vt.edu>,
       "Sam Ravnborg" <sam@ravnborg.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Rusty Russell" <rusty@rustcorp.com.au>,
       "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial step
References: <200607301830.01659.jesper.juhl@gmail.com>
	<m3ac6rkp8c.fsf@defiant.localdomain>
	<9a8748490607301014rf04b6cew9d991635a7834277@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 30 Jul 2006 19:27:36 +0200
In-Reply-To: <9a8748490607301014rf04b6cew9d991635a7834277@mail.gmail.com> (Jesper Juhl's message of "Sun, 30 Jul 2006 19:14:06 +0200")
Message-ID: <m3wt9vj94n.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> writes:

> I think it's a good thing that we have to take a little more care when
> choosing global function and variable names... Take up() for example -
> in my (very humble) oppinion that is a very bad name for a global
> function - it clashes too easily with local function and variable
> names, and a programmer who's not careful may end up calling the
> global up() when he wants the local and vice versa (a much better name
> would have been sem_up() - should we change that???).

Possibly, but it could then conflict with something else. Anytime we
add/change some global symbol, we would have to scan entire kernel
for conflicts (authors of (yet) off-tree things would hate us).
I don't think it's practical, especially with, IMHO, no real gain.

> I don't agree with you and I don't know how to convince you, but I
> still appreciate your feedback.
> Thanks.

You're welcome. I'd be more happy if I could say I like the idea :-(

> I'll leave it to people higher in the hierarchy to decide if these
> patches should be applied or not ;)

Sure.
-- 
Krzysztof Halasa
