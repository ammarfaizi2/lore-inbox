Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbULRWZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbULRWZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 17:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbULRWZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 17:25:22 -0500
Received: from waste.org ([216.27.176.166]:10383 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261185AbULRWZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 17:25:17 -0500
Date: Sat, 18 Dec 2004 14:24:57 -0800
From: Matt Mackall <mpm@selenic.com>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041218222457.GB28322@waste.org>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216190835.GE5654@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 11:08:35AM -0800, Greg KH wrote:
> On Thu, Dec 16, 2004 at 11:00:02AM -0800, Pete Zaitcev wrote:
> > Hi Greg,
> > 
> > what is the canonic place to mount debugfs: /debug, /debugfs, or anything
> > else? The reason I'm asking is that USBMon has to find it somewhere and
> > I'd really hate to see it varying from distro to distro.
> 
> Hm, in my testing I've been putting it in /dbg, but I don't like vowels :)
> 
> Anyway, I don't really know.  /dev/debug/ ?  /proc/debug ?  /debug ?
> 
> What do people want?  I guess it's time to write up a LSB proposal :(

What I'd like is to _not_ have a standard, so that no one is tempted
to depend on it being there. No one but developers should mount it by
default and no standard tools should depend on it for functionality.

If you put it in a standard place, people will start treating it as
ABI and then a year down the road we will have _three_ /proc-style
ABI barf-bags rather than just one.

-- 
Mathematics is the supreme nostalgia of our time.
