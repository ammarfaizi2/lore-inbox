Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTE2Bq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 21:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTE2Bq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 21:46:26 -0400
Received: from dp.samba.org ([66.70.73.150]:55728 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261825AbTE2BqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 21:46:25 -0400
Date: Thu, 29 May 2003 11:59:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matthew Harrell 
	<mharrell-dated-1054584482.d18b3b@bittwiddlers.com>
Cc: Gregory Maxwell <greg@xiph.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Orinoco_cs module won't unload in 2.5.70
Message-ID: <20030529015909.GA2058@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Matthew Harrell <mharrell-dated-1054584482.d18b3b@bittwiddlers.com>,
	Gregory Maxwell <greg@xiph.org>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <20030528154125.GA1289@motherfish-II.xiph.org> <20030528200755.GA1460@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528200755.GA1460@bittwiddlers.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 04:08:01PM -0400, Matthew Harrell wrote:
> 
> Nothing useful.  I've got this problem in a 2.5.65 kernel also.  Really is
> annoyying since the machine will not soft reboot because it thinks that
> device is still in use.  I have to physically power it off every time I 
> want to reboot it change any major pcmcia settings

Yes, it's a driver bug - one of a number that I've fixed recently.
I'll retransmit the patch to Linus today.

> > Kernel 2.5.70 (and 2.5.69-mm8 before it) on my Dell Latitude C840 is
> > unable to unload the orinoco_cs driver.
> > 
> > I get the following message over and over again while the rmmod hangs:
> > unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> > 
> > Even after ifconfig downing the interface..
> > 
> > This is quite annoying because the driver doesn't survive suspend and I
> > can't cleanly shutdown. :)
> > 
> > Suggestions?
> 

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
