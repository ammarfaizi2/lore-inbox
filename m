Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWEDXWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWEDXWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 19:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWEDXWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 19:22:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750818AbWEDXWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 19:22:21 -0400
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Peter Jones <pjones@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Martin Mares <mj@ucw.cz>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <1146778197.27727.26.camel@localhost.localdomain>
	 <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Thu, 04 May 2006 19:22:03 -0400
Message-Id: <1146784923.4581.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 17:38 -0400, Jon Smirl wrote:

> # cd /sys/bus/pci/devices/0000:01:00.0
> # echo 1 >rom
> # hexdump -C rom
> 
> As far as I know this works on every platform, not just the PC one.

Yep, you're right, this works.  So we don't necessarily need it for the
vbetool case.  X still could use it though, instead of their scary
poke-at-memory way.

> Don't mess around with the hardware trying to get to the ROM. Use the
> API provided by the kernel. Messing with the hardware will get it into
> a state that the kernel doesn't know about and can ultimately crash
> your system.

Exactly who do you see here messing with the hardware directly instead
of using kernel APIs?

-- 
  Peter

