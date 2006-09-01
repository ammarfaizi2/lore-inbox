Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWIAQeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWIAQeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWIAQeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:34:12 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20742 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030193AbWIAQeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:34:09 -0400
Date: Fri, 1 Sep 2006 18:34:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060901163403.GC18276@stusta.de>
References: <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de> <Pine.LNX.4.64.0608310039440.6761@scrub.home> <1157069717.2347.13.camel@shinybook.infradead.org> <20060831174852.18efec7e.rdunlap@xenotime.net> <1157074048.2347.24.camel@shinybook.infradead.org> <20060901134425.GA32440@wohnheim.fh-wedel.de> <44F85267.1000607@s5r6.in-berlin.de> <20060901161920.GB32440@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060901161920.GB32440@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 06:19:20PM +0200, Jörn Engel wrote:
> On Fri, 1 September 2006 17:31:51 +0200, Stefan Richter wrote:
> > 
> > Yes and no. In the latter case, they have to magically know that at
> > least menuconfig and xconfig can be tricked to list depending options.
> 
> True.  Marginally better than horrible then. :)
> 
> > Could be a fun project [...]
> 
> Absolutely.  Assuming that select gets removed in the process, and
> concentrating on oldconfig, would it be enough to have something like
> this in the .config?
> 
> # CONFIG_USB_STORAGE has unmet dependencies: CONFIG_SCSI, CONFIG_BLOCK
> 
> Now people looking for usb mass storage can find the option without
> grepping through Kconfig files, but also every single driver for every
> single disabled subsystem shows up.  Might be a bit too much.

Common use case:
A driver was changed to use FW_LOADER.
The .config for the old kernel contains CONFIG_FW_LOADER=n.
The user runs "make oldconfig" with the old .config in the new kernel.

How do you plan to handle this reasonably without select?

> Jörn

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

