Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269342AbUINMSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269342AbUINMSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269346AbUINMOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:14:38 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:48071 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269327AbUINMOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:14:09 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Date: Tue, 14 Sep 2004 14:07:50 +0200
User-Agent: KMail/1.6.2
Cc: Jens Axboe <axboe@suse.de>, "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net> <20040914060628.GC2336@suse.de> <1095156346.16572.2.camel@localhost.localdomain>
In-Reply-To: <1095156346.16572.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409141407.50483.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 12:05, Alan Cox wrote:
> On Maw, 2004-09-14 at 07:06, Jens Axboe wrote:
> > Alan, I bet there are a lot of these. Maybe we should consider letting
> > the user manually flag support for FLUSH_CACHE, at least it is in their
> > hands then.
> 
> You are assuming the drive supports "FLUSH_CACHE" just because it
> doesn't error it. Thats a good way to have accidents. 

Yep.

> The patch I posted originally did turn wcache off for barrier if no
> flush cache support was present but had a small bug so that bit got
> dropped.

'small bug' was that it didn't disable wcache except one
error case (which I've never seen in the wild). 8)

Check what ioctl hdparm uses for enabling wcache
and then think about implications for disabling wcache
by default.
