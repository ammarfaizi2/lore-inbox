Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbULTRz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbULTRz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbULTRyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:54:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18181 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261592AbULTRwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:52:02 -0500
Date: Mon, 20 Dec 2004 18:51:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arne Caspari <arnem@informatik.uni-bremen.de>
Cc: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041220175156.GW21288@stusta.de>
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C694E0.8010609@informatik.uni-bremen.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 10:01:20AM +0100, Arne Caspari wrote:

> Adrian,

Hi Arne,

> Some of these symbols are used by the open source driver "video-2-1394" 
> ( http://sourceforge.net/projects/video-2-1394 ).
> 
> This driver is supported by The Imaging Source Europe GmbH and used by 
> quite a few of our customers. For most of these customers, it is OK to 
> compile the driver but not to modify the kernel source.
> 
> Please please, do not break the kernel API out of the blue. Supporting a 
> Linux driver is already very frustrating. Currently it is a lot more 
> convenient for our customers to switch to Windows just because the 
> installation and use of the software is much easier there - or at least 
> it is easy enough there to handle the installation where it is not on Linux.
> 
> Breaking the API now will most likely stop The Imaging Source from 
> supporting open source driver development anymore. We just can not 
> effort any unneccessary development anymore. We are already blocked by 
> shortcomings in the LDM and bugs in the Linux driver handling ( see my 
> posings about a hotplugging issue and about the issue that IEEE-1394 
> modules can not be unloaded ).

the perfect solution would be if you'd simply submit your driver for 
inclusion in the main kernel.

After grepping through your CVS sources, it seems hpsb_read and 
hpsb_write are the EXPORT_SYMBOLS affecting you?
So keeping them should address your concerns?

> Thanks and best regards,
> 
> Arne Caspari
> 
> The Imaging Source Europe GmbH

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

