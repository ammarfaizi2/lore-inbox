Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRBSCCl>; Sun, 18 Feb 2001 21:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbRBSCCb>; Sun, 18 Feb 2001 21:02:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1039 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129771AbRBSCCM>; Sun, 18 Feb 2001 21:02:12 -0500
Subject: Re: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
To: axboe@suse.de (Jens Axboe)
Date: Mon, 19 Feb 2001 02:02:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, zzed@cyberdude.com
In-Reply-To: <20010219024704.C8227@suse.de> from "Jens Axboe" at Feb 19, 2001 02:47:04 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ufef-0002A4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > But it has to go somewhere, and 2.4 right now is unusable on two of my boxes
> > with M/O drives.
> 
> Reads can be pretty easily padded, but writes are a bit harder. Maybe
> push it to some helper before the device queue sees it? For 2.4 the
> best sd solution is probably to just make it able to handle these
> requests.

For M/O drives you can do it in the scsi layer. Doing it right in the block
layer is not easy. Doing it cleanly and right I cant currently visualise a
setu for. But I agree it belongs in the queueing layers

