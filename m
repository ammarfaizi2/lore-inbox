Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVAFJ5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVAFJ5q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbVAFJ5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:57:46 -0500
Received: from gprs214-26.eurotel.cz ([160.218.214.26]:21382 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262800AbVAFJ5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:57:45 -0500
Date: Thu, 6 Jan 2005 10:57:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: Len Brown <len.brown@intel.com>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 0/4]Bind physical devices with ACPI devices - take 2
Message-ID: <20050106095731.GE24380@elf.ucw.cz>
References: <1104893444.5550.127.camel@sli10-desk.sh.intel.com> <1104984055.18173.239.camel@d845pe> <1104997834.22886.17.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104997834.22886.17.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It looks like some device drivers scribble on dev->platform_data;
> > and we need to fix those drivers before deploying this patch.
> > Alternatively, we could add a new field to struct device,
> > but then we'd probably never get rid of it...
> Yep, this is a big problem. According to the comments in the source
> file, it's designed for firmware such as ACPI, but some drivers misused
> it. A search shows there are many such drivers. Fixing the drivers is a
> pain for me.

It is easy: remove the field for release or two, then readd it with
your patch.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
