Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266024AbUAKXdd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUAKXdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:33:33 -0500
Received: from mail1.kontent.de ([81.88.34.36]:8679 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266024AbUAKXdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:33:31 -0500
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] Re: USB hangs
Date: Mon, 12 Jan 2004 00:33:40 +0100
User-Agent: KMail/1.5.1
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk> <4001DB52.7030908@pacbell.net>
In-Reply-To: <4001DB52.7030908@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401120033.40230.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 12. Januar 2004 00:25 schrieb David Brownell:
> Alan Cox wrote:
> > On Sul, 2004-01-11 at 00:23, Matthew Dharm wrote:
> > 
> >>Where is USB kmalloc'ing with GFP_KERNEL?  I thought we tracked all those
> >>down and eliminated them.
> > 
> > 
> > Not sure. I just worked from tracebacks. I needed it to work rather
> > than having the time to go hunting for specific faults. Plus I'd
> > argue PF_MEMALLOC is a better solution anyway.
> 
> It certainly seems like a more comprehensive fix for that
> particular class of problems!  :)

For users of a kernel thread it helps. But what affects storage
also make affect anything else that has a filesystem running
over it. Plus it forces us to keep the storage thread model, which
might be a solution that needs to be revisited.

	Regards
		Oliver

