Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUHUOqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUHUOqP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 10:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUHUOqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 10:46:14 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11699 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266463AbUHUOqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 10:46:13 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: serialize access to ide device
Date: Sat, 21 Aug 2004 16:43:55 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040802131150.GR10496@suse.de> <200408191514.13022.bzolnier@elka.pw.edu.pl> <20040821103208.GF6755@suse.de>
In-Reply-To: <20040821103208.GF6755@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408211643.55531.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 August 2004 12:32, Jens Axboe wrote:
> > What about adding new kind of REQ_SPECIAL request and converting
> > set_using_dma(), set_xfer_rate(), ..., to be callback functions for this
> > request?
> >
> > This should be a lot cleaner and will cover 100% cases.
>
> That will still only serialize per-channel. But yes, a lot cleaner.

per hwgroup not per channel
(serializing per host device will be better but requires even more work)
