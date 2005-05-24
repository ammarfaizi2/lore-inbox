Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVEXDZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVEXDZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 23:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVEXDZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 23:25:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:63437 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261316AbVEXDZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 23:25:05 -0400
Subject: Re: ide-cd vs. DMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: karim@opersys.com
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <42929F2F.8000101@opersys.com>
References: <1116891772.30513.6.camel@gaston> <42929F2F.8000101@opersys.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 13:24:50 +1000
Message-Id: <1116905090.4992.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 23:27 -0400, Karim Yaghmour wrote:
> Benjamin Herrenschmidt wrote:
> > hdb: command error: status=0x51 { DriveReady SeekComplete Error }
> > hdb: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
> > ide: failed opcode was: unknown
> > end_request: I/O error, dev hdb, sector 42872
> 
> Got plenty of these an old Dell Optiplex GX1 (PIII-450) with
> vanilla FC3. ... you've got to wonder when the kernel says there
> are bad sectors on a CD (?) and then they disappear with:
> hdparm -d0 /dev/hdc

Well, not sure what's wrong here, but ATAPI errors shouldn't normally
result in stopping DMA. We may want to just blacklist your drive rather
than having this stupid fallback. In this case, I suspect it's
CSS/region issue with a DVD.

Ben.


