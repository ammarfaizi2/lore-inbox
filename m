Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131070AbQK3Ex5>; Wed, 29 Nov 2000 23:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131093AbQK3Ext>; Wed, 29 Nov 2000 23:53:49 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25872 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S130000AbQK3Evi>;
        Wed, 29 Nov 2000 23:51:38 -0500
Date: Wed, 29 Nov 2000 20:08:55 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Kurt Garloff <kurt@garloff.de>
cc: --Damacus Porteng-- <kernel@bastion.yi.org>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE-SCSI/HPT366 Problem
In-Reply-To: <20001129191402.F5891@garloff.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.30.0011292007080.22577-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Kurt Garloff wrote:

>Date: Wed, 29 Nov 2000 19:14:02 +0100
>From: Kurt Garloff <kurt@garloff.de>
>To: --Damacus Porteng-- <kernel@bastion.yi.org>
>Cc: Linux kernel list <linux-kernel@vger.kernel.org>
>Content-Type: multipart/signed; micalg=pgp-md5;
>        protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
>Subject: Re: IDE-SCSI/HPT366 Problem
>
>On Wed, Nov 29, 2000 at 01:06:16PM -0600, --Damacus Porteng-- wrote:
>> Problem:
>> 	The problem lies with using my EIDE CDRW - I set it up properly using
>> 	IDE-SCSI.  I can use my mp3tocdda shell script to encode mp3s to CD
>> 	(uses cdrecord as well) on the fly using either drive, however, when I
>> 	use cdrecord to write a data CD, the system hard-locks, no kernel
>> 	panic messages, and no Magic SysRQ keystroke works.
>>
>> 	Quite odd that I could do the cdrecord for audio tracks, but not
>> 	data..
>
>Strange. If you read data from the harddisk on an IDE channel and write it
>(with cdrecord) to some CDRW on the same IDE channel, you have to expect
>trouble: As with IDE there is no disconnect from the bus (as opposed to
>SCSI), you risk buffer underruns.
>A lockup however is not to be expected :-(

I reported this before as well.  Blanking a CDRW on an IDE writer
and trying to mount a cdrom on an IDE reader on the slave on the
same IDE channel produces a dual oops.  I got an initial response
from Alan, and I believe Jens Axboe, and never heard about it
again.  I dunno if it was fixed or not.  It still oops's though.


----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Be up to date on nerd news and stuff that matters:  http://slashdot.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
