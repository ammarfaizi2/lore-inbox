Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTELNRx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTELNRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:17:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60346 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262136AbTELNRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:17:50 -0400
Date: Mon, 12 May 2003 15:30:08 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Oleg Drokin <green@namesys.com>
cc: <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Oliver Neukum <oliver@neukum.org>, <lkhelp@rekl.yi.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69, IDE TCQ can't be enabled
In-Reply-To: <20030512132209.GB4165@namesys.com>
Message-ID: <Pine.SOL.4.30.0305121523550.18058-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 May 2003, Oleg Drokin wrote:

> Hello!
>
> On Mon, May 12, 2003 at 03:16:17PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > Just a note that we have found TCQ unusable on our IBM drives and we had
> > > > some reports about TCQ unusable on some WD drives.
> > > > Unusable means severe FS corruptions starting from mount.
> > > > So if your FSs will suddenly start to break, start looking for cause with
> > > > disabling TCQ, please.
> > > I can confirm that. This drive Model=IBM-DTLA-307045, FwRev=TX6OA60A,
> > > SerialNo=YMCYMT3Y229 has eaten my filesystem with TCQ on 2.5.69
> > TCQ is marked EXPERIMENTAL and is known to be broken.
> > Probably it should be marked DANGEROUS or removed?
>
> How do you think people will test code that is removed?

I wanted to remove config option, just like it is for ide-tape.c
currently. But yes, its better to mark it DANGEROUS...

> Or do you mean that nobody plans to look at this ever?
> I remember that Jens Axboe promised to take a look at it some
> months ago.

many months ago :\

btw, some older disks have broken TCQ implementation...
--
Bartlomiej

> Bye,
>     Oleg

