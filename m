Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbUALQ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbUALQ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:27:23 -0500
Received: from ida.rowland.org ([192.131.102.52]:23812 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265586AbUALQ1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:27:20 -0500
Date: Mon, 12 Jan 2004 11:27:20 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       David Brownell <david-b@pacbell.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
In-Reply-To: <200401120937.19131.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0401121119540.1327-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Oliver Neukum wrote:

> In 2.4 they all run in interrupt or thread context IIRC.
> Problematic is the SCSI error handling thread. It can call usb_reset_device()
> which calls down and does allocations.
> Does that thread also do the PF_MEMALLOC trick?

In 2.4 it doesn't, which is rather surpising considering how many storage 
devices run over SCSI transports.

In 2.6 it sets PF_IOTHREAD.  I don't know if that subsumes the function of 
PF_MEMALLOC or not.  The state of kerneldoc for much of the Linux core 
functionality is shocking.

Alan Stern

