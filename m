Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUF0OXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUF0OXR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 10:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUF0OXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 10:23:17 -0400
Received: from mail1.kontent.de ([81.88.34.36]:22695 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262772AbUF0OXQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 10:23:16 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: drivers/block/ub.c
Date: Sun, 27 Jun 2004 16:24:18 +0200
User-Agent: KMail/1.6.2
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270704.36063.oliver@neukum.org> <20040627140847.GG5526@pclin040.win.tue.nl>
In-Reply-To: <20040627140847.GG5526@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406271624.18984.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 27. Juni 2004 16:08 schrieb Andries Brouwer:
> On Sun, Jun 27, 2004 at 07:04:36AM +0200, Oliver Neukum wrote:
> > > >> Yes, we have macros. Using those macros would not at all be an improvement here.
> > > > 
> > > > How do you arrive at that unusual conclusion?
> > > 
> > > The above writes clearly and simply what one wants.
> > > I expect that you propose writing
> > > 
> > >         *((u32 *)(cmd->cdb + 2)) = cpu_to_be32(block);
> > > 
> > > or some similar unspeakable ugliness.
> > > If you had something else in mind, please reveal what.
> > 
> > That "ugliness" has the unspeakable advantage of producing sane code
> > on big endian architectures.
> 
> I am not so sure. It tells the compiler to do a 4-byte access
> on an address that possibly is not 4-byte aligned.

We also have the unaligned family of macro. Probably the cleanest
solution would be a union to do away with the ugly casts that would
be needed.

	Regards
		Oliver
