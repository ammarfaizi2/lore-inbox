Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUBBXwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUBBXwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:52:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:33217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262564AbUBBXwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:52:16 -0500
Subject: Re: ide taskfile and cdrom hang
From: Mark Haverkamp <markh@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cliff White <cliffw@osdl.org>
In-Reply-To: <200402030037.32701.bzolnier@elka.pw.edu.pl>
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net>
	 <200402022235.47439.bzolnier@elka.pw.edu.pl>
	 <1075758247.12117.1.camel@markh1.pdx.osdl.net>
	 <200402030037.32701.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1075765927.13805.3.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 15:52:08 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-02 at 15:37, Bartlomiej Zolnierkiewicz wrote:
> On Monday 02 of February 2004 22:44, Mark Haverkamp wrote:
> > On Mon, 2004-02-02 at 13:35, Bartlomiej Zolnierkiewicz wrote:
> > > On Monday 02 of February 2004 21:45, Mark Haverkamp wrote:
> > > > On Mon, 2004-02-02 at 11:45, Bartlomiej Zolnierkiewicz wrote:
> > > > > On Monday 02 of February 2004 19:46, Mark Haverkamp wrote:
> > > > > > On Sun, 2004-02-01 at 12:48, Bartlomiej Zolnierkiewicz wrote:
> > > >

[ ... ]

> Now, can you comment out "(UDELAY(10))" printk and add printk for "retries"
> variable after while {} loop.  I thought there will be more "(UDELAY(10))"
> messages - but I forgot about delay introduced by printk() call :-).
> 
> --bart

I ran twice, got the same results:

1)
hda: (WAIT_NOT_BUSY) status=0x50 retry 94
hda: (CHECK_STATUS) status=0x50
hda: (WAIT_NOT_BUSY) status=0x50 retry 94
hda: (CHECK_STATUS) status=0x50


2)
hda: (WAIT_NOT_BUSY) status=0x50 retry 94
hda: (CHECK_STATUS) status=0x50
hda: (WAIT_NOT_BUSY) status=0x50 retry 94
hda: (CHECK_STATUS) status=0x50


-- 
Mark Haverkamp <markh@osdl.org>

