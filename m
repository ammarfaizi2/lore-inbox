Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270847AbTHGXln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271091AbTHGXln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:41:43 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:20195 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S270847AbTHGXlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:41:42 -0400
Date: Fri, 8 Aug 2003 01:41:40 +0200 (MEST)
Message-Id: <200308072341.h77NfeF4025095@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: ide-tape broken (was Re: [PATCH] use ide-identify.h, fix endian bug)
Cc: Andries.Brouwer@cwi.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003 22:51:31 +0200 (MET DST), Bartlomiej Zolnierkiewicz wrote:
>On Thu, 7 Aug 2003 Andries.Brouwer@cwi.nl wrote:
>
>> Given ide-identify.h, we can simplify ide-floppy.c and ide-tape.c a lot.
>> In fact ide-tape.c was broken on big-endian machines.
>> (Unfortunately much more is broken that was fixed here,
>> ide-tape.c is not in a good shape today.)
>
>ide-tape is broken because nobody cares, so I don't care too
>(was broken even before).  It needs rewrite and testing.
>
>So once again if anybody cares and has hardware to test,
>please contact me and I will try fix it.
>
>Until then I don't touch it et all and consider it obsoleted.

I used to use the ide-tape driver for my Seagate STT8000A,
but its prolonged brokenness in 2.5 (caused initially by the
bio changes) made me switch to ide-scsi + st instead since
that at least _works_.

I can test updates as they hit Linus 2.6-releases, but frankly
I'd rather use ide-scsi+st or a new clean ATAPI tape driver
than ide-tape.c. (I've studied ide-tape.c. It reeks of poor
coding style, kludges for Onstream, and an over-engineered
buffering scheme. And it's known to have problems with DMA.)

/Mikael
