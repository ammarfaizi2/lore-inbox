Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbUKKV4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbUKKV4m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbUKKVxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:53:51 -0500
Received: from palrel11.hp.com ([156.153.255.246]:57491 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262379AbUKKVt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:49:58 -0500
Date: Thu, 11 Nov 2004 13:49:57 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Anthony Samsung <anthony.samsung@gmail.com>
Subject: Re: network interface to driver and pci slot mapping
Message-ID: <20041111214956.GA10283@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Samsung wrote :
> 
> Given an interface name (like eth0), how do I determine:
> The name of the driver (module) for this interface.
> The PCI address for this interface, if relevant.
> 
> ?

	ethtool -i. Unfortunately, not yet implemented in all driver,
but Jeff is on the case.
	There might also be a sysfs way to do it, but it probably
involve lot's a grep or similar magic.

> I need something that works non-destructively on a live system, that
> isn't broken by nameif, and has a strong chance of producing a correct
> result. In particular, parsing syslog is out. There's no consistency
> in the format of messages and there's no guarantee the logs from
> bootup will still be around. And the interface may have been renamed
> since then.

	ifrename allow you to rename interfaces based on both driver
name and PCI address, so another option is to make sure interface
names are consistent and meaningful.

	Have fun...

	Jean
