Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVFPOBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVFPOBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 10:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVFPOBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 10:01:03 -0400
Received: from pc1.pod.cz ([213.155.230.51]:46050 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id S261606AbVFPOA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 10:00:58 -0400
Date: Thu, 16 Jun 2005 16:00:57 +0200
From: Vitezslav Samel <samel@mail.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: hpet patches
Message-ID: <20050616140057.GA20965@pc11.op.pod.cz>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <88056F38E9E48644A0F562A38C64FB6004FB6BED@scsmsx403.amr.corp.intel.com> <9e47339105061510547ea7d2f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105061510547ea7d2f0@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 01:54:16PM -0400, Jon Smirl wrote:
> On 6/15/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
> > The specification for ICH5 has the details about this address
> > http://www.intel.com/design/chipsets/datashts/25251601.pdf (Chapter 17).
> > We need to look at specific device address to figure out the HPET base
> > address in this case.
> 
> The ICH5 fix up needs to look something like this:
> PCI_DEVICE_ID_INTEL_82801EB_0 is the PCI ID for the LPC device.
> 
> ACPI_FIXUP(INTEL, PCI_DEVICE_ID_INTEL_82801EB_0, hpet_ich5_fixup)
> hpet_ich5_fixup()
> {
>      pci_bios_find_device(PCI_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0, ...)
>      pci_bios_read(device, GENERAL_CONTROL_REGISTER, ..)
>      Check bit 17 and see if it is enabled
>      use bit 15:16 to set hpet_address to one of the four addresses
> }
> 
> It would be more complicated to try and turn it on if it is turned
> off. Mine is turned on at boot even though it has no ACPI entry.

  On our HP DL380g4 (ICH5 chipset) it is turned off. Could you, please,
try to turn it on in your patches? I'll be glad to test your patches.

	Thanks,
		Vita
