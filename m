Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSGIMyf>; Tue, 9 Jul 2002 08:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSGIMye>; Tue, 9 Jul 2002 08:54:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20942 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315191AbSGIMya>;
	Tue, 9 Jul 2002 08:54:30 -0400
Date: Tue, 9 Jul 2002 14:56:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Anton Altaparmakov <aia21@cantab.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Message-ID: <20020709125656.GC1940@suse.de>
References: <Pine.SOL.3.96.1020709114618.20865B-100000@libra.cus.cam.ac.uk> <Pine.SOL.4.30.0207091447560.15575-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0207091447560.15575-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09 2002, Bartlomiej Zolnierkiewicz wrote:
> 
> On Tue, 9 Jul 2002, Anton Altaparmakov wrote:
> 
> > On Tue, 9 Jul 2002, Jens Axboe wrote:
> > > I've forward ported the 2.4 IDE core (well 2.4.19-pre10-ac2 to be exact)
> > > to 2.5.25. It consists of 7 separate patches:
> >
> > Fantastic! Seeing that the patches are bitkeeper generated, would it be
> > possible for you to make a repository available with the patches? (on
> > bkbits perhaps?) Would make it a lot easier for us bitkeeper users just to
> > pull from your repository... Especially once you update the patches...
> 
> Okay, tired of fantastic ;-)
> This forward port has still broken PIO transfer on errors and really
> borken multi PIO writes, all due to buffer_head -> bio transition in 2.5.

As I wrote in the initial posting, yes multi pio is broken _for multi
page bio's_. Where does 2.5 break pio transfers on error? If you are
talking about a 2.4 code base error, then I don't care, you need to tell
someone else :-)

> Jens, you would better spend your time on enhancing block layer to
> allow me fixing them cleanly...

I'll fix the bio support issue for pio multi write, it's in the next
version.

-- 
Jens Axboe

