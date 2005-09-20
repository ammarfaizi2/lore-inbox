Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVITBOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVITBOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 21:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVITBOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 21:14:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56297
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964815AbVITBOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 21:14:41 -0400
Date: Mon, 19 Sep 2005 18:14:51 -0700 (PDT)
Message-Id: <20050919.181451.128902094.davem@davemloft.net>
To: habeck@sgi.com
Cc: steiner@sgi.com, linux-kernel@vger.kernel.org, tony.luck@gmail.com,
       linville@tuxdriver.com
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <432F3F11.69973A36@sgi.com>
References: <20050919204523.GD15838@sgi.com>
	<432F3F11.69973A36@sgi.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Habeck <habeck@sgi.com>
Date: Mon, 19 Sep 2005 17:43:29 -0500

> So is hacking the SN specific code to initialize the device's 
> state to PCI_DO more attractive than keeping John Linville current 
> patch?  As I said, I personally see nothing wrong with John 
> Linville current patch to check the actual state of the device.

I think keeping John's patch in is fine, especially if you guys
do have the longer term strategy of making pci_resource_to_bus()
work properly on this platform.  Because somewhere down the line
something else will depend upon it being correct, and you'll
need to address this properly.

Actually, some PCI quirk fixups use pcibios_bus_to_resource(), but the
one's that do this are probably not relevant on ia64.

