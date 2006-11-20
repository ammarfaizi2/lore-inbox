Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934119AbWKTMYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934119AbWKTMYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 07:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934118AbWKTMYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 07:24:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:35297 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934114AbWKTMYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 07:24:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Chris Snook <csnook@redhat.com>
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
Date: Mon, 20 Nov 2006 13:21:59 +0100
User-Agent: KMail/1.9.5
Cc: Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20061119203050.GD29736@osprey.hogchain.net> <200611200057.45274.arnd@arndb.de> <45614769.4020005@redhat.com>
In-Reply-To: <45614769.4020005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611201322.00495.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 07:12, Chris Snook wrote:
> > 
> > Any reason why you can't use generic_mii_ioctl?
> 
> I decided to mostly leave this code alone, in the hope that we could 
> just rip out MII support entirely and nobody would mind.  What do you think?
> 

Normally, I think you should just implement mdio_read/mdio_write functions
and then use all the helpers from drivers/net/mii.c to implement mii_ioctl
and other functions like ethtool_gset.

	Arnd <><
