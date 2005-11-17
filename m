Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161168AbVKQHZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbVKQHZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 02:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbVKQHZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 02:25:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:26248 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161168AbVKQHZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 02:25:25 -0500
Date: Wed, 16 Nov 2005 23:05:16 -0800
From: Greg KH <greg@kroah.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EDAC and the sysfs
Message-ID: <20051117070516.GB20760@kroah.com>
References: <20051115172528.GB13658@kroah.com> <20051116002638.762.qmail@web50106.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116002638.762.qmail@web50106.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 04:26:38PM -0800, Doug Thompson wrote:
> Speaking of controls, edac has them  currently in
> /proc/sys/mc. I have proposed to have them in
> /sys/devices/system/edac/mc and friends. 
> 
> My question is:  Should I remove entirely my old
> /proc/sys/mc sysctl tree? Or still maintain the
> aliases there (which seems weird)? 

That would be wierd, just drop the sysctl stuff.

> If I do that, then /etc/sysctl.conf will no longer
> allow for setting things up there.

True.

> Is there going to be a similiar functionality as
> /etc/sysctl.conf for those items we place in sysfs, in
> the future?

If you want to write one, sure :)

But you can just probably use a udev rule to initialize your things
properly, that's what all of the distros are now using.

> PS. These questions on sysfs seem a perfect food
> stream for your 'HOWTO do kernel development'. Trying
> to do new entries in sysfs has been a painstaking
> adventure. After googling the web for info, it
> definitely has been a bit thin on information on sysfs
> at the level I am seeking.

sysfs and the driver model are woefully underdocumented.  Right now, I'd
recommend the Linux Device Drivers, third edition, free online if you
don't want to buy it, for anyone doing any driver core stuff.  It has a
whole chapter that is the most up-to-date and the best description I've
seen so far.

But even then, it is out of date, due to api changes, sorry.

thanks,

greg k-h
