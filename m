Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272327AbTHNMsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272336AbTHNMsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:48:11 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5045 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272327AbTHNMsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:48:10 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: limit drive capacity to 137GB if host doesn't support LBA48
Date: Thu, 14 Aug 2003 14:48:27 +0200
User-Agent: KMail/1.5
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200308140324.45524.bzolnier@elka.pw.edu.pl> <1060851207.5535.15.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1060851207.5535.15.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308141448.27905.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 of August 2003 10:53, Alan Cox wrote:
> On Iau, 2003-08-14 at 02:24, Bartlomiej Zolnierkiewicz wrote:
> >  	hwif->rqsize			= old_hwif.rqsize;
> > -	hwif->addressing		= old_hwif.addressing;
> > +	hwif->no_lba48			= old_hwif.no_lba48;
>
> This change is a bad idea. Its called "addressing" because that is what
> it is about (see SATA and ATA specs). In future SATA addressing becomes
> a 0,1,2 value because 48bits isnt enough, it may get more forms beyond
> that.

Its hwif->addressing not drive->addressing.  Look at the current usage.
It is 1 when host doesn't support LBA48, otherwise its 0.  We can add "real"
hwif->addressing when needed.  IDE driver is already full of unfinished,
unused "features".

--bartlomiej

