Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUGVThU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUGVThU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUGVThR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:37:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39637 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265249AbUGVThC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:37:02 -0400
Date: Thu, 22 Jul 2004 21:36:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Michael Heyse <mhk@designassembly.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_NET_RADIO vs CONFIG_NET_WIRELESS
Message-ID: <20040722193655.GF19329@fs.tum.de>
References: <40FFC13A.9020201@designassembly.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FFC13A.9020201@designassembly.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 03:29:30PM +0200, Michael Heyse wrote:
> I am confused. CONFIG_NET_RADIO is set when you select "Wireless LAN 
> drivers". But building of drivers/net/wireless depends on 
> CONFIG_NET_WIRELESS, but not a single Kconfig defines this value (it is 
> defined in some defconfigs though). So the wireless LAN drivers are 
> never built.
> 
> What am I missing???

The following from drivers/net/wireless/Kconfig:

<--  snip  -->

config NET_WIRELESS
        bool
        depends on NET_RADIO && (ISA || PCI || PPC_PMAC || PCMCIA)
        default y

<--  snip  -->

> Michael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

