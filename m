Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWEDViv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWEDViv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEDViv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:38:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62396 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751415AbWEDViu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:38:50 -0400
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Peter Jones <pjones@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <9e4733910605041418n2105e50bs8803cd6ac8407c48@mail.gmail.com>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <9e4733910605041418n2105e50bs8803cd6ac8407c48@mail.gmail.com>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Thu, 04 May 2006 17:38:39 -0400
Message-Id: <1146778720.27727.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 17:18 -0400, Jon Smirl wrote: 
> On 5/4/06, Peter Jones <pjones@redhat.com> wrote:

> > It doesn't matter -- you can accomplish the same thing with e.g.
> > libx86emu and simply mapping the option rom to 0xc0000.  But you want to
> > do that in userland, not in the kernel.
> 
> It is much more complicated than than you describe.

I didn't really feel like explaining the parts we both already know.
I'll try to remember to do so in the future.

> Go look at the ROM code already checked in. Laptop video ROMs are not
> simple PCI devices that can be mapped around. They are stored in
> compressed form inside the system ROM and expanded at boot.

Yes, and this format is documented, too.  But right now there's no way
to get access to it with tools to actually do anything.

> If you lose the shadow copy in RAM there is no API for getting it back.

Except to enable the BAR and read it from the assigned address...

> These compressed ROMs are the source of a lot of laptop user's
> problems with suspend/resume on Linux.

Absolutely.  That's why I want a method to access them, which this
"enable" file provides.

> VGA support for multiple cards is a very complicated problem.

Please quit jumping up and down in the bicycle path telling everybody
how hard it is to ride a bike.

-- 
  Peter

