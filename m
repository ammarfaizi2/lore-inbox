Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVFIWdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVFIWdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVFIWdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:33:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12479
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262499AbVFIWc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:32:59 -0400
Date: Thu, 09 Jun 2005 15:32:54 -0700 (PDT)
Message-Id: <20050609.153254.74562706.davem@davemloft.net>
To: gregkh@suse.de
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, nsankar@broadcom.com
Subject: Re: [GIT PATCH] Another PCI fix for 2.6.12-rc6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050609222033.GA12580@kroah.com>
References: <20050609222033.GA12580@kroah.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@suse.de>
Date: Thu, 9 Jun 2005 15:20:33 -0700

> 	"Broadcom already submitted the bnx2 driver for the 5706 gigabit
> 	driver which enables MSI on all systems that support PCI-X. That
> 	patch has already gone into 2.6.12-rc6. So if the MSI disable
> 	patch does not get into 2.6.12, anyone who uses the 5706 on the
> 	Serverworks chipset platform, will have interrupt failures."

The bnx2 driver can get the MSI test added to it just like the tg3
driver does.  I don't see why the same code wasn't propagated.  Either
both drivers need that MSI test code, or both do not.

That doesn't make any sense, one testing for correct MSI functionality
while the other does not.

