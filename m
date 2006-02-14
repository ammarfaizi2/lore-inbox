Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWBNQ5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWBNQ5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWBNQ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:57:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:62871 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422665AbWBNQ5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:57:37 -0500
Date: Tue, 14 Feb 2006 10:48:47 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Compact Flash True IDE Mode Driver
In-Reply-To: <1139936291.10394.47.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0602141047130.28596-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Alan Cox wrote:

> On Llu, 2006-02-13 at 11:35 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > +static void cfide_outsl(unsigned long port, void *addr, u32 count)
> > > +{
> > > +       panic("outsl unsupported");
> > > +}
> > 
> > This will panic as soon as somebody tries to enable 32-bit I/O
> > using hdparm.  Please add ide_hwif_t.no_io_32bit flag and teach
> > ide-disk.c:ide_disk_setup() about it (separate patch).
> 
> Seems a lot of effort for little reward. Just make cfide_outsl generate
> word sized I/O instead. Ditto insl. Or even leave the panic. Only
> superusers can hack around with that value and they can equally crash
> the box a thousand other ways.

Well, there's a patch now and its pretty simple.  Now we have one less way 
superuser can kill things ;)

- k

