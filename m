Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSGXMlA>; Wed, 24 Jul 2002 08:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSGXMlA>; Wed, 24 Jul 2002 08:41:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39883 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317068AbSGXMlA>; Wed, 24 Jul 2002 08:41:00 -0400
Date: Wed, 24 Jul 2002 14:43:53 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <martin@dalecki.de>
cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: please DON'T run 2.5.27 with IDE!
In-Reply-To: <3D3E90E4.3080108@evision.ag>
Message-ID: <Pine.SOL.4.30.0207241440500.15605-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Marcin Dalecki wrote:

> [root@localhost block]# grep \>special *.c
> elevator.c:         !rq->waiting && !rq->special)
> ^^^^^^ This one is supposed to have the required barrier effect.

Go reread, no barrier effect, requests can slip in before your
REQ_SPECIAL. They cannon only be merged with REQ_SPECIAL.

Regards
--
Bartlomiej

