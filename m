Return-Path: <linux-kernel-owner+w=401wt.eu-S964941AbWLMNFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWLMNFw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWLMNFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:05:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2421 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964947AbWLMNFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:05:50 -0500
Date: Wed, 13 Dec 2006 14:05:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.19-mm1: gotemp: memset(..., 0) error
Message-ID: <20061213130559.GD3851@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
NOT FOR MAINLINE!

This is for the driver tutorial I give.  It will not be included in the
mainline kernel tree ever.  Use the ldusb driver that is already there
instead for this device.

This is only a teaching tool.
...
+       pkt = kmalloc(sizeof(*pkt), GFP_ATOMIC);
+       if (!pkt)
+               return -ENOMEM;
+       memset(pkt, sizeof(*pkt), 0x00);
...

<--  snip  -->


Lesson 1:
Write an USB driver.

Lesson 2:
Correct the memset() argument order or use kzalloc().


cu
Adrian  ;-)

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

