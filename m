Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVJRDca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVJRDca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 23:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVJRDca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 23:32:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932405AbVJRDca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 23:32:30 -0400
Date: Mon, 17 Oct 2005 20:31:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: WU Fengguang <wfg@mail.ustc.edu.cn>
Cc: joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] Adaptive read-ahead v4
Message-Id: <20051017203137.05350739.akpm@osdl.org>
In-Reply-To: <20051018025806.GA3963@mail.ustc.edu.cn>
References: <20051015174731.GA5851@mail.ustc.edu.cn>
	<20051017173034.GA6558@wohnheim.fh-wedel.de>
	<20051018025806.GA3963@mail.ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WU Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> ...
> > > +	unsigned long pgra_backward;
> > > +	unsigned long pgra_backward_hit;
> > > +	unsigned long pgra_backward_eof;
> > > +
> > > +	unsigned long ra_random;	/* read-ahead on seek-and-read-pages */
> > > +	unsigned long ra_random_return;
> > > +	unsigned long ra_random_eof;
> > > +	unsigned long pgra_random;
> > > +	unsigned long pgra_random_hit;
> > > +	unsigned long pgra_random_eof;
> > > +
> > >  };
> > 
> > Without actually understanding what you're doing, wouldn't a struct
> > for all those groups make sense?  I bet it can simplify the actual
> > code as well.
> Yeah, I did not expect the structure to grow so large.

All that stuff shouldn't remain there long-term.

> It should be better to create a stand alone struct and create a
> dedicated entry in /proc/. The data would be a nice hint for
> administrators who care the performance.

You should treat such informaton as a development aid, really.  People are
very unlikely to look at it in real life.

