Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271415AbTG2PKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271695AbTG2PKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:10:21 -0400
Received: from mx.laposte.net ([213.30.181.11]:23451 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S271415AbTG2PKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:10:17 -0400
Message-ID: <000d01c355e3$7f5dd9a0$0a00a8c0@toumi>
From: "Ghozlane Toumi" <gtoumi@laposte.net>
To: "Andries Brouwer" <aebr@win.tue.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <UTC200307281315.h6SDFOY08368.aeb@smtp.cwi.nl> <030201c3550f$dec61620$0a00a8c0@toumi> <041201c35551$8af611c0$0a00a8c0@toumi> <20030728230951.GC1845@win.tue.nl>
Subject: Re: [PATCH] sgi partitionning fix (Was: 2.6.0-test1 on alpha : disk label numbering trouble)
Date: Tue, 29 Jul 2003 13:00:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote :
> On Mon, Jul 28, 2003 at 11:45:12PM +0200, Ghozlane Toumi wrote:
> 
> > However, I found out that sgi partitionning had this "renumbering"
> > issue even before viro's patch.
> > I don't know if this is correct, in any case this is an untested patch
> > that changes this behaviour for sgi partitions.
> > patch is attached because of dumb mailer.
> > --------------------
> >         for(i = 0; i < 16; i++, p++) {
> >                 blocks = be32_to_cpu(p->num_blocks);
> >                 start  = be32_to_cpu(p->first_block);
> >                 if (blocks)
> > -                       put_partition(state, slot++, start, blocks);
> > +                       put_partition(state, i+1, start, blocks);
> >         }
> > --------------------
> 
> Hmm. The previous change was not because there is something
> intrinsically good with some way of numbering partitions,
> but because it is very inconvenient when partition numbering
> changes.
Yes, you are right. It's just tht looking at similar paritionning code,
like osf, sun, ultrix, I didn't see/know why sgi would be different.
but I've never approached an sgi in my life and thus don't know
anything about irix partitionnnig uses.

> But here the 2.6 behaviour is already that of 2.4.21, and you
> change away from that. Not a good idea.

Agreed, obviously.

ghoz

