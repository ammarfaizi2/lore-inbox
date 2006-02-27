Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWB0PMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWB0PMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWB0PMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:12:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35592 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751409AbWB0PMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:12:53 -0500
Date: Mon, 27 Feb 2006 16:12:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, scottm@somanetworks.com,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [2.6 patch] drivers/pci/hotplug/cpqphp_ctrl.c: board_replaced(): remove dead code
Message-ID: <20060227151252.GV3674@stusta.de>
References: <20060226211651.GN3674@stusta.de> <20060226235549.GW28587@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226235549.GW28587@parisc-linux.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 04:55:49PM -0700, Matthew Wilcox wrote:
> On Sun, Feb 26, 2006 at 10:16:51PM +0100, Adrian Bunk wrote:
> > he Coverity checker correctly noted, that in function board_replaced in
> > drivers/pci/hotplug/cpqphp_ctrl.c, the variable src always has the
> > value 8, and therefore much code after the
> > 
> > ...
> >                         if (rc || src) {
> > ...
> >                                 if (rc)
> >                                         return rc;
> >                                 else
> >                                         return 1;
> >                         }
> > ...
> > 
> > 
> > can never be called.
> > 
> > This patch removes the unreachable code in this function fixing kernel 
> > Bugzilla #6073.
> 
> It seems much  more  likely to me that the '|| src' indicates a bug, and
> the unreachable  code  should have been  reached.  Why not cc the
> maintainer for his opinion?

I did, at least I thought I did...

I thought the following was the right entry in MAINTAINERS for this 
driver:

PCI HOTPLUG COMPAQ DRIVER
P:      Greg Kroah-Hartman
M:      greg@kroah.com
S:      Maintained


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

