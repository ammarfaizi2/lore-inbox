Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbVFWI27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbVFWI27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbVFWIWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:22:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:37022 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262611AbVFWHBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:01:51 -0400
Date: Wed, 22 Jun 2005 23:51:32 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Bell <kernel@mikebell.org>, miles@gnu.org, gregkh@suse.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623065132.GD11638@kroah.com>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp> <20050623063457.GB955@mikebell.org> <20050622233759.7a1130a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622233759.7a1130a9.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 11:37:59PM -0700, Andrew Morton wrote:
> Mike Bell <kernel@mikebell.org> wrote:
> >
> > On Thu, Jun 23, 2005 at 03:14:08PM +0900, Miles Bader wrote:
> > > BTW, has anyone done a comparison of the space usage of udev vs. devfs
> > > (including size of code etc....)?
> > 
> > Greg gave me an "I assume so" estimate that udev was smaller by excluding
> > the size of sysfs a while back. If you include sysfs in udev's overhead
> > then I believe devfs wins handily, but I haven't done the numbers to
> > prove it so my estimate is no better. I'm just basing it on sysfs being
> > absolutely huge, in linux-tiny terms.
> 
> sysfs certainly has a history of goggling gobs of memory.  But you can
> disable it in .config.

Now the majority of sysfs memory is cachable and can get reclaimed quite
easily.  The people running the 20,000 disk farms on a 31 bit
architecture made sure of that.

thanks,

greg k-h
