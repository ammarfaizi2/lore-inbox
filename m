Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030669AbWI0TZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030669AbWI0TZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030672AbWI0TZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:25:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30219 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030670AbWI0TZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:25:57 -0400
Date: Wed, 27 Sep 2006 14:40:42 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 26/47] Driver core: add groups support to struct device
Message-ID: <20060927144041.GA4519@ucw.cz>
References: <11592491482560-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <d120d5000609260620me5cf24bw83fc6d65fa7cb232@mail.gmail.com> <20060926134654.GB11435@kroah.com> <d120d5000609260701q65039221rac64d043a5b55df9@mail.gmail.com> <20060926142340.GA11999@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926142340.GA11999@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Why can't the device itself manage it? If you want to stub out the
> > common parts just create a function like netdev_suspend and call it at
> > appropriate time.
> 
> Because you would then need to add that function call to _every_ network
> device driver.  This way, we do not need to do that as the class gets
> called in the proper place before the device driver does.

I'm not sure this is good idea, it also has potential to break all the
network devices with one diff.

Some devices will be doing parts of class_suspend already, so I do not
think that some breakage will happen.

-- 
Thanks for all the (sleeping) penguins.
