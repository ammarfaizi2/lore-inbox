Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUBCBIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUBCBFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:05:33 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26254 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265647AbUBCBFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:05:03 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mark Haverkamp <markh@osdl.org>
Subject: Re: ide taskfile and cdrom hang
Date: Tue, 3 Feb 2004 02:09:21 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cliff White <cliffw@osdl.org>
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net> <200402030113.49852.bzolnier@elka.pw.edu.pl> <1075767384.13805.9.camel@markh1.pdx.osdl.net>
In-Reply-To: <1075767384.13805.9.camel@markh1.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402030209.21676.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 of February 2004 01:16, Mark Haverkamp wrote:
> On Mon, 2004-02-02 at 16:13, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 03 of February 2004 00:52, Mark Haverkamp wrote:
> > > On Mon, 2004-02-02 at 15:37, Bartlomiej Zolnierkiewicz wrote:
> > > > On Monday 02 of February 2004 22:44, Mark Haverkamp wrote:
> > > > > On Mon, 2004-02-02 at 13:35, Bartlomiej Zolnierkiewicz wrote:
> > > > > > On Monday 02 of February 2004 21:45, Mark Haverkamp wrote:
> > > > > > > On Mon, 2004-02-02 at 11:45, Bartlomiej Zolnierkiewicz wrote:
> > > > > > > > On Monday 02 of February 2004 19:46, Mark Haverkamp wrote:
> > > > > > > > > On Sun, 2004-02-01 at 12:48, Bartlomiej Zolnierkiewicz
> > > > > > > > > wrote:
> > >
> > > [ ... ]
> > >
> > > > Now, can you comment out "(UDELAY(10))" printk and add printk for
> > > > "retries" variable after while {} loop.  I thought there will be more
> > > > "(UDELAY(10))" messages - but I forgot about delay introduced by
> > > > printk() call :-).
> > > >
> > > > --bart
> > >
> > > I ran twice, got the same results:
> > >
> > > 1)
> > > hda: (WAIT_NOT_BUSY) status=0x50 retry 94
> > > hda: (CHECK_STATUS) status=0x50
> > > hda: (WAIT_NOT_BUSY) status=0x50 retry 94
> > > hda: (CHECK_STATUS) status=0x50
> >
> > Is this output for single 'cat /proc/ide/hda/identify' run?
> > There should be only one WAIT_NOT_BUSY and one CHECK_STATUS.
>
> I see two for each cat.  Also, the 94 is the leftover number. So there
> were probably about 6 retries.

Yep, I need some caffeine or sleep :-).
Okay, so 6 retries were needed and the limit was 5.

Thanks,
--bart

