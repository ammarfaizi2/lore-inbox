Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289044AbSAIW3l>; Wed, 9 Jan 2002 17:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289048AbSAIW3V>; Wed, 9 Jan 2002 17:29:21 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:59920 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289044AbSAIW3R>;
	Wed, 9 Jan 2002 17:29:17 -0500
Date: Wed, 9 Jan 2002 14:26:57 -0800
From: Greg KH <greg@kroah.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__ - patch for USB
Message-ID: <20020109222657.GA23143@kroah.com>
In-Reply-To: <3C3CC04D.2080807@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3CC04D.2080807@intel.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 12 Dec 2001 20:23:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 12:12:29AM +0200, Vladimir Kondratiev wrote:
> Hello,
> Since I have started this thread, I feel I have to do something real. 
> Dummy technical work, but someone have to do it, right?
> I patched USB subsystem, it uses __FUNCTION__ in deprecated way no more.
> What is changed?
> - in usb.h, I modified dbg(), warn(), err(), info() macros to contain 
> function name in the prefix. These macros are for simple one-line messages.
> - in all files under drivers/usb, all macros mentioned fixed.
> - all __FUNCTION__ occurencies in drivers/usb revised.
> 
> I compiled kednel with all USB modules enabled. Since everything 
> compiles OK and all changes are in message formats, this patch should 
> not corrupt anything. In the worst case you will get badly formatted 
> message.

Your patch makes whitespace changes to a lot of dbg() statements, but
does not modify their contents.  Can you please change this, as this
change does not need to happen.

> Patch is against 2.4.17

2.4.18-pre2 has a _lot_ of usb changes and this patch misses a number of
places.

I'd also like to see this against the 2.5.x tree first, as the
recommended compiler for the 2.4.x tree is still 2.95.3, and I don't
think that will change anytime soon.

thanks,

greg k-h
