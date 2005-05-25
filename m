Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVEYBcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVEYBcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 21:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVEYBb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 21:31:59 -0400
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:17599
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S262229AbVEYBb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 21:31:57 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd vs. DMA
Date: Tue, 24 May 2005 21:31:46 -0400
User-Agent: KMail/1.8
References: <1116891772.30513.6.camel@gaston> <42929F2F.8000101@opersys.com> <1116905090.4992.7.camel@gaston>
In-Reply-To: <1116905090.4992.7.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505242131.46827.kwall@kurtwerks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 May 2005 23:24, Benjamin Herrenschmidt enlightened us 
thusly:
> On Mon, 2005-05-23 at 23:27 -0400, Karim Yaghmour wrote:
> > Benjamin Herrenschmidt wrote:
> > > hdb: command error: status=0x51 { DriveReady SeekComplete Error }
> > > hdb: command error: error=0x54 { AbortedCommand
> > > LastFailedSense=0x05 } ide: failed opcode was: unknown
> > > end_request: I/O error, dev hdb, sector 42872
> >
> > Got plenty of these an old Dell Optiplex GX1 (PIII-450) with
> > vanilla FC3. ... you've got to wonder when the kernel says there
> > are bad sectors on a CD (?) and then they disappear with:
> > hdparm -d0 /dev/hdc
>
> Well, not sure what's wrong here, but ATAPI errors shouldn't normally
> result in stopping DMA. We may want to just blacklist your drive
> rather than having this stupid fallback. In this case, I suspect it's
> CSS/region issue with a DVD.

I see the same thing here on a plain vanilla CD-ROM (pardon the 
unsightly wrapping):

May 23 21:52:34 luther kernel: hdc: packet command error: status=0x51 
{ DriveReady SeekComplete Error }
May 23 21:52:34 luther kernel: hdc: packet command error: error=0x54 
{ AbortedCommand LastFailedSense=0x05 }
May 23 23:12:37 luther kernel: hdc: packet command error: status=0x51 
{ DriveReady SeekComplete Error }
May 23 23:12:37 luther kernel: hdc: packet command error: error=0x54 
{ AbortedCommand LastFailedSense=0x05 }


Kurt
