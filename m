Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTK3Qcu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTK3Qcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:32:50 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39876 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264940AbTK3Qct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:32:49 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Silicon Image 3112A SATA trouble
Date: Sun, 30 Nov 2003 17:34:14 +0100
User-Agent: KMail/1.5.4
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       linux-kernel@vger.kernel.org, marcush@onlinehome.de
References: <3FC36057.40108@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl> <3FCA1A8F.3000103@pobox.com>
In-Reply-To: <3FCA1A8F.3000103@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311301734.14740.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, siimage.c contains Maxtor fix as well, there is even comment from
Alan about Marvell PATA<->SATA bridges...

--bart

On Sunday 30 of November 2003 17:27, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Apply this patch and you should get similar performance from IDE driver.
> > You are probably seeing big improvements with libata driver because you
> > are using Samsung and IBM/Hitachi drives only, for Seagate it probably
> > sucks just like IDE driver...
>
> Looks good to me.
>
> > IDE driver limits requests to 15kB for all SATA drives...
> > libata driver limits requests to 15kB only for Seagata SATA drives...
> >
> > Both drivers still need proper fix for Seagate drives...
>
> Yep.  Do you have the Maxtor fix, as well?  It's in libata's SII driver,
> though it should be noted that the Maxtor errata only occurs for
> PATA<->SATA bridges, and not for real Maxtor SATA drives.
>
> 	Jeff

