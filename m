Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263450AbUCTPve (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbUCTPve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:51:34 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20366 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263450AbUCTPvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:51:32 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 17:00:05 +0100
User-Agent: KMail/1.5.3
Cc: Johannes Stezenbach <js@convergence.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <200403200313.05681.bzolnier@elka.pw.edu.pl> <20040320113627.GB7714@merlin.emma.line.org>
In-Reply-To: <20040320113627.GB7714@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403201700.05808.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 12:36, Matthias Andree wrote:
> > Correct answer is: everything is fine, RTFM (man hdparm). ;-)
>
> Not everything is fine. hdparm documents -i returns inconsistent data.
> Most, but _NOT_ _EVERYTHING_ is cached: the multcount is updated, for
> instance. What is that good for? Mix & Match whatever is convenient?

I'm aware of this bug - driver shouldn't modify drive->id.  Patches are welcomed.

> Are there systems where -I will not work? If there are none, hdparm 6.0

It should always work.

> should be shipped without the -i option.

Why?  It can be sometimes useful for debugging purposes
and HDIO_GET_IDENTIFY ioctl is not going away in 2.6.x.

Regards,
Bartlomiej

