Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUDAJJW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbUDAJIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:08:19 -0500
Received: from witte.sonytel.be ([80.88.33.193]:65434 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262794AbUDAJHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:07:20 -0500
Date: Thu, 1 Apr 2004 11:06:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andries Brouwer <aebr@win.tue.nl>, Andre Hedrick <andre@linux-ide.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Bogus LBA48 drives
In-Reply-To: <406B14C1.8000708@pobox.com>
Message-ID: <Pine.GSO.4.58.0404010933190.12148@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be>
 <Pine.LNX.4.10.10403300821520.11654-100000@master.linux-ide.org>
 <20040331183410.GA3796@pclin040.win.tue.nl> <406B14C1.8000708@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, Jeff Garzik wrote:
> Andries Brouwer wrote:
> > Hmm. I read in my copy of ATA7:
> >
> >  6.16.55 Words (103:100): Maximum user LBA for 48-bit Address feature set
> >  Words (103:100) contain a value that is one greater than the maximum LBA
> >  in user accessable space when the 48-bit Addressing feature set is supported.
> >  The maximum value that shall be placed in this field is 0000FFFFFFFFFFFFh.
> >  Support of these words is mandatory if the 48-bit Address feature set is supported.
> >
> > Do you read differently?
>
> The errata is, one needs to check that field for zero, and use the other
> one if so...

Which is not sufficient for `my' drives, since I get disk errors if I just use
the other capacity field and don't disable LBA48 completely.

I'll check the ATA specs myself, if I find some time...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
