Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265421AbSJXLnp>; Thu, 24 Oct 2002 07:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265436AbSJXLnp>; Thu, 24 Oct 2002 07:43:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41226 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265421AbSJXLno>;
	Thu, 24 Oct 2002 07:43:44 -0400
Date: Thu, 24 Oct 2002 12:49:52 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>, jung-ik.lee@intel.com,
       tony.luck@intel.com, pcihpd-discuss@lists.sourceforge.net,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: PCI Hotplug Drivers for 2.5
Message-ID: <20021024124952.U27461@parcelfarce.linux.theplanet.co.uk>
References: <72B3FD82E303D611BD0100508BB29735046DFF3F@orsmsx102.jf.intel.com> <20021024051008.GA19557@kroah.com> <20021024145839.OAHRC0A82654.59A07363@mvf.biglobe.ne.jp> <20021024061236.GJ19557@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021024061236.GJ19557@kroah.com>; from greg@kroah.com on Wed, Oct 23, 2002 at 11:12:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 11:12:36PM -0700, Greg KH wrote:
> I think we now all agree that resource management should move into a
> place where it can be shared by all pci hotplug drivers, right?
> 
> If so, anyone want to propose some common code?  I think the stuff in
> the ACPI driver that was pulled from the Compaq driver is a great start.
> I can try to pull this into the core myself, but if the Intel developers
> have the time, and energy, I would greatly appreciate their help (or
> anyone else who wants to join in.)

We already _have_ a lot of common code in drivers/pci, but it's not
compiled in for x86 or ia64.  some other architectures don't assign PCI
resources in the `BIOS' so we get to do it.  setup-bus.c, setup-res.c
and setup-irq.c all seem to duplicate some part of the code currently
found in each and every hotplug driver.

-- 
Revolutions do not require corporate support.
