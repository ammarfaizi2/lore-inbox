Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVAEXHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVAEXHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVAEXHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:07:33 -0500
Received: from mail.dif.dk ([193.138.115.101]:38083 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262640AbVAEXH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:07:26 -0500
Date: Thu, 6 Jan 2005 00:18:49 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ZP Gu <zpg@castle.net>
Subject: Re: [PATCH][RFC] clean out old cruft from FD MCS driver
In-Reply-To: <20050104030717.GQ18080@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0501060015100.3492@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0501032350040.3529@dragon.hygekrogen.localhost>
 <20050104030717.GQ18080@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Matthew Wilcox wrote:

> On Tue, Jan 04, 2005 at 12:11:27AM +0100, Jesper Juhl wrote:
> > At this point I got the feeling that this driver had been left to rot and 
> > I desided to see if there was more cruft in there that we might as well 
> > get rid of, and indeed there is.
> 
> Yup.  There's a lot of cruft in that driver.  I really don't like the
> look of fd_mcs_intr() -- trying to deduce whether or not there's a data phase
> out based on the command byte?  urgh.
> 
> There's a somehat better-maintained driver -- fdomain.c.  It'd be great
> if someone could make fdomain.c support the MCA cards -- and even the PCMCIA
> cards without having the separate fdomain_stub.c.

That would be even better, but until that happens why not apply the patch 
I submitted (assuming it is actually OK) in its current form? That at 
least would clean out some of the cruft (and kill a warning) so there's 
less to sift through for someone reading the driver later.

-- 
Jesper


