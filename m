Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbTAWTct>; Thu, 23 Jan 2003 14:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbTAWTct>; Thu, 23 Jan 2003 14:32:49 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:36091 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP
	id <S266627AbTAWTcs>; Thu, 23 Jan 2003 14:32:48 -0500
Message-ID: <3E304581.2010302@cox.net>
Date: Thu, 23 Jan 2003 12:41:53 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3b) Gecko/20030106
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: is it possible to bridge virtual devices (ie. a GRE tunnel)?
References: <3E3040B7.6040001@nortelnetworks.com>
In-Reply-To: <3E3040B7.6040001@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> I want to set up two physically separate LANs with the same network 
> address and logically bridge them using some kind of tunnel over an IP 
> network.
> 
> I was hoping to somehow combine bridging with GRE tunnels in the kernel 
> to accomplish this, but I haven't been able to find out for sure if the 
> current kernel bridging code can handle a tunnel device as one of the 
> bridge elements.
> 
> Can anyone give the definitive answer for this?
> 
> Thanks,
> 
> Chris
> 

I don't believe you'd be able to use GRE tunnels, as they are not an "Ethernet" 
type of tunnel.

However, I run a network with three physical locations, bridged over TAP-type 
tunnels using VTUN (vtun.sourceforge.net). These are Ethernet-type tunnel 
devices, so the bridge code just sees them as if it was any other Ethernet 
network interface.

In addition, I use ebtables to control what traffic gets bridged across the 
tunnels, so extraneous broadcast/multicast traffic stays where it is supposed to.

