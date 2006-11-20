Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966310AbWKTSGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966310AbWKTSGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966313AbWKTSGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:06:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966310AbWKTSGJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:06:09 -0500
Date: Mon, 20 Nov 2006 10:02:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Snook <csnook@redhat.com>, Jay Cliburn <jacliburn@bellsouth.net>,
       jeff@garzik.org, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
Message-ID: <20061120100202.6a79e382@freekitty>
In-Reply-To: <200611201322.00495.arnd@arndb.de>
References: <20061119203050.GD29736@osprey.hogchain.net>
	<200611200057.45274.arnd@arndb.de>
	<45614769.4020005@redhat.com>
	<200611201322.00495.arnd@arndb.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 13:21:59 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 20 November 2006 07:12, Chris Snook wrote:
> > > 
> > > Any reason why you can't use generic_mii_ioctl?
> > 
> > I decided to mostly leave this code alone, in the hope that we could 
> > just rip out MII support entirely and nobody would mind.  What do you think?
> > 
> 
> Normally, I think you should just implement mdio_read/mdio_write functions
> and then use all the helpers from drivers/net/mii.c to implement mii_ioctl
> and other functions like ethtool_gset.
> 
> 	Arnd <><
> 

Using common MII code is good, but one problem with the existing MII code is that
it doesn't work when device is down. This makes it impossible to set speed/duplex
before device comes up.

-- 
Stephen Hemminger <shemminger@osdl.org>
