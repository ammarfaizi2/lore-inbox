Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVAYPnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVAYPnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVAYPnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:43:13 -0500
Received: from modemcable096.213-200-24.mc.videotron.ca ([24.200.213.96]:4517
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261996AbVAYPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:41:54 -0500
Date: Tue, 25 Jan 2005 10:41:45 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@localhost.localdomain
To: Ian Campbell <icampbell@arcom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: use datacs is smc91x driver
In-Reply-To: <1106665612.19123.142.camel@icampbell-debian>
Message-ID: <Pine.LNX.4.61.0501251038030.16341@localhost.localdomain>
References: <1106569302.19123.49.camel@icampbell-debian> 
 <Pine.LNX.4.61.0501241459090.7307@localhost.localdomain> 
 <1106651657.19123.54.camel@icampbell-debian> <1106665612.19123.142.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005, Ian Campbell wrote:

> On Tue, 2005-01-25 at 11:14 +0000, Ian Campbell wrote:
> > Are you happy with "iocs", "attrib" and "datacs" for the names?
> 
> Of the platforms with an smc91x platform_device (according to grep) only
> 2 (lubbock, neponset) out of the 18 have memory resources other than the
> iocs (full list of platforms is at the end, after the patch)
> 
> So for the sake of the least intrusive patch I think for the main iocs
> I'll call _byname and fallback on mem resource number 0 if no named iocs
> resource exists. attrib and datacs must be explicitly named. This allows
> most of the board ports to remain unchanged.

Sensible.

> I also noticed that the name propagates into /proc/iomem etc
> 	# cat /proc/iomem
> 	[...]
> 	10000000-10000003 : datacs
> 	  10000000-10000003 : smc91x
> so perhaps smc91x-datacs -attrib -iocs might be more appropriate names?

Probably, although "iocs" is rather criptic for someone not familiar 
with the chip.  What about "smc91x-regs", "smc91x-attrib" and 
"smc91x-data32" ?


Nicolas
