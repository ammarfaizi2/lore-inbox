Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVBYAEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVBYAEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVBYABb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:01:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38666 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262564AbVBYAAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:00:47 -0500
Date: Fri, 25 Feb 2005 01:00:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/ne3210.c: cleanups
Message-ID: <20050225000037.GG8651@stusta.de>
References: <20050218234659.GC4337@stusta.de> <42193BFD.9070900@pobox.com> <20050221144809.GC3187@stusta.de> <421A471A.7090503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421A471A.7090503@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 03:39:54PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >@@ -197,7 +194,7 @@
> > 	ei_status.priv = phys_mem;
> > 
> > 	if (ei_debug > 0)
> >-		printk(version);
> >+		printk("ne3210 driver");
> 
> 
> missing newline.  Do something like "ns3210 __DATE__ loaded.\n"
> 
> Ditto for seeq8002.

Sorry for the missing newline.

I have to admit I still don't see why these printk's have to stay:
In both files, there are other printk's nearby that print the name of 
the driver.

__DATE__ doesn't provide any information that wasn't already available 
in the first line of the dmesg output.

> 	Jeff

cu
Adrian

--

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

