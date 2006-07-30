Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWG3Sac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWG3Sac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWG3Sac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:30:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932415AbWG3Sab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:30:31 -0400
Date: Sun, 30 Jul 2006 11:29:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, nikita@clusterfs.com,
       joe@perches.com, tali@admingilde.org, jbglaw@lug-owl.de,
       hch@infradead.org, dwmw2@infradead.org, arjan@infradead.org,
       dmitry.torokhov@gmail.com, Valdis.Kletnieks@vt.edu, sam@ravnborg.org,
       rmk@arm.linux.org.uk, rusty@rustcorp.com.au, rdunlap@xenotime.net
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial
 step
Message-Id: <20060730112917.88d9ae4e.akpm@osdl.org>
In-Reply-To: <m3wt9vj94n.fsf@defiant.localdomain>
References: <200607301830.01659.jesper.juhl@gmail.com>
	<m3ac6rkp8c.fsf@defiant.localdomain>
	<9a8748490607301014rf04b6cew9d991635a7834277@mail.gmail.com>
	<m3wt9vj94n.fsf@defiant.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 19:27:36 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> "Jesper Juhl" <jesper.juhl@gmail.com> writes:
> 
> > I think it's a good thing that we have to take a little more care when
> > choosing global function and variable names... Take up() for example -
> > in my (very humble) oppinion that is a very bad name for a global
> > function - it clashes too easily with local function and variable
> > names, and a programmer who's not careful may end up calling the
> > global up() when he wants the local and vice versa (a much better name
> > would have been sem_up() - should we change that???).
> 
> Possibly, but it could then conflict with something else. Anytime we
> add/change some global symbol, we would have to scan entire kernel
> for conflicts (authors of (yet) off-tree things would hate us).

These things happen.  And it's only a warning.

> I don't think it's practical, especially with, IMHO, no real gain.

While I don't recall any kernel bugs which -Wshadow would have saved us
from, I think it's a sensible thing to do - it _might_ save us from a bug,
and we need all the help we can get.

Plus it's often the case that if a local and a global clash, one of the
identifiers was poorly chosen.

