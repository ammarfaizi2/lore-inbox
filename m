Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261447AbSJMHVX>; Sun, 13 Oct 2002 03:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSJMHVW>; Sun, 13 Oct 2002 03:21:22 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:42390 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S261447AbSJMHVW>;
	Sun, 13 Oct 2002 03:21:22 -0400
Date: Sun, 13 Oct 2002 00:27:03 -0700
From: Simon Kirby <sim@netnation.com>
To: Rob Mueller <robm@fastmail.fm>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Jeremy Howard <jhoward@fastmail.fm>
Subject: Re: Strange load spikes on 2.4.19 kernel
Message-ID: <20021013072703.GA12395@netnation.com>
References: <0f3201c2718c$750a13b0$1900a8c0@lifebook> <3DA77A20.2D28DBE7@digeo.com> <0f4301c27196$af8a8880$1900a8c0@lifebook> <3DA791E0.F0A1B11@digeo.com> <0fe701c271b9$e86ea910$1900a8c0@lifebook> <3DA7C4C2.58BCE2BC@digeo.com> <0ff701c271bb$f2e8a0b0$1900a8c0@lifebook> <3DA7C87A.670EDD45@digeo.com> <111e01c2727f$c62239a0$1900a8c0@lifebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111e01c2727f$c62239a0$1900a8c0@lifebook>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 04:14:18PM +1000, Rob Mueller wrote:

> > Not yet.  Yours is only the second report.  Possible report.
> > Please try ordered mode.  The below will fix journalled
> > mode, if this is indeed the source of the problem
> 
> We tried applying this patch, but no change either. Again, we've tried both
> journaled and ordered.

Hmmm.. Your vmstat output looked a lot like our mail server when we
recently tried switching it to ext3.  We also saw large load spikes, but
I did not investigate it very closely.  Have you tried mounting as ext2
to see if journalling is responsible?

If it's a mail server, does it use dotlocking (creation and deletion of
lots of small/empty files)?  I haven't had any time recently to look at
this any further, but at the time I had guessed that this had something
to do with the constant write-out...

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
