Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTETOsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 10:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTETOsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 10:48:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9913
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263806AbTETOsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 10:48:30 -0400
Subject: Re: Promise SX6000 No handler for event (fwd)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kernel <kernel@mousebusiness.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030520141152.5916.qmail@srvr1.mousebusiness.com>
References: <20030520141152.5916.qmail@srvr1.mousebusiness.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053439391.30547.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 May 2003 15:03:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-20 at 15:11, kernel wrote:
> > It sent us two event messages for events we've never head of (or asked
> > for)
> If we never asked for these messages, why did it send them? 

Ask the vendor

> > 
> >> May 19 13:06:04 production kernel: i2o/iop0: Hardware Failure: Unknown Error
> > 
> > and then exploded  
> > 
> Yep. That's what's happening. Now, how do I defuse it? I *think* I'm setting 
> this up just as suggested on this list and various other sources, yet still 
> it is a no-go. 

Ask the vendor. I've traced one of these with an end user and we didnt
send a single invalid I2O message to it

> NFS-mounted volume from an old, slow, busy server to my RAID. This tells me 
> that probably the errors aren't caused by the SX6000 getting floodded by 
> incoming data stream and not being able to keep up with it. 

That would seem to be a bug in the controller firmware if so. You might
be able to reduce it or mitigate it by reducing the request queue size
we run.

Alan

