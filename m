Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUALVCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbUALVB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:01:56 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:20632 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266246AbUALVAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:00:43 -0500
Subject: Re: [linux-usb-devel] Re: USB hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       David Brownell <david-b@pacbell.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.44L0.0401121119540.1327-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0401121119540.1327-100000@ida.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073940990.28424.9.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jan 2004 20:56:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-01-12 at 16:27, Alan Stern wrote:
> On Mon, 12 Jan 2004, Oliver Neukum wrote:
> 
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

Core scsi assumes that scsi drivers will use scsi_malloc/free so really
ignores the issue as someone elses problem.


