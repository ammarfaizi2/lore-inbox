Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSJXGH5>; Thu, 24 Oct 2002 02:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265326AbSJXGH5>; Thu, 24 Oct 2002 02:07:57 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53519 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265325AbSJXGHz>;
	Thu, 24 Oct 2002 02:07:55 -0400
Date: Wed, 23 Oct 2002 23:12:36 -0700
From: Greg KH <greg@kroah.com>
To: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
Cc: jung-ik.lee@intel.com, tony.luck@intel.com,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: PCI Hotplug Drivers for 2.5
Message-ID: <20021024061236.GJ19557@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF3F@orsmsx102.jf.intel.com> <20021024051008.GA19557@kroah.com> <20021024145839.OAHRC0A82654.59A07363@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024145839.OAHRC0A82654.59A07363@mvf.biglobe.ne.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 10:59:34PM -0700, KOCHI, Takayoshi wrote:
> Hi,
> 
> On Wed, 23 Oct 2002 22:10:08 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > Also, why doesn't the ACPI PCI hotplug driver work for your machines?
> > I've seen it work on a very wide range of processors (i386 and ia64),
> > and manufacturers, and any specific issues with your hardware would
> > probably be better addressed with patches to the existing ACPI driver.
> 
> The ACPI spec provides very limited control of actual hardware
> (With ACPI, we don't have common method for controlling such as Bus
> speed, LED etc.).
> So if a hardware comes with well-documented hotplug controller, we
> can achieve finer control over the hardware.

Ah, I didn't realize this.  So for some machines (like IBM's x440), we
should stick with using the hotplug controller driver, instead of using
the ACPI driver.  Sounds reasonable to me.

> The SHPC specification defines it still depends on ACPI for managing
> resources, etc.  So resource management portion can be and *should be*
> shared with all PCI hotplug drivers that use ACPI for resource
> management.
> 
> I think the most important thing is everyone agree on the direction
> in which we should go before we code anything, in order not to waste
> our time.

I think we now all agree that resource management should move into a
place where it can be shared by all pci hotplug drivers, right?

If so, anyone want to propose some common code?  I think the stuff in
the ACPI driver that was pulled from the Compaq driver is a great start.
I can try to pull this into the core myself, but if the Intel developers
have the time, and energy, I would greatly appreciate their help (or
anyone else who wants to join in.)

thanks,

greg k-h
