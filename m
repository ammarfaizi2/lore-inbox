Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTDDOsl (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbTDDOnF (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:43:05 -0500
Received: from [212.18.235.100] ([212.18.235.100]:39941 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S263720AbTDDOeF (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 09:34:05 -0500
Subject: Re: Strange e1000
From: Justin Cormack <justin@street-vision.com>
To: Paul Rolland <rol@as2917.net>
Cc: "'Michael Knigge'" <Michael.Knigge@set-software.de>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <043501c2faaf$da061e10$3f00a8c0@witbe>
References: <043501c2faaf$da061e10$3f00a8c0@witbe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 04 Apr 2003 15:45:25 +0100
Message-Id: <1049467531.2676.87.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-04 at 14:41, Paul Rolland wrote:
> Hello,
> 
> > when I load the e1000 module, my NIC is recognized. Then, "pump -i 
> > eth0" is called (DHCP-Client), the message "e1000: eth0 NIC 
> > Link is Up 
> > 1000 Mbps Full Duplex" appears and after some time I get the message 
> > "operation failed".
> > 
> > When I sleep some time (currently 20 seconds) before doing 
> > the "pump", 
> > everything works as expected.
> > 
> > What the hell is happening here? Ok, I got it working with the 
> > 20-sec-sleep but this is not the way it sould work...
> > 
> > My Board is a Gigabyte GA-7ZXR (1.0) and the Intel NIC is a PRO/1000 
> > MT (should be the 82540OEM Chip). The NIC is attached to a NetGear 
> > FSM726S Switch (24x100 + 2x1000). It is currenty the only box 
> > attached 
> 
> Could it be possible that the 1000MBps FD on the e1000 side is
> a local configuration, and that it needs some time to discuss with
> the Netgear switch to negotiate correctly speed and duplex before 
> working correctly ? (i.e. 20 sec = negotiation time)

It is probably something like this. For some reason the managed Netgear
switches take a very long time to do anything. Log into the switch and
watch the port status while this happens to confirm. I actually can't
netboot off these switches because if this. Hopefully Netgear will come
up with a fix.

Justin


