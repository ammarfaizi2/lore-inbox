Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUCTQWa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUCTQW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:22:29 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17810 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263462AbUCTQW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:22:26 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 17:30:38 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>
References: <20040319153554.GC2933@suse.de> <20040320101929.GF2711@suse.de> <405C1EF2.9070201@pobox.com>
In-Reply-To: <405C1EF2.9070201@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403201730.38266.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 11:37, Jeff Garzik wrote:
> Jens Axboe wrote:
> > On Sat, Mar 20 2004, Jeff Garzik wrote:
> >>Jens Axboe wrote:
> >>>I agree with Bart, it's usually never that clear. Quit harping the
> >>>stupid LG issue, they did something brain dead in the firmware and I
> >>>almost have to say that they got what they deserved for doing something
> >>>as _stupid_ as that.
> >>
> >>I use it because it's an excellent illustration of what happens when you
> >>ignore the spec.
> >
> > Really, I think it's a much better demonstration of exactly how stupid
> > hardware developers are at times...
>
> No argument.  But their behavior, however awful, _was_ reported in
> places where a spec-driven driver would have noticed... :)
>
> >>>Jeff, it's wonderful to think that you can always rely on checking spec
> >>>bits, but in reality it never really 'just works out' for any given set
> >>>of hardware.
> >>
> >>"just issue it and hope" is not a reasonable plan, IMO.
> >
> > I agree with that as well. I just didn't agree with your rosy idea of
> > thinking everything would always work if you just check the bits
> > according to spec.
>
> Everything _will_ always work, if you check the bits according to spec.
>      Not reporting the flush-cache feature bit, when it really the
> opcode exists, isn't a spec violation.  The opposite is, and I haven't
> heard of any such drives :)
>
> AFAICS:
> * for ATA versions where flush-cache is optional, you must check the
> bit.  otherwise, issuing flush-cache would be very unwise.

There is not flush-cache bit in both ATA-4 (command optional)
and ATA-5 (command mandatory).

> * for ATA versions where flush-cache is mandatory...  the argument can
> be made that issuing a flush-cache in the absence of the bit isn't a bad
> thing.  I'm not sure I agree with that, but I'm willing to be convinced.
>
> "just check the bits" always works because it is the conservative
> choice...  but it can lead to suboptimal (but valid!) behavior by
> ignoring some devices' flush-cache capability.

It's just damn too conservative.

> If it's only a few drives out there that misreport their flush-cache
> bit, then who cares --> just more broken hardware, that we won't issue a
> flush-cache on.  If it's a lot of drives, that changes things...

They don't misreport!  They comply with the spec (ATA-4 or ATA-5).

Jeff, please RTFSPEC. ;-)

Cheers,
Bartlomiej

