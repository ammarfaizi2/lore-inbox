Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758270AbWK0PDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270AbWK0PDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 10:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758271AbWK0PDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 10:03:06 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:42132 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP
	id S1758270AbWK0PDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 10:03:04 -0500
Date: Mon, 27 Nov 2006 10:03:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Duncan Sands <duncan.sands@math.u-psud.fr>
cc: Ilyes Gouta <ilyes.gouta@gmail.com>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [USB] urb->number_of_packets = 256 !
In-Reply-To: <200611270932.30564.duncan.sands@math.u-psud.fr>
Message-ID: <Pine.LNX.4.44L0.0611271001330.13589-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, Duncan Sands wrote:

> Hi Ilyes, you won't be able to allocate that much *contiguous* memory,
> but you should be able to allocate enough non-contiguous memory (e.g.
> by calling __get_free_page 256 times; not the same as calling
> __get_free_pages(8) !).  To use that memory, you can try using the usb
> scatter/gather support (see usb.h); I don't know if it works with
> isochronous urbs though.  I've CC'd the usb development list - maybe
> someone there can help.

The scatter/gather library does not support iso.

> > Splitting the transfer across multiple URB doesn't seem to work (I didn't really
> > investigate in depth this possibility).

It should work.  Go back and try it again more carefully.

Alan Stern

