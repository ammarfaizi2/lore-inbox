Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUHJImA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUHJImA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUHJImA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:42:00 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:31122 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262138AbUHJIl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:41:58 -0400
Date: Tue, 10 Aug 2004 10:41:59 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810084159.GD10361@merlin.emma.line.org>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de> <20040806151017.GG23263@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806151017.GG23263@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe schrieb am 2004-08-06:

> On Fri, Aug 06 2004, Joerg Schilling wrote:
> > Let me give you a short answer: If DMA creates so many problem on Linux,
> > how about imlementing a generic DMA abstraction layer like Solaris does?
> 
> We do have that. But suddenly changing the alignment and length
> restrictions on issuing dma to a device in the _end_ of a stable series
> does not exactly fill me with joyful expectations. It's simply that,
> not lack of infrastructure.

The problem has been reported again and again throughout the whole 2.4
cycle and has grown ever more painful as devices became faster.

It's not exactly fun if everything can do 48X but your favorite OS
(Linux 2.4) is limited to say 8X because it only does PIO in spite of
hdparm settings and everything else.

I didn't care much because I had a SCSI writer at that time which had
working DMA (and was also slow...) but as that turned out to become
unreliable, I bought one of the nice Plextors and now was faced with the
problem I couldn't use it at full speed. FreeBSD came to the rescue
while 2.6 started to become stable through its early releases.

It's Marcelo's call to decide if he wants the DMA addressing
requirements relaxed for 2.4.28 or if 2.4 is closed. If 2.4 is now
bugfixes-only then this certainly qualifies after some testing. If it
doesn't work out, it can still be disabled through the -rc versions, or
it can be some sysctl if you fear adverse effects.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
