Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUC1P2M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 10:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbUC1P2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 10:28:12 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14749 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261611AbUC1P2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 10:28:08 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefan Smietanowski <stesmi@stesmi.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 17:37:13 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <40660A3D.3020300@pobox.com> <40667D8D.2030802@stesmi.com>
In-Reply-To: <40667D8D.2030802@stesmi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403281737.13972.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 of March 2004 09:23, Stefan Smietanowski wrote:
> Hi Jeff.
>
> >> What will happen when a PATA disk lies behind a Marvel(ous) bridge, as
> >> in most SATA disks today?
> >
> > Larger transfers work fine in PATA, too.
>
> Correct me if I'm wrong but wasn't the max number of sectors in a
> transfer limited to 255 instead of 256 because there were buggy
> drives out there before ? I seem to recall something like that but
> I could be wrong.

There was 255 sectors limit in IDE driver but it was based only on _one_
bugreport on _unreliable_ drive (256 sectors causes heavier I/O load).

AFAIR "the other OS" is using 256 sectors so this value is safe.

Regards,
Bartlomiej

