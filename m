Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTKLXsC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 18:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTKLXsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 18:48:02 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32413 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261735AbTKLXr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 18:47:58 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: davidsen@tmr.com (bill davidsen)
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: Thu, 13 Nov 2003 00:47:31 +0100
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.44.0311102136280.2881-100000@home.osdl.org> <20031111184919.43a93a88.diegocg@teleline.es> <boudu6$k3j$1@gatekeeper.tmr.com>
In-Reply-To: <boudu6$k3j$1@gatekeeper.tmr.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311130047.31161.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 of November 2003 23:58, bill davidsen wrote:
> In article <20031111184919.43a93a88.diegocg@teleline.es>,
>
> Diego Calleja =?ISO-8859-15?Q?Garc=EDa?=  <diegocg@teleline.es> wrote:
> | El Mon, 10 Nov 2003 21:40:58 -0800 (PST) Linus Torvalds
> | <torvalds@osdl.org>
> |
> | escribió:
> | > Now it's your turn. Instead of wasting my time complaining, how about
> | > you put up or shut up? Show me the code. THEN post it. Until you do,
> | > there's no point to your mails.
> |
> | Until then, I'd suggest this patch to avoid more complains about this:
>
> The object is not to avoid complaints, the object is to get the
> capability working again. I presume eventually one of the commercial
> vendors will fix it, since it's easier than rewriting all the SCSI

Since it is easier for commercial vendors to fix it.
They have necessary hardware and financial motivation
(you've already pointed that out in one of your previous mails).

> applications in the world. oddly there are people writing useful things
> using other operating systems, under 2.4 almost all of those work.

Therefore stop complaining and _do_ something.

> I hope to pick up another IDE tape drive so I can look at this problem,
> the one I have is on a production system, which at the moment has no
> reason to go to 2.6 even if it worked, which it doesn't. It also has
> software to read ZIP drives in odd ways, and I'm not about to look for a
> SCSI 100MB ZIP drive :-(

So you are about to look for a way to fix it... :P.
Please send patches to me and lkml.

--bartlomiej
IDE Maintainer

> | diff -puN drivers/ide/Kconfig~idescsi-broken drivers/ide/Kconfig
> | --- tim/drivers/ide/Kconfig~idescsi-broken	2003-11-11 18:35:23.000000000
> | +0100 +++ tim-diego/drivers/ide/Kconfig	2003-11-11 18:36:07.000000000
> | +0100 @@ -247,7 +247,7 @@ config BLK_DEV_IDEFLOPPY
> |
> |  config BLK_DEV_IDESCSI
> |  	tristate "SCSI emulation support"
> | -	depends on SCSI
> | +	depends on SCSI && BROKEN
> |  	---help---
> |  	  This will provide SCSI host adapter emulation for IDE ATAPI
> | devices, 	  and will allow you to use a SCSI device driver instead of
> | a native

