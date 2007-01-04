Return-Path: <linux-kernel-owner+w=401wt.eu-S1030294AbXADXtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbXADXtt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbXADXtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:49:49 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:64814 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030294AbXADXts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:49:48 -0500
X-AuditID: d80ac21c-9e939bb00000021a-3e-459d929b4183 
Date: Thu, 4 Jan 2007 23:50:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Greg KH <gregkh@suse.de>
cc: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, yi.zhu@intel.com
Subject: Re: 2.6.20-rc2-mm1 -- INFO: possible recursive locking detected
In-Reply-To: <20070104214747.GD28445@suse.de>
Message-ID: <Pine.LNX.4.64.0701042339080.4441@blonde.wat.veritas.com>
References: <a44ae5cd0612300247n529f48a6t81edb503bc646f73@mail.gmail.com>
 <20070104214747.GD28445@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Jan 2007 23:49:47.0432 (UTC) FILETIME=[04388A80:01C7305B]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Greg KH wrote:
> On Sat, Dec 30, 2006 at 02:47:20AM -0800, Miles Lane wrote:
> > Sorry Andrew, I am not sure which maintainer to contact about this.  I
> > CCed gregkh for sysfs and Yi for ipw2200.  Hopefully this is helpful.
> > BTW, I also found that none of my network drivers were recognized by
> > hal (lshal did not show their "net" entries) unless I set
> > CONFIG_SYSFS_DEPRECATED=y.  I am running Ubuntu development (Feisty
> > Fawn), so it seems like I ought to be running pretty current hal
> > utilities:   hal-device-manager       0.5.8.1-4ubuntu1.  After
> > reenabling CONFIG_SYSFS_DEPRECATED, I am able to use my IPW2200
> > driver, in spite of this recursive locking message, so this INFO
> > message may not indicate a problem.
> 
> Does this show up on the 2.6.20-rc3 kernel too?

Yes.  Well, I can't speak for Miles on Ubuntu, but I have ipw2200
on openSUSE 10.2 (using ifplugd if that matters), and have to build
my 2.6.20-rc3 with CONFIG_SYSFS_DEPRECATED=y in order to get an IP
address (no idea whether it's a hald issue in my case).  Likewise
needed CONFIG_SYSFS_DEPRECATED=y with 2.6.19-rc-mm on SuSE 10.1.

Hugh

--- 2.6.20-rc3/init/Kconfig	2007-01-01 10:30:46.000000000 +0000
+++ linux/init/Kconfig	2007-01-04 23:36:40.000000000 +0000
@@ -266,7 +266,7 @@ config SYSFS_DEPRECATED
 	  that belong to a class, back into the /sys/class heirachy, in
 	  order to support older versions of udev.
 
-	  If you are using a distro that was released in 2006 or later,
+	  If you are using a distro that was released in 2008 or later,
 	  it should be safe to say N here.
 
 config RELAY
