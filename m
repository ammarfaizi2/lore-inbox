Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbTDUKxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 06:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbTDUKxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 06:53:31 -0400
Received: from mail.ithnet.com ([217.64.64.8]:20497 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263789AbTDUKx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 06:53:29 -0400
Date: Mon, 21 Apr 2003 13:03:41 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: John Bradford <john@grabjohn.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, john@grabjohn.com,
       linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030421130341.06d60830.skraw@ithnet.com>
In-Reply-To: <200304210935.h3L9ZLXc000256@81-2-122-30.bradfords.org.uk>
References: <200304210900.h3L90vu07375@Port.imtp.ilyichevsk.odessa.ua>
	<200304210935.h3L9ZLXc000256@81-2-122-30.bradfords.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003 10:35:21 +0100 (BST)
John Bradford <john@grabjohn.com> wrote:

> > > > What is so bad about the simple way: the one who wants to write
> > > > (e.g. fs) and knows _where_ to write simply uses another newly
> > > > allocated block and dumps the old one on a blacklist. The blacklist
> > > > only for being able to count them (or get the sector-numbers) in
> > > > case you are interested. If you weren't you might as well mark them
> > > > allocated and that's it (which I would presume a _bad_ idea). If
> > > > there are no free blocks left, well, then the medium is full. And
> > > > that is just about the only cause for a write error then (if the
> > > > medium is writeable at all).
> > >
> > > Modern disks generally do this kind of thing themselves.  By the time
> >                ^^^^^^^^^^^^
> > How many times does Stephan need to say it? 'Generally do'
> > is not enough, because it means 'sometimes they dont'.
> 
> OK, _ALL_ modern disks do.

Stop this thread, we are arguing with god.

> Name an IDE or SCSI disk on sale today that doesn't retry on write
> failiure.  Forget I said 'Generally do'.

IBM DMVS18V (SCSI)
Maxtor ATA133 160 GB DiamondMax Plus.

Maybe they _should_, but I can tell you they in fact sometimes don't (IBM very,
very seldom, Maxtor just about all the time)

> > Most filesystems *are* designed with badblock lists and such,
> > it is possible to teach fs drivers to tolerate write errors
> > by adding affected blocks to the list and continuing (as opposed
> > to 'remounted ro, BOOM!'). As usual, this can only happen if someone
> > will step forward and code it.
> > 
> > Do you think it would be a Wrong Thing to do?
> 
> Yes, I do.
> 
> It achieves nothing useful, and gives people a false sense of security.

How do _you_ know that? What makes _you_ argue for what _I_ think is useful and
_my_ sense of security? You are on thin ice ...
 
> We have moved on since the 1980s, and I believe that it is now up to
> the drive firmware, or the block device driver to do this, it has no
> place in a filesystem.

Interestingly I owned one of those 30 MB MFM Seagate howling drives back in the
80s. I had no errors on it until I threw it away for its unbelievable noise
rate. Today I throw away one (very low-noise) disk about every week for
shooting yet another fs somewhere near midnight.
Indeed we moved on, only the direction looks sometimes questionable ...

Regards,
Stephan

