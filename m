Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWEEU1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWEEU1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWEEU1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:27:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:29858 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751003AbWEEU1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:27:45 -0400
Date: Fri, 5 May 2006 13:26:03 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <20060505202603.GB6413@kroah.com>
References: <200605041326.36518.bjorn.helgaas@hp.com> <E1FbjiL-0001B9-00@chiark.greenend.org.uk> <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com> <1146776736.27727.11.camel@localhost.localdomain> <mj+md-20060504.211425.25445.atrey@ucw.cz> <1146778197.27727.26.camel@localhost.localdomain> <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com> <1146784923.4581.3.camel@localhost.localdomain> <445BA584.40309@us.ibm.com> <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 04:14:00PM -0400, Jon Smirl wrote:
> I would like to see other design alternatives considered on this
> issue. The 'enable' attribute has a clear problem in that you can't
> tell which user space program is trying to control the device.
> Multiple programs accessing the video hardware with poor coordination
> is already the source of many problems.

Who cares who "enabled" the device.  Remember, the majority of PCI
devices in the system are not video ones.  Lots of other types of
devices want this ability to enable PCI devices from userspace.  I've
been talking with some people about how to properly write PCI drivers in
userspace, and this attribute is a needed part of it.

And if X gets enabling the device wrong, again, who cares, it's not a
kernel issue. :)

thanks,

greg k-h
