Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbTDCUrB 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263530AbTDCUrB 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:47:01 -0500
Received: from [207.103.213.66] ([207.103.213.66]:64784 "EHLO
	sandman.sandgate.com") by vger.kernel.org with ESMTP
	id S263516AbTDCUq7 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:46:59 -0500
From: "Dennis Cook" <cook@sandgate.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
Subject: RE: Deactivating TCP checksumming
Date: Thu, 3 Apr 2003 15:57:53 -0500
Message-ID: <IJEHKLJHMGFNGKMEBBFNMEIICBAA.cook@sandgate.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <3E8C9DDD.3080205@pobox.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 3c59x.c, e1000, and other adapter drivers, ip_summed is
what is being checked for value CHECKSUM_HW when sending
a packet.

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com]
> Sent: Thursday, April 03, 2003 03:47 PM
> To: Dennis Cook
> Cc: linux-kernel@vger.kernel.org; kernelnewbies@nl.linux.org
> Subject: Re: Deactivating TCP checksumming
> 
> 
> Dennis Cook wrote:
> > Based on various feedback, on my RH Linux 2.4.18 kernel I tried the
> > following:
> > 
> > Set "features" bit NETIF_F_IP_CSUM set (the only feature bit set).
> > In my network driver start-transmit check for "CHECKSUM_HW" in 
> ip_summed.
> > Using a small test program, use "sendfile" to copy a file to a network
> > socket FD.
> > Result is none of the packets presented to my network adapter 
> driver have
> > ip_summed set to CHECKSUM_HW, so the SW IP stack has already
> > computed checksums.
> 
> CHECKSUM_HW is for receive, not transmit.  Read the comments at the top 
> of include/linux/skbuff.h.
> 
> 
> > Is this mechanism possibly broken on kernel 2.4?
> 
> 
> it works quite well.
> 
> 	Jeff
> 
> 
> 
> 

