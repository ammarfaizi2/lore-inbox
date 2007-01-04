Return-Path: <linux-kernel-owner+w=401wt.eu-S1030301AbXADX6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbXADX6k (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbXADX6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:58:40 -0500
Received: from ns.suse.de ([195.135.220.2]:58411 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030302AbXADX6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:58:39 -0500
Date: Thu, 4 Jan 2007 15:57:58 -0800
From: Greg KH <gregkh@suse.de>
To: Hugh Dickins <hugh@veritas.com>, kay.sievers@vrfy.org
Cc: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, yi.zhu@intel.com
Subject: Re: 2.6.20-rc2-mm1 -- INFO: possible recursive locking detected
Message-ID: <20070104235758.GA32132@suse.de>
References: <a44ae5cd0612300247n529f48a6t81edb503bc646f73@mail.gmail.com> <20070104214747.GD28445@suse.de> <Pine.LNX.4.64.0701042339080.4441@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701042339080.4441@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 11:50:02PM +0000, Hugh Dickins wrote:
> On Thu, 4 Jan 2007, Greg KH wrote:
> > On Sat, Dec 30, 2006 at 02:47:20AM -0800, Miles Lane wrote:
> > > Sorry Andrew, I am not sure which maintainer to contact about this.  I
> > > CCed gregkh for sysfs and Yi for ipw2200.  Hopefully this is helpful.
> > > BTW, I also found that none of my network drivers were recognized by
> > > hal (lshal did not show their "net" entries) unless I set
> > > CONFIG_SYSFS_DEPRECATED=y.  I am running Ubuntu development (Feisty
> > > Fawn), so it seems like I ought to be running pretty current hal
> > > utilities:   hal-device-manager       0.5.8.1-4ubuntu1.  After
> > > reenabling CONFIG_SYSFS_DEPRECATED, I am able to use my IPW2200
> > > driver, in spite of this recursive locking message, so this INFO
> > > message may not indicate a problem.
> > 
> > Does this show up on the 2.6.20-rc3 kernel too?
> 
> Yes.  Well, I can't speak for Miles on Ubuntu, but I have ipw2200
> on openSUSE 10.2 (using ifplugd if that matters), and have to build
> my 2.6.20-rc3 with CONFIG_SYSFS_DEPRECATED=y in order to get an IP
> address (no idea whether it's a hald issue in my case).  Likewise
> needed CONFIG_SYSFS_DEPRECATED=y with 2.6.19-rc-mm on SuSE 10.1.

I was referring to the locking traceback :)

But anyway, Kay, I thought that 10.2 would work with
CONFIG_SYSFS_DEPRECATED=y?

And yes, 10.1 I know will not work that way, but as it's not supported
anymore, that's not a big deal :)

> --- 2.6.20-rc3/init/Kconfig	2007-01-01 10:30:46.000000000 +0000
> +++ linux/init/Kconfig	2007-01-04 23:36:40.000000000 +0000
> @@ -266,7 +266,7 @@ config SYSFS_DEPRECATED
>  	  that belong to a class, back into the /sys/class heirachy, in
>  	  order to support older versions of udev.
>  
> -	  If you are using a distro that was released in 2006 or later,
> +	  If you are using a distro that was released in 2008 or later,
>  	  it should be safe to say N here.

Well, I'm using a distro released in 2006 that works just fine (Gentoo
unstable, Debian unstable should also work.  I think even Gentoo stable
works too, but haven't tried that out...)

thanks,

greg k-h
