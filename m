Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTKJLdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTKJLdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:33:04 -0500
Received: from [62.67.222.139] ([62.67.222.139]:48794 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S263181AbTKJLdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:33:00 -0500
Date: Mon, 10 Nov 2003 12:32:27 +0100
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031110113227.GA9153@synertronixx3>
Reply-To: konsti@ludenkalle.de
References: <20031110102444.GA8552@synertronixx3> <20031110105650.GA15743@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031110105650.GA15743@win.tue.nl>
X-PGP-Key: http://www.ludenkalle.de/konsti/pubkey.asc
User-Agent: Mutt/1.5.4i
X-Spam-Score: 3.3
X-Spam-Report: Spam detection software, running on the system "kermit", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	admin@mail.ku-gbr.de for details.
	Content preview:  On Mon, Nov 10, 2003 at 11:56:50AM +0100, Andries
	Brouwer wrote: > > > > With CONFIG_BLK_DEV_IDEDISK=y but unset
	CONFIG_BLK_DEV_HD_IDE and the > > inserted (and no used) printk stuff.
	> > At some later time we must come back and find out what is > wrong
	with hd.c. You call the printk stuff unused, but > it was used and
	printed [...] 
	Content analysis details:   (3.3 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 RCVD_IN_NJABL_DIALUP   RBL: NJABL: dialup sender did non-local SMTP
	[217.81.46.38 listed in dnsbl.njabl.org]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[Dynamic/Residential IP range listed by]
	[easynet.nl DynaBlock - <http://dynablock.easynet.nl/errors.html>]
	0.1 RCVD_IN_NJABL          RBL: Received via a relay in dnsbl.njabl.org
	[217.81.46.38 listed in dnsbl.njabl.org]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[217.81.46.38 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 11:56:50AM +0100, Andries Brouwer wrote:
> > 
> > With CONFIG_BLK_DEV_IDEDISK=y but unset CONFIG_BLK_DEV_HD_IDE and the
> > inserted (and no used) printk stuff.
> 
> At some later time we must come back and find out what is
> wrong with hd.c. You call the printk stuff unused, but
> it was used and printed

It was unused earlier, now, with CONFIG_BLK_DEV_IDEDISK=y but _unset_
CONFIG_BLK_DEV_HD_IDE it gets printed (to clear that).

> Clearly, you have EZDrive installed, the table below is what
> is found in sector 1, the data printed above is what is in
> sector 0. The tables differ - fdisk was used after installation
> of EZDrive.

Hm, interesting... I don't know what was on this disk in earlier days...
So it may be a help dd'ing Sektor 0 and 1 and create new table?

But of course after debugging that if you are interesting in that (which
seems to be the case here :)).

Here is what 2.6.0-test6-mm4 looks like when booting (wo printk mod):

http://ludenkalle.de/2.6.0-test6-mm4.txt

> I suppose that booting with boot parameter "hda=remap" should work.
> At some later time we must worry about how to get rid of EZDrive.

OK, lets see...

Konsti

-- 
2.6.0-test8-love3
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 2:00, 18 users
