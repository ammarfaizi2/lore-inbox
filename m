Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbTCNANN>; Thu, 13 Mar 2003 19:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbTCNANN>; Thu, 13 Mar 2003 19:13:13 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:647 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262582AbTCNANM>; Thu, 13 Mar 2003 19:13:12 -0500
Date: Thu, 13 Mar 2003 18:23:48 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.5.64-mm6
In-Reply-To: <20030313214908.27753.qmail@linuxmail.org>
Message-ID: <Pine.LNX.4.44.0303131818360.4241-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm... I have experienced some hard locks similar to what 
> you describe: if I compile usb-uhci as a module, Phoebe3 
> (8.0.94) locks hard at the time of doing a "modprobe 
> usb-controller" (being usb-controller an alias for uhci-hcd) 
> during boot (rc.sysinit script). To fix this, I have had  to compile 
> usb-uhci in to the kernel and then fix rc.sysinit. I haven't tried 
> using usb-uhci as a module since then. 
>  
> What's curious is that doing a "modprobe usb-controller" by 
> hand doesn't cause hard locks. So, there must be some kind 
> of timing or interaction that's causing rc.sysinit to invoke 
> "modprobe uchi-hcd" and freeze the machine. Any ideas? 

Not sure.  The configuration I used to build 2.5.64-mm6 was the same as 
every other 2.5 build I've used recently.  All of those included modular 
usb, so I don't believe it is that.  In my case 2.5.64-mm6 is the only 
version on which I see this.  My initial SWAG was some interaction between 
the new pcmcia core and usb, possibly at the pci layer.  I only ever try 
very few mm kernel versions, so I don't have a whole lot of data at the 
moment.

