Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbUB2C6M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 21:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUB2C6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 21:58:12 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28292 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261968AbUB2C6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 21:58:11 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Worrisome IDE PIO transfers...
Date: Sun, 29 Feb 2004 04:05:19 +0100
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <4041232C.7030305@pobox.com> <200402290121.30498.bzolnier@elka.pw.edu.pl> <40413927.6010408@pobox.com>
In-Reply-To: <40413927.6010408@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290405.19067.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 of February 2004 01:58, Jeff Garzik wrote:

> > I like Alan's idea to use loopback instead of "bswap".
>
> Neat but no more zerocopy that way.  I much prefer a swap-as-you-go...

Okay, better solution:

- on Atari/Q40:
  if drive->bswap use insw/outsw instead of swapping variants
 
- on others:
  use device mapper as suggested by Matt Mackall
  (no extra copying and you can use DMA to read disk from TiVo!)

Bartlomiej

