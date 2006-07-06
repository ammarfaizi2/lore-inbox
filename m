Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWGFWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWGFWVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWGFWVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:21:42 -0400
Received: from ns1.suse.de ([195.135.220.2]:46009 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750924AbWGFWVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:21:41 -0400
Date: Thu, 6 Jul 2006 15:17:47 -0700
From: Greg KH <greg@kroah.com>
To: David R <david@unsolicited.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc1
Message-ID: <20060706221747.GA2632@kroah.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <44AD680B.9090603@unsolicited.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AD680B.9090603@unsolicited.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 08:44:11PM +0100, David R wrote:
> Linus Torvalds wrote:
> > Ok,
> >  the merge window for 2.6.18 is closed, and -rc1 is out there (git trees 
> 
> Most things seem fine here with rc1, but I do see a permissions issue with my
> USB scanner.
> 
> In 2.6.17
> 
> david@davidux:/dev/bus/usb/001 # l
> total 0
> drwxr-xr-x 2 root  root    100 2006-07-06 20:19 ./
> drwxr-xr-x 4 root  root     80 2006-07-06 20:19 ../
> crw-r--r-- 1 root  root 189, 0 2006-07-06 20:19 001
> crw-r--r-- 1 david root 189, 1 2006-07-06 20:19 002
> crw-r--r-- 1 root  root 189, 4 2006-07-06 20:19 005
> 
> but with 2.6.18
> 
> david@davidux:/dev/bus/usb/001> l
> total 0
> drwxr-xr-x 2 root root    100 2006-07-06 20:24 ./
> drwxr-xr-x 4 root root     80 2006-07-06 20:24 ../
> crw-r--r-- 1 root root 189, 0 2006-07-06 20:24 001
> crw-r--r-- 1 root root 189, 1 2006-07-06 20:24 002
> crw-r--r-- 1 root root 189, 4 2006-07-06 20:24 005
> 
> Does something need tweaking with udev scripts maybe? This is a SuSE 10.1 system.

Perhaps, that is odd.  The scanner should default to the logged in user,
right?  Please file a bug at bugzilla.novell.com and the SuSE people can
work on it there.

thanks,

greg k-h
