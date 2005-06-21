Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVFUVTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVFUVTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVFUVSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:18:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57614 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262339AbVFUVEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:04:15 -0400
Date: Tue, 21 Jun 2005 23:04:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: rostedt@goodmis.org, gregkh@suse.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC: 2.6 patch] better USB_MON dependencies
Message-ID: <20050621210410.GA3705@stusta.de>
References: <Pine.LNX.4.58.0506172156220.7916@ppc970.osdl.org> <1119119175.6786.4.camel@localhost.localdomain> <20050621143227.GO3666@stusta.de> <20050621123507.6b83ddf0.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621123507.6b83ddf0.zaitcev@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 12:35:07PM -0700, Pete Zaitcev wrote:
> On Tue, 21 Jun 2005 16:32:27 +0200, Adrian Bunk <bunk@stusta.de> wrote:
>...
> One question though, do we want this:
> 
> > -obj-$(CONFIG_USB_MON)		+= mon/
> > +ifdef CONFIG_USB_MON
> > +  obj-$(CONFIG_USB)		+= mon/
> > +endif
> 
> Seems superfluous to me, because we kept CONFIG_USB_MON. This place should
> probably be left alone.

I thought it was required, but reading Documentation/kbuild/makefiles.txt
convinces me you are correct.

> -- Pete

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

