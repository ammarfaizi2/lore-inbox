Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbTLWNRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTLWNRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:17:04 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:25871 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265146AbTLWNRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:17:01 -0500
Date: Tue, 23 Dec 2003 13:16:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs misc device support  [3/4]
Message-ID: <20031223131658.C6864@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223002800.GD4805@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031223002800.GD4805@kroah.com>; from greg@kroah.com on Mon, Dec 22, 2003 at 04:28:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 04:28:00PM -0800, Greg KH wrote:
> This adds /sys/class/mem which enables all misc char devices to show up
> properly in udev.
> 
> Note, the misc_init() call has been moved to a subsys_initcall as it
> seems there are a lot of platform specific misc devices that are calling
> misc_register before misc_init() is called.
> 
> Has been posted to lkml a few times in the past and tested by a wide
> range of people.

So how are misc devices a device class now?  This is just a random coolection
of drivers that traditionally didn't have their own major.  Killing misc
devices sounds like abetter plan than codifying this in sysfs..

