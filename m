Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVFIWLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVFIWLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVFIWLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:11:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14560
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262485AbVFIWLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:11:21 -0400
Date: Thu, 09 Jun 2005 15:11:08 -0700 (PDT)
Message-Id: <20050609.151108.92584111.davem@davemloft.net>
To: jketreno@linux.intel.com
Cc: pavel@ucw.cz, vda@ilport.com.ua, abonilla@linuxwireless.org,
       jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42A8AE2A.4080104@linux.intel.com>
References: <20050609104205.GD3169@elf.ucw.cz>
	<20050609.125324.88476545.davem@davemloft.net>
	<42A8AE2A.4080104@linux.intel.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Ketrenos <jketreno@linux.intel.com>
Date: Thu, 09 Jun 2005 16:01:30 -0500

> The ipw2100 originally postponed doing any initialization until open was
> called.  The problem at that time was that distributions were crafted to
> rely on link detection (I believe via ethtoolop's get_link) before they
> would bring the interface up.

Yes, I see, and that does work for most ethernet devices.
I noticed that Debian's 3.1 installer used this to determine
which ethernet device it should use as the default in it's
network device dialogue.

One idea, returning true for get_link when the device is down, may not
be a bad idea for the wireless case.
