Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273990AbRIYVZF>; Tue, 25 Sep 2001 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274185AbRIYVY4>; Tue, 25 Sep 2001 17:24:56 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45316 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273990AbRIYVYi>; Tue, 25 Sep 2001 17:24:38 -0400
Date: Tue, 25 Sep 2001 17:01:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rick Haines <rick@kuroyi.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM: what avoids from having lots of unwriteable inactive
 pages
In-Reply-To: <20010925172016.B860@sasami.kuroyi.net>
Message-ID: <Pine.LNX.4.21.0109251700370.2193-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Sep 2001, Rick Haines wrote:

> On Tue, Sep 25, 2001 at 01:13:37PM -0300, Rik van Riel wrote:
> > On Tue, 25 Sep 2001, Linus Torvalds wrote:
> > > On Tue, 25 Sep 2001, Rik van Riel wrote:
> > > > >
> > > > > swap_out() will deactivate everything it finds to be not-recently used,
> > > > > and that's how the inactive list ends up getting replenished.
> > > >
> > > > mlock()
> > >
> > > Hey, if you've mlock'ed more than your available memory, there's nothing
> > > the VM layer can do. Except maybe a nice printk("Kiss your *ss goodbye");
> 
> Shouldn't there be a threshold where mlock will fail?

There is (for users). Take a look at ulimit:

 -l     The maximum size that may be locked into memory



> Or are you saying that in general mlocking lots of memory will screw the
> VM?

Yes it will.

