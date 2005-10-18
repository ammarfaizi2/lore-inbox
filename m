Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbVJRUrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbVJRUrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbVJRUrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:47:20 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:6002 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751497AbVJRUrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:47:20 -0400
To: linux-kernel@vger.kernel.org
Subject: What is struct pci_driver.owner for?
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 18 Oct 2005 13:47:13 -0700
Message-ID: <52sluymu26.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Oct 2005 20:47:14.0263 (UTC) FILETIME=[1EA05670:01C5D425]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed that at some point, struct pci_driver grew a .owner
member.  However, only a handful of drivers set it:

    $ grep -r -A10 pci_driver drivers/ | grep owner
    drivers/block/sx8.c-    .owner          = THIS_MODULE,
    drivers/ieee1394/pcilynx.c-     .owner =           THIS_MODULE,
    drivers/net/spider_net.c-       .owner          = THIS_MODULE,
    drivers/video/imsttfb.c-        .owner          = THIS_MODULE,
    drivers/video/kyro/fbdev.c-     .owner          = THIS_MODULE,
    drivers/video/tridentfb.c-      .owner  = THIS_MODULE,

Should all drivers be setting .owner = THIS_MODULE?  Is this a good
kernel janitors task?

 - R.
