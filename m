Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbTCLSEs>; Wed, 12 Mar 2003 13:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261811AbTCLSEs>; Wed, 12 Mar 2003 13:04:48 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:34030 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261805AbTCLSEr>; Wed, 12 Mar 2003 13:04:47 -0500
Date: Wed, 12 Mar 2003 13:15:31 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>,
       linux-ns83820@kvack.org
Subject: Re: problem w/ auto negotiate & ns83820 & netgear fsm726s switch
Message-ID: <20030312131531.F16642@redhat.com>
References: <Pine.LNX.4.53.0303120908470.21265@filesrv1.baby-dragons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0303120908470.21265@filesrv1.baby-dragons.com>; from babydr@baby-dragons.com on Wed, Mar 12, 2003 at 09:11:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 09:11:02AM -0500, Mr. James W. Laferriere wrote:
> 	The switch reports negotiating ...
> 	Port Name        Link On/Off State      Rate/Duplex Flow Ctrl
> 	26GB Not Defined Up   On     Forwarding (10   Full) (Disabled)
> 
> 	ns83820 reports ,  eth0: link now 1000F mbps, full duplex and up.
...
> 	I am quite aware that this could well be a difficulty in the
> 	switch still .  So I am looking for pointers on where to look ?
>  	I already tried the netgear suport site ;-} .  That is why I am
> 	running the lastest code for the switch (1.0.4) .

It's entirely possible the card has a different polarity for the phy bits 
as compared to the fibre card (Netgear) that the driver is already tested 
on.  Also, I've only managed to test on a cisco switch -- is there any 
other hardware you can test against (ie using the fibre cable for cross 
over) to narrow things down?  Enabling debug and dumping the status bits 
might hint as to what has to be changed.  Thankfully Trendnet seems to 
have programmed the subsystem id, so I'll be able to include the change 
automatically.

		-ben
