Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWHESLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWHESLR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 14:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWHESLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 14:11:17 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:10126 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030295AbWHESLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 14:11:16 -0400
Date: Sat, 5 Aug 2006 22:10:47 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take4 1/4] kevent: Core files.
Message-ID: <20060805181047.GA22177@2ka.mipt.ru>
References: <11547829553148@2ka.mipt.ru> <11547829581556@2ka.mipt.ru> <20060805175702.GA27992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060805175702.GA27992@kroah.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 05 Aug 2006 22:10:49 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 10:57:02AM -0700, GregKH (greg@kroah.com) wrote:
> > +	dev = class_device_create(kevent_user_class, NULL, 
> > +			MKDEV(kevent_user_major, 0), NULL, kevent_name);
> > +	if (IS_ERR(dev)) {
> > +		printk(KERN_ERR "Failed to create %d.%d class device in \"%s\" class: err=%ld.\n", 
> > +				kevent_user_major, 0, kevent_name, PTR_ERR(dev));
> > +		err = PTR_ERR(dev);
> > +		goto err_out_class_destroy;
> > +	}
> 
> As you are only using 1 minor number in this code, why not just use a
> miscdevice instead?  It saves a bit of overhead and makes the code a
> tiny bit smaller :)

No problem. I will move it to miscdevice instead of full chardev.

> thanks,
> 
> greg k-h

-- 
	Evgeniy Polyakov
