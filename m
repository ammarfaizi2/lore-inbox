Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUCQOs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 09:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUCQOsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 09:48:55 -0500
Received: from ddc.ilcddc.com ([12.35.229.4]:10771 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S261519AbUCQOsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 09:48:53 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B17007@DDCNYNTD>
From: RANDAZZO@ddc-web.com
To: matti.aarnio@zmailer.org
Cc: linux-kernel@vger.kernel.org
Subject: RE: Arp Implementation Example....
Date: Wed, 17 Mar 2004 09:35:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But how should the skb look when I pass it up?

I think it matters on the type of the netdevice.....

-Mike


-----Original Message-----
From: Matti Aarnio [mailto:matti.aarnio@zmailer.org]
Sent: Wednesday, March 17, 2004 9:32 AM
To: RANDAZZO@ddc-web.com
Cc: linux-kernel@vger.kernel.org; linux-newbie@vger.kernel.org
Subject: Re: Arp Implementation Example....


On Wed, Mar 17, 2004 at 08:39:37AM -0500, RANDAZZO@ddc-web.com wrote:
> All;
> 
> I am developed a network driver for my fibre channel device.
> I've used the O'Reilly Linux Device Driver's "snull.c and snull.h"
> as an example.
> 
> Problem is this example does not implement ARP.  After many attempts, I
> can't seem to pass an ARP packet successfully up
> the stack......

  ARP-request is just one more of network packets that are passed
  up into network code like any other by calling  netif_rx().
  As long as the packet is recognizable by the upper layers as
  an SKBUF with ARP request, all will be fine.

  Oh yes,  not all network interfaces need to support ARP at all.
  The PPP is one such example.  Nor do all ARP request frames carry
  same tags as ethernet ARP does.   Nevertheless one can pass ARP-
  requests thru a PPP link. See  drivers/net/ppp*  files about
  how that is handled.

> Does anyone know of an example driver / website that shows the formatting
> and responsibility of the network driver, with regards
> to ARP?
> 
> Any help is much appreciated...
> 
> BTW, I'm using Linux 2.4....

/Matti Aarnio
 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

