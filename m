Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289787AbSBLOWE>; Tue, 12 Feb 2002 09:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291075AbSBLOV5>; Tue, 12 Feb 2002 09:21:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59403 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289787AbSBLOVq>; Tue, 12 Feb 2002 09:21:46 -0500
Subject: Re: Linux 2.4.18-pre9-ac1
To: axboe@suse.de (Jens Axboe)
Date: Tue, 12 Feb 2002 14:35:18 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andersen@codepoet.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020212092658.Z729@suse.de> from "Jens Axboe" at Feb 12, 2002 09:26:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ae1e-0001ws-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I want to find out why it was done first and then test it. Leaving it out
> > > will ensure it bugs me until I test it
> > 
> > If you leave it out, you surely want to make sure that the other request
> > init and re-init paths agree on the clustering for MO devices. Because
> > they don't.

No - I want to run a test set with an M/O drive before and after the change
and see what it shows in real life. I suspect nothing much.

> Now, disabling request merging for MO devices might make a whole lot
> more sense. That might be worth while trying, and I'd be happy to give
> you a patch to try that out instead.

I don't think that should be required actually. The killer on M/O disks
is seek time, and to an extent rotational latency (its 3 trips round a 
cheaper M/O disk to rewrite a sector). If anything clustering writes to
the same track should be a big win.

Alan
