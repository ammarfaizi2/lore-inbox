Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263343AbVBEGSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbVBEGSu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVBEGSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:18:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:9412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264804AbVBEGSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:18:09 -0500
Date: Fri, 4 Feb 2005 22:16:36 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] driver core: export MAJOR/MINOR to the hotplug env
Message-ID: <20050205061636.GA1185@kroah.com>
References: <20050123041911.GA9209@vrfy.org> <20050201225625.GA14962@kroah.com> <20050202004812.GA29888@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202004812.GA29888@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 01:48:12AM +0100, Kay Sievers wrote:
> On Tue, Feb 01, 2005 at 02:56:25PM -0800, Greg KH wrote:
> > Hm, that class_simple interface is looking like the way we should move
> > toward, as it's "simple" to use, instead of the more complex class code.
> > I'll have to look at migrating more code to use it over time, or move
> > that interface back into the class code itself...
> 
> Nice idea! What about keeping a list of devices belonging to a
> specific class in an own list in 'struct class' and maintaining that list
> with class_device_add(), class_device_del()?

What would that help out with?

> A class driver may use that list to keep track of its own devices if
> wanted and class_simple would not be needed anymore as everything
> would be available in the core.

I must be tired, but I don't see how class_simple could be dropped if
that was done.  Care to explain it with pseudo-code or something?

thanks,

greg k-h
