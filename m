Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWBLXQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWBLXQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWBLXQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:16:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34824 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751061AbWBLXQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:16:25 -0500
Date: Mon, 13 Feb 2006 00:16:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove the CONFIG_CC_ALIGN_* options
Message-ID: <20060212231618.GM30922@stusta.de>
References: <20060212174802.GJ30922@stusta.de> <20060212214046.GA20477@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212214046.GA20477@kvack.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 04:40:46PM -0500, Benjamin LaHaise wrote:
> On Sun, Feb 12, 2006 at 06:48:02PM +0100, Adrian Bunk wrote:
> > I don't see any use case for the CONFIG_CC_ALIGN_* options:
> > - they are only available if EMBEDDED
> > - people using EMBEDDED will most likely also enable 
> >   CC_OPTIMIZE_FOR_SIZE
> > - the default for -Os is to disable alignment
> 
> CONFIG_EMBEDDED should actually be spell CONFIG_ADVANCED.  Not everyone 

We need both with CONFIG_EMBEDDED depending on CONFIG_ADVANCED (see my 
other email).

> testing different alignments is building an embedded system targetted for 
> size.  The option is just as useful in doing performance comparisons.  
> Besides, is it really a maintenence load?

It is not a maintenence load, but does it make sense to offer this in 
any way to _users_?

gcc already sets this options with -Os/-O2.

We do already override the choice of gcc in some cpu specific cases.

If someone is doing performance comparisons and discovers that the 
default settings gcc chooses aren't good, the only sane thing is to 
discuss whether it makes sense to change this.

> 		-ben

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

