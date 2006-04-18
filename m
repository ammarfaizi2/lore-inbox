Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWDRQnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWDRQnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWDRQnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:43:25 -0400
Received: from mx1.suse.de ([195.135.220.2]:6380 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751080AbWDRQnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:43:25 -0400
Date: Tue, 18 Apr 2006 09:41:37 -0700
From: Greg KH <greg@kroah.com>
To: Stelian Pop <stelian@popies.net>
Cc: YOSHIFUJI Hideaki / ???????????? <yoshfuji@linux-ipv6.org>,
       nicolas@boichat.ch, linux-usb-devel@lists.sourceforge.net,
       johannes@sipsolutions.net, mactel-linux-devel@lists.sourceforge.net,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       frank@scirocco-5v-turbo.de, petero2@telia.com, linux-kernel@hansmi.ch
Subject: Re: [PATCH] MacBook Pro touchpad support
Message-ID: <20060418164137.GA31841@kroah.com>
References: <1145358431.14816.18.camel@localhost> <20060418.212525.21076744.yoshfuji@linux-ipv6.org> <1145373471.23139.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145373471.23139.10.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 05:17:51PM +0200, Stelian Pop wrote:
> Le mardi 18 avril 2006 ?? 21:25 +0900, YOSHIFUJI Hideaki / ???????????? a
> ??crit :
> > In article <1145358431.14816.18.camel@localhost> (at Tue, 18 Apr 2006 13:07:11 +0200), Nicolas Boichat <nicolas@boichat.ch> says:
> > 
> > > @@ -147,13 +164,22 @@ MODULE_PARM_DESC(debug, "Activate debugg
> > >  /* Checks if the device a Geyser 2 (ANSI, ISO, JIS) */
> > >  static inline int atp_is_geyser_2(struct atp *dev)
> > >  {
> > > -	int16_t productId = le16_to_cpu(dev->udev->descriptor.idProduct);
> > > +	int productId = le16_to_cpu(dev->udev->descriptor.idProduct);
> > >  
> > >  	return (productId == GEYSER_ANSI_PRODUCT_ID) ||
> > >  		(productId == GEYSER_ISO_PRODUCT_ID) ||
> > >  		(productId == GEYSER_JIS_PRODUCT_ID);
> > >  }
> > 
> > Any good reasons to change this?
> 
> Because the use of a generic integer type is generally preferred over a
> fixed size type. And even if a fixed size was needed, u16/s16 would be
> more appropriate.

u16 is needed, s16 for USB ids is not correct.

And that int16_t crud is not correct either way :)

thanks,

greg k-h
