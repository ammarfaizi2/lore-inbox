Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266259AbUGORbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUGORbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 13:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGORbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 13:31:51 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45040 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266259AbUGORbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 13:31:47 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA disk device naming ?
Date: Thu, 15 Jul 2004 19:37:43 +0200
User-Agent: KMail/1.5.3
Cc: "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0407130415430.15806-100000@hubble.stokkie.net> <40F35140.6020509@pobox.com> <200407141320.32608.arnd@arndb.de>
In-Reply-To: <200407141320.32608.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407151937.43862.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 of July 2004 13:20, Arnd Bergmann wrote:
> On Dienstag, 13. Juli 2004 05:04, Jeff Garzik wrote:
> > Whoever builds your kernels changed around the kernel configuration on
> > you.
> >
> > SATA "disk naming" (what driver you use) did not change from 2.6.3 to
> > 2.6.7.
>
> The thing that changed is the new BLK_DEV_IDE_SATA option that defaults
> to 'n', while before it was enabled implicitly.

This is a quite fresh change (post 2.6.7) and should be fixed before 2.6.8.
This option should default to 'y', we can put some runtime warning instead.

Jeff, do you agree?

> I was bitten by this as well. Unfortunately I have an md RAID-0 volume
> which I can not start after hde/hdg become sda/sdb, so I'll probably
> have to keep using the old IDE driver indefinitely.
>
> 	Arnd <><

