Return-Path: <linux-kernel-owner+w=401wt.eu-S1161058AbXAELe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbXAELe4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 06:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbXAELe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 06:34:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:49650 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161058AbXAELez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 06:34:55 -0500
Subject: Re: 2.6.20-rc2-mm1 -- INFO: possible recursive locking detected
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <gregkh@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       yi.zhu@intel.com
In-Reply-To: <20070104235758.GA32132@suse.de>
References: <a44ae5cd0612300247n529f48a6t81edb503bc646f73@mail.gmail.com>
	 <20070104214747.GD28445@suse.de>
	 <Pine.LNX.4.64.0701042339080.4441@blonde.wat.veritas.com>
	 <20070104235758.GA32132@suse.de>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 12:34:32 +0100
Message-Id: <1167996872.21293.2.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-04 at 15:57 -0800, Greg KH wrote:
> On Thu, Jan 04, 2007 at 11:50:02PM +0000, Hugh Dickins wrote:
> > On Thu, 4 Jan 2007, Greg KH wrote:
> > > On Sat, Dec 30, 2006 at 02:47:20AM -0800, Miles Lane wrote:
> > > > Sorry Andrew, I am not sure which maintainer to contact about this.  I
> > > > CCed gregkh for sysfs and Yi for ipw2200.  Hopefully this is helpful.
> > > > BTW, I also found that none of my network drivers were recognized by
> > > > hal (lshal did not show their "net" entries) unless I set
> > > > CONFIG_SYSFS_DEPRECATED=y.  I am running Ubuntu development (Feisty
> > > > Fawn), so it seems like I ought to be running pretty current hal
> > > > utilities:   hal-device-manager       0.5.8.1-4ubuntu1.  After
> > > > reenabling CONFIG_SYSFS_DEPRECATED, I am able to use my IPW2200
> > > > driver, in spite of this recursive locking message, so this INFO
> > > > message may not indicate a problem.
> > > 
> > > Does this show up on the 2.6.20-rc3 kernel too?
> > 
> > Yes.  Well, I can't speak for Miles on Ubuntu, but I have ipw2200
> > on openSUSE 10.2 (using ifplugd if that matters), and have to build
> > my 2.6.20-rc3 with CONFIG_SYSFS_DEPRECATED=y in order to get an IP
> > address (no idea whether it's a hald issue in my case).  Likewise
> > needed CONFIG_SYSFS_DEPRECATED=y with 2.6.19-rc-mm on SuSE 10.1.
> 
> I was referring to the locking traceback :)
> 
> But anyway, Kay, I thought that 10.2 would work with
> CONFIG_SYSFS_DEPRECATED=y?

Yes, HAL, udev, NetworkManager, ... from 10.2 works fine here, without
that option set.

Kay

