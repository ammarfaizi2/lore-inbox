Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSGINNK>; Tue, 9 Jul 2002 09:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSGINLR>; Tue, 9 Jul 2002 09:11:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56284 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315245AbSGINLA>; Tue, 9 Jul 2002 09:11:00 -0400
Date: Tue, 9 Jul 2002 15:13:21 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Anton Altaparmakov <aia21@cantab.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] 2.4 IDE core for 2.5
In-Reply-To: <20020709125656.GC1940@suse.de>
Message-ID: <Pine.SOL.4.30.0207091510450.28198-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jul 2002, Jens Axboe wrote:

> On Tue, Jul 09 2002, Bartlomiej Zolnierkiewicz wrote:
> >
> > On Tue, 9 Jul 2002, Anton Altaparmakov wrote:
> >
> > > On Tue, 9 Jul 2002, Jens Axboe wrote:
> > > > I've forward ported the 2.4 IDE core (well 2.4.19-pre10-ac2 to be exact)
> > > > to 2.5.25. It consists of 7 separate patches:
> > >
> > > Fantastic! Seeing that the patches are bitkeeper generated, would it be
> > > possible for you to make a repository available with the patches? (on
> > > bkbits perhaps?) Would make it a lot easier for us bitkeeper users just to
> > > pull from your repository... Especially once you update the patches...
> >
> > Okay, tired of fantastic ;-)
> > This forward port has still broken PIO transfer on errors and really
> > borken multi PIO writes, all due to buffer_head -> bio transition in 2.5.
>
> As I wrote in the initial posting, yes multi pio is broken _for multi
> page bio's_. Where does 2.5 break pio transfers on error? If you are
> talking about a 2.4 code base error, then I don't care, you need to tell
> someone else :-)

PIO on error is broken _for multi page bio's_ .

> > Jens, you would better spend your time on enhancing block layer to
> > allow me fixing them cleanly...
>
> I'll fix the bio support issue for pio multi write, it's in the next
> version.

Okay, will see... :)

--
Bartlomiej

