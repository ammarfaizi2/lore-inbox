Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWHQEws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWHQEws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 00:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWHQEws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 00:52:48 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:51095 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932280AbWHQEwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 00:52:47 -0400
Date: Thu, 17 Aug 2006 06:52:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ping Cheng <pingc@wacom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removing of UTS_RELEASE in include/linux/version.h
Message-ID: <20060817045242.GB16320@mars.ravnborg.org>
References: <6753EB6004AFF34FAA275742C104F95201753B@wacom-nt10.wacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6753EB6004AFF34FAA275742C104F95201753B@wacom-nt10.wacom.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 05:46:06PM -0700, Ping Cheng wrote:
> Hi Sam,
> 
> I was told that the removing of UTS_RELEASE in include/linux/version.h is
> permanent. I use it in my configuration script to get the version
> numbers of different kernel build sources.  Greg k-h told me to ask you
> about how to properly get the kernel source version.
> Do you have any suggestions?
For a propely configured kernel you can use 'make kernelrelease' which
will give you the same as UTS_RELEASE.

To get kernel version alone you can use 'make kernelversion'.

In a source file to be backward compatible you can use:
#include <linux/version.h>
#ifndef UTS_RELEASE
#include <linux/uts_release.h>
#endif

But in general using UTS_RELEASE in source is almost a sign of something
wrong.
For a module the UTS_RELEASE is retreiveable with modinfo.

> Please don't forget to cc me directly since I am not in the mailing list.
And likewise. Address me directly next time with cc: to lkml. I may miss
lkml mails.

	Sam
