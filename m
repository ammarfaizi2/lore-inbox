Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbTIOFQJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 01:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTIOFQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 01:16:09 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:62660 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262438AbTIOFQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 01:16:06 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva>
	<Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva>
	<Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva>
	<20030830231904.GL24409@dualathlon.random>
	<1062339003.10208.1.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062339003.10208.1.camel@dhcp23.swansea.linux.org.uk>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 15 Sep 2003 01:16:03 -0400
Message-ID: <87y8wq638s.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sul, 2003-08-31 at 00:19, Andrea Arcangeli wrote:
> > I've an algorithm that will work, and that will provide very good
> > guarantees to kill the "best" task to make the machine usable again,
> > with the needed protection against the security DoSes, but it's in
> > no-way similar to the current oom killer.
> 
> And -ac has trivial code so you can avoid OOM killing every happening,
> which is pretty much essential for big servers. Perhaps merging that
> as well would be a good idea.

Indeed there has been an enormous amount of discussion on the postgres mailing
list about how to deal with the OOM killer. The wide consensus there is that
the only sane setting for a production database would be one that guarantees
never to kill overcommit at all.

Frankly, they're a bit in shock that this wasn't an option a long time ago.

Consider e.g.:

http://groups.google.com/groups?threadm=3F510688.1050709%40colorfullife.com

-- 
greg

