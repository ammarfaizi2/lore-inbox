Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUCKPAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUCKPAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:00:42 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7360 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261403AbUCKO7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:59:52 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.4-rc-bk3: hdparm -X locks up IDE
Date: Thu, 11 Mar 2004 16:07:39 +0100
User-Agent: KMail/1.5.3
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua> <200403111552.26315.bzolnier@elka.pw.edu.pl> <20040311144812.GC6955@suse.de>
In-Reply-To: <20040311144812.GC6955@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403111607.39235.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 of March 2004 15:48, Jens Axboe wrote:
> On Thu, Mar 11 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 11 of March 2004 15:14, Denis Vlasenko wrote:
> > > I discovered that hdparm -X <mode> /dev/hda can lock up IDE
> > > interface if there is some activity.
> >
> > Known bug and is on TODO but fixing it ain't easy.
> > Thanks for a report anyway.
>
> Wouldn't it be possible to do the stuff that needs serializing from the
> end_request() part and get automatic synchronization with normal
> requests?

That's the way to do it (REQ_SPECIAL) but unfortunately on some chipsets
we need to synchronize both channels (whereas we don't need to serialize
normal operations).

Regards,
Bartlomiej

