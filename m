Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUIOBJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUIOBJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUIOBJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:09:00 -0400
Received: from soundwarez.org ([217.160.171.123]:18359 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S266345AbUIOBI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:08:57 -0400
Date: Wed, 15 Sep 2004 03:09:01 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@ximian.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915010901.GA19524@vrfy.org>
References: <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915000753.GA24125@kroah.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 05:07:53PM -0700, Greg KH wrote:
> On Mon, Sep 13, 2004 at 04:45:53PM +0200, Kay Sievers wrote:
> > Do we agree on the model that the signal is a simple verb and we keep
> > only a small dictionary of _static_ signal strings and no fancy compositions?
> 
> I agree with this.  And because of that, we should enforce that, and
> help prevent typos in the signals.  So, here's a patch that does just
> that, making it a lot harder to mess up (although you still can, as
> enumerated types aren't checked by the compiler...)  This patch booted
> on my test box.
> 
> Anyone object to me adding this patch?  If not, I'll fix up Kay's patch
> for mounting to use this interface and add both of them.

I like it, so the printf is gone :) Fine with me.

> > And we should reserve the "add" and "remove" only for the hotplug events.
> 
> I don't know, the firmware objects already use "add" for an event.

Yes, but isn't the firmware event a real hotplug event? I just want to
be sure, that it's easy to recognize the hotplug events from userspace.

> I didn't put a check in the kobject_uevent() calls to prevent the add and
> remove, but now it's a lot easier to do so if you think it's necessary.

Don't think that this is needed. I will add somthing to the kobject
documentation, if it's stable and merged.

Thanks,
Kay
