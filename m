Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTELSDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTELSCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:02:25 -0400
Received: from mcomail01.maxtor.com ([134.6.76.15]:50445 "EHLO
	mcomail01.maxtor.com") by vger.kernel.org with ESMTP
	id S262427AbTELRqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:46:07 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D31A@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Jens Axboe'" <axboe@suse.de>, Oleg Drokin <green@namesys.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: RE: 2.5.69, IDE TCQ can't be enabled
Date: Mon, 12 May 2003 11:58:10 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The only difference between SATA TCQ and PATA TCQ is that in PATA TCQ, the
drive doesn't report the active tag bitmap back to the host after each
command.  Other than that they are functionally identical to my
understanding.  (Yes, there are options like first-party DMA, but these are
not requirements)

Personally I'd like to see the option stay in there as experimental, it
helps us drive folks test stuff when we can just flip an option off/on to
get that functionality.

--eric

-----Original Message-----
From: Jens Axboe [mailto:axboe@suse.de]
Sent: Monday, May 12, 2003 7:24 AM
To: Oleg Drokin
Cc: Bartlomiej Zolnierkiewicz; Alan Cox; Oliver Neukum;
lkhelp@rekl.yi.org; linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled


On Mon, May 12 2003, Oleg Drokin wrote:
> Hello!
> 
> On Mon, May 12, 2003 at 03:16:17PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > Just a note that we have found TCQ unusable on our IBM drives and we
had
> > > > some reports about TCQ unusable on some WD drives.
> > > > Unusable means severe FS corruptions starting from mount.
> > > > So if your FSs will suddenly start to break, start looking for cause
with
> > > > disabling TCQ, please.
> > > I can confirm that. This drive Model=IBM-DTLA-307045, FwRev=TX6OA60A,
> > > SerialNo=YMCYMT3Y229 has eaten my filesystem with TCQ on 2.5.69
> > TCQ is marked EXPERIMENTAL and is known to be broken.
> > Probably it should be marked DANGEROUS or removed?
> 
> How do you think people will test code that is removed?
> Or do you mean that nobody plans to look at this ever?
> I remember that Jens Axboe promised to take a look at it some
> months ago.

Yeah, that is correct. OTOH, it's not a great loss. The SATA tcq will be
much better, ide tcq is a really horrible beast.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
