Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTKEWzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 17:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTKEWzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 17:55:06 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:3334 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263260AbTKEWzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 17:55:02 -0500
Date: Wed, 5 Nov 2003 23:51:34 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
Message-ID: <20031105225134.GA14149@win.tue.nl>
References: <20031105204522.GA11431@work.bitmover.com> <20031105125813.A5648@one-eyed-alien.net> <20031105222302.GA12992@work.bitmover.com> <Pine.LNX.4.53.0311051733310.6824@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311051733310.6824@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 05:33:40PM -0500, Zwane Mwaikambo wrote:
> On Wed, 5 Nov 2003, Larry McVoy wrote:
> 
> > On Wed, Nov 05, 2003 at 12:58:13PM -0800, Matthew Dharm wrote:
> > > Out of curiosity, what were the changed lines?
> > 
> > --- GOOD        2003-11-05 13:46:44.000000000 -0800
> > +++ BAD 2003-11-05 13:46:53.000000000 -0800
> > @@ -1111,6 +1111,8 @@
> >                 schedule();
> >                 goto repeat;
> >         }
> > +       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))
> > +                       retval = -EINVAL;
> 
> That looks odd

Not if you hope to get root.

