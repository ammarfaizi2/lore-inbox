Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275061AbRIYPvI>; Tue, 25 Sep 2001 11:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275062AbRIYPu6>; Tue, 25 Sep 2001 11:50:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16393 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275061AbRIYPus>; Tue, 25 Sep 2001 11:50:48 -0400
Date: Tue, 25 Sep 2001 08:50:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM: what avoids from having lots of unwriteable inactive
 pages
In-Reply-To: <Pine.LNX.4.33L.0109251203560.26091-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109250849480.7353-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Sep 2001, Rik van Riel wrote:
> >
> > swap_out() will deactivate everything it finds to be not-recently used,
> > and that's how the inactive list ends up getting replenished.
>
> mlock()

Hey, if you've mlock'ed more than your available memory, there's nothing
the VM layer can do. Except maybe a nice printk("Kiss your *ss goodbye");

		Linus

