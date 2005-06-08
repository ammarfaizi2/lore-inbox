Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVFHUd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVFHUd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFHUd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:33:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55500 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261603AbVFHUdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:33:03 -0400
Date: Wed, 8 Jun 2005 18:29:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jirka Bohac <jbohac@suse.cz>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Pavel Machek <pavel@ucw.cz>,
       Jeff Garzik <jgarzik@pobox.com>, Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100: firmware problem
Message-ID: <20050608162947.GB3969@openzaurus.ucw.cz>
References: <20050608142310.GA2339@elf.ucw.cz> <200506081744.20687.vda@ilport.com.ua> <20050608145653.GA8844@dwarf.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608145653.GA8844@dwarf.suse.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Do you want to associate to an AP when your kernel boots,
> > _before_ any iwconfig had a chance to configure anything?
> > That's strange.
> > 
> > My position is that wifi drivers must start up in an "OFF" mode.
> > Do not send anything. Do not join APs or start IBSS.
> 
> Agreed.

Me too ;-).

> > Thus, no need to load fw in early boot.
> 
> I don't think this is true. Loading the firmware on the first
> "ifconfig up" is problematic. Often, people want to rename the
> device from ethX/wlanX/... to something stable. This is usually
> based on the adapter's MAC address, which is not visible until
> the firmware is loaded.
> 
> Prism54 does it this way and it really sucks. You need to bring
> the adapter up to load the firmware, then bring it back down,
> rename it, and bring it up again.
> 
> Denis: any plans for this to be fixed?
> 
> I agree that drivers should initialize the adapter in the OFF
> state, but the firmware needs to be loaded earlier than the
> first ifconfig up.
> 
> How about loading the firmware when the first ioctl touches the
> device? This way, it would get loaded just before the MAC address
> is retrieved.

Thats really ugly :-(.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

