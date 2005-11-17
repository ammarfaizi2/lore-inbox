Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVKQX1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVKQX1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVKQX1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:27:13 -0500
Received: from fmr22.intel.com ([143.183.121.14]:48519 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964878AbVKQX1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:27:12 -0500
Date: Thu, 17 Nov 2005 15:27:04 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcie_portdrv_probe->Dev has invalid IRQ. Check vendor BIOS (CK804)
Message-ID: <20051117152704.B15853@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <1130868315.2786.5.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1130868315.2786.5.camel@rousalka.dyndns.org>; from nicolas.mailhot@laposte.net on Tue, Nov 01, 2005 at 10:05:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 10:05:14AM -0800, Nicolas Mailhot wrote:
> 
> I've just booted on the last Fedora Devel kernel (2.6.14-1.1635_FC5,
> based on 2.6.14-git2) and my dmesg is now filled with:
> 
> pcie_portdrv_probe->Dev has invalid IRQ. Check vendor BIOS
> 
> messages.
> 
> Should I worry ? Report it somewhere ? Attaching what info ?
> 
I updated the corresponding bugzilla, repeating here for those
not watching bugzilla updates. This turned out to be a bogus
warning. The PCI express bridges on this machine do not
support any capabilities that require an interrupt (hotplug,
advanced error reporting). So, it's ok for the BIOS to not
report interrupt routing for the bridges.

I'll clean up the warning as part of the PCI express work I
expect to start soon.

Rajesh

