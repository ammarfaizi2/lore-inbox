Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934142AbWKTURW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934142AbWKTURW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934201AbWKTURV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:17:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:63422 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S934142AbWKTURU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:17:20 -0500
Date: Mon, 20 Nov 2006 12:15:24 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Snook <csnook@redhat.com>,
       Jay Cliburn <jacliburn@bellsouth.net>, romieu@fr.zoreil.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
Message-ID: <20061120121524.68cf39d8@freekitty>
In-Reply-To: <4562036E.3020409@garzik.org>
References: <20061119203050.GD29736@osprey.hogchain.net>
	<200611200057.45274.arnd@arndb.de>
	<45614769.4020005@redhat.com>
	<200611201322.00495.arnd@arndb.de>
	<20061120100202.6a79e382@freekitty>
	<4562036E.3020409@garzik.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 14:35:10 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Stephen Hemminger wrote:
> > Using common MII code is good, but one problem with the existing MII code is that
> > it doesn't work when device is down. This makes it impossible to set speed/duplex
> > before device comes up.
> 
> 
> That's not true at all.  drivers/net/mii.c uses caller-provided locking 
> in all cases, and there is nothing that prevents the common code from 
> being called when the interface is down.
> 
> You are probably thinking about all the netif_running() checks found in 
> the drivers, particularly in the ->begin() hook.
> 
> 	Jeff
> 
> 

Yeah it is a driver specific thing. All users of mii seem to block changes so
I thought it was in base code.


-- 
Stephen Hemminger <shemminger@osdl.org>
