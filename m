Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422874AbWJPTkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422874AbWJPTkH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbWJPTkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:40:07 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:21894 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1422874AbWJPTkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:40:04 -0400
Date: Mon, 16 Oct 2006 21:39:25 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
Message-ID: <20061016193925.GA20009@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061008193005.GJ6755@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008193005.GJ6755@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Adrian Bunk <bunk@stusta.de>:
> Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
> 
> On Sun, Oct 08, 2006 at 07:59:58PM +0200, Michael S. Tsirkin wrote:
> > Quoting r. Adrian Bunk <bunk@stusta.de>:
> > > Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
> > > 
> > > On Sun, Oct 08, 2006 at 07:12:54AM +0000, Pavel Machek wrote:
> > > > 
> > > > On Sat 07-10-06 23:46:21, Adrian Bunk wrote:
> > > > > This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
> > > > > that are not yet fixed Linus' tree.
> > > > > 
> > > > ...
> > > > > Subject    : T60 stops triggering any ACPI events
> > > > > References : http://lkml.org/lkml/2006/10/4/425
> > > > > Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> > > > > Status     : unknown
> > 
> > This was on a pre -rc1 git tree.
> > I've been using -rc1 since it's out and does not happen to me anymore.
> > So we probably can write this off as a memory corruption
> > issue that got fixed in between.
> 
> Thanks for the information, I've removed it from the list.
 

Unfortunately, this came back after using 2.6.19-rc1 for a couple of days
without reboot. And I just re-tested and was able to re-produce the problem on
2.6.19-rc2, as well. So the problem is still there, with the same symptoms:
after usig machine for a while, or under stress (e.g. if I do a full kernel
compile), I stop getting any ACPI events.

tail -f /var/log/acpid
does not show anything, even on Fn/F4 which is supposed ot be always enabled.
Restarting the acpid doesn't do anything either - ACPI starts working
again, for a while, only after reboot.

Worked fine under 2.6.18 (I was running vanilla + this patch
http://lkml.org/lkml/2006/7/20/56 which made it into upstream since then).

Any ideas? How to debug this?

-- 
MST
