Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUBBUqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUBBUql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:46:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:57516 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266061AbUBBUp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:45:28 -0500
Subject: Re: ide taskfile and cdrom hang
From: Mark Haverkamp <markh@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cliff White <cliffw@osdl.org>
In-Reply-To: <200402022045.02346.bzolnier@elka.pw.edu.pl>
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net>
	 <200402012148.20590.bzolnier@elka.pw.edu.pl>
	 <1075747608.8503.198.camel@markh1.pdx.osdl.net>
	 <200402022045.02346.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1075754718.8503.201.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 12:45:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-02 at 11:45, Bartlomiej Zolnierkiewicz wrote:
> On Monday 02 of February 2004 19:46, Mark Haverkamp wrote:
> > On Sun, 2004-02-01 at 12:48, Bartlomiej Zolnierkiewicz wrote:

[ .... ]
> >
> > Thanks,
> >
> > hdparm -I /dev/hda didn't hang.  I got this on the console:
> >
> > hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > hda: drive_cmd: error=0x04Aborted Command
> 
> That's okay.
> hdparm first tries WIN_IDENTIFY which can fail on ATAPI devices.
> 
> > I added the patch that you provided and I still get the hang when I cat
> > /proc/ide/hda/identify.  I put a printk In the code to make sure that it
> > was going through the added code, and it is.
> 
> So it is something different.  Can you give this patch a go?
> We will know more about what's going on.
> 
> Thanks,
> --bart


OK, Here it is:

hda: (WAIT_NOT_BUSY) status=0xd0
hda: (CHECK_STATUS) status=0xd0
hda: (BUSY) status=0xd0
hda: lost interrupt
hda: (BUSY) status=0x50
hda: lost interrupt
hda: (BUSY) status=0x50
hda: lost interrupt
hda: (BUSY) status=0x50
hda: lost interrupt
hda: (BUSY) status=0x50

-- 
Mark Haverkamp <markh@osdl.org>

