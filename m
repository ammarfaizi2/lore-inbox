Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUAKIDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUAKIDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:03:08 -0500
Received: from mail1.kontent.de ([81.88.34.36]:20685 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265791AbUAKICv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:02:51 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Subject: Re: [linux-usb-devel] Re: USB hangs
Date: Sun, 11 Jan 2004 09:02:07 +0100
User-Agent: KMail/1.5.1
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <20040111002304.GE16484@one-eyed-alien.net> <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401110902.07054.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 11. Januar 2004 03:33 schrieb Alan Cox:
> On Sul, 2004-01-11 at 00:23, Matthew Dharm wrote:
> > Where is USB kmalloc'ing with GFP_KERNEL?  I thought we tracked all those
> > down and eliminated them.
> 
> Not sure. I just worked from tracebacks. I needed it to work rather
> than having the time to go hunting for specific faults. Plus I'd
> argue PF_MEMALLOC is a better solution anyway.

Until recently this line from usb-ohci.h read GFP_KERNEL instead of GFP_NOIO

#define ALLOC_FLAGS (in_interrupt () || current->state != TASK_RUNNING ? GFP_ATOMIC : GFP_NOIO)

Was it an earlier kernel without that change?

	Regards
		Oliver

