Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbUAPNPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUAPNPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:15:00 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265441AbUAPNO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:14:59 -0500
Date: Fri, 16 Jan 2004 14:14:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       David Brownell <david-b@pacbell.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
Message-ID: <20040116131446.GA874@elf.ucw.cz>
References: <200401120937.19131.oliver@neukum.org> <Pine.LNX.4.44L0.0401121119540.1327-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0401121119540.1327-100000@ida.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > In 2.4 they all run in interrupt or thread context IIRC.
> > Problematic is the SCSI error handling thread. It can call usb_reset_device()
> > which calls down and does allocations.
> > Does that thread also do the PF_MEMALLOC trick?
> 
> In 2.4 it doesn't, which is rather surpising considering how many storage 
> devices run over SCSI transports.
> 
> In 2.6 it sets PF_IOTHREAD.  I don't know if that subsumes the function of 
> PF_MEMALLOC or not.  The state of kerneldoc for much of the Linux core 
> functionality is shocking.

PF_IOTHREAD is there for suspend/resume. It does not affect anything
else.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
