Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbTHVO62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTHVO62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:58:28 -0400
Received: from waste.org ([209.173.204.2]:39357 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263196AbTHVO61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:58:27 -0400
Date: Fri, 22 Aug 2003 09:58:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm3 - cp -a kills machine
Message-ID: <20030822145804.GJ3958@waste.org>
References: <20030821220849.GE23889@waste.org> <Pine.LNX.4.53.0308212148270.1530@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308212148270.1530@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 09:49:03PM -0400, Zwane Mwaikambo wrote:
> On Thu, 21 Aug 2003, Matt Mackall wrote:
> 
> > I've just tried to copy the contents of a rescued disk image and
> > quickly reproduced a lockup. I'd dig more but I'm still working on the
> > rescue process, so I'm just sending this out as a data point for now.
> > Went a little like this:
> > 
> > # losetup /dev/loop0 repaired-disk-image  # ext3 image, passes fsck
> > # mke2fs -j /dev/hdc1
> > ...
> > # mount /dev/loop0 orig
> > # mount /dev/hdc1 new
> > # cp -av orig/ new/
> > [ solid hang after a few seconds ]
> 
> NMI watchdog?

I don't think so. I only ran this once with APIC enabled, while in X.
But I did have a netconsole client running and that didn't report anything.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
