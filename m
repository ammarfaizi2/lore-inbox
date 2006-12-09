Return-Path: <linux-kernel-owner+w=401wt.eu-S1760839AbWLINSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760839AbWLINSI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761161AbWLINSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:18:08 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41983 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760839AbWLINSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:18:04 -0500
Date: Sat, 9 Dec 2006 13:25:42 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: CD/DVD drive errors and lost ticks
Message-ID: <20061209132542.6bcfc864@localhost.localdomain>
In-Reply-To: <457A28FF.4030508@scientia.net>
References: <120320061552.9126.4572F2AD0001D571000023A622058844849D0E050B9A9D0E99@comcast.net>
	<457A28FF.4030508@scientia.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've also hat some errors like this:
> hdb: irq timeout: status=0xd0 { Busy }
> ide: failed opcode was: unknown
> hdb: DMA disabled

The drive went away and stopped talking

> hdb: ATAPI reset complete
> hdb: irq timeout: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hdb: ATAPI reset complete
> hdb: irq timeout: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hdb: cdrom_read_intr: data underrun (4 blocks)
> end_request: I/O error, dev hdb, sector 7831400
> Buffer I/O error on device hdb, logical block 1957850

And eventually got back to sanity

> That happened on a DVD (successfully read in and played by the drive),..
> but when I pushed the eject button (while xine sill was playing) I got
> those errors,..
> I assume that xine continued to read data but the DVD was already
> ejected and thus the request errors....
> But I think there shouldn't be a request error but more something like
> "no medium found" or the eject button should have been disabled at
> all,... so I think something goes really wrong with that drive ;)

The requests were outstanding so the behaviour is expected. As to the
eject button - Xine chooses not to lock the drive. I don't know why it
prefers to work that way but it's an application choice on the whole.
