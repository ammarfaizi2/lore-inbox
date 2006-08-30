Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWH3SPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWH3SPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750700AbWH3SPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:15:19 -0400
Received: from smtp10.orange.fr ([193.252.22.21]:56160 "EHLO
	smtp-msa-out10.orange.fr") by vger.kernel.org with ESMTP
	id S1751264AbWH3SPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:15:17 -0400
X-ME-UUID: 20060830181516374.5B7802400145@mwinf1004.orange.fr
Date: Wed, 30 Aug 2006 20:13:10 +0200
To: David Lang <dlang@digitalinsight.com>
Cc: Olaf Hering <olaf@aepfle.de>, Michael Buesch <mb@bu3sch.de>,
       Greg KH <greg@kroah.com>, Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060830181310.GA11213@powerlinux.fr>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz> <20060829183208.GA11468@kroah.com> <200608292104.24645.mb@bu3sch.de> <20060829201314.GA28680@aepfle.de> <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz> <20060830054433.GA31375@aepfle.de> <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 10:52:02AM -0700, David Lang wrote:
> On Wed, 30 Aug 2006, Olaf Hering wrote:
> 
> >>you are assuming that
> >>
> >>1. modules are enabled and ipw2200 is compiled as a module
> >
> >No, why?
> 
> becouse if the ipw isn't compiled as a module then it's initialized 
> (without firmware) before the initramfs or initrd is run. if it could be 
> initialized later without being a module then it could be initialized as 
> part of the normal system

Euh, ...

I wonder why you need to initialize the ipw2200 module so early ? It was my
understanding that the initramfs thingy was run very early in the process, and
i had even thought of moving fbdev modules into it.

Do you really need to bring up ipw2200 so early ? It is some kind of wireless
device, right ? 

As for initramfs, you can just cat it behind the kernel, and it should work
just fine, or at least this is how it was supposed to work.

Friendly,

Sven Luther
