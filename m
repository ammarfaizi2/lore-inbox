Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWFGDEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWFGDEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWFGDEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:04:01 -0400
Received: from peabody.ximian.com ([130.57.169.10]:65171 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750768AbWFGDEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:04:01 -0400
Subject: Re: [PATCH 8/9] PCI PM: clear IO and MEM when disabling a device
From: Adam Belay <abelay@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1149553936.559.6.camel@localhost.localdomain>
References: <1149497176.7831.162.camel@localhost.localdomain>
	 <1149553936.559.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 23:16:36 -0400
Message-Id: <1149650196.7831.229.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 10:32 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2006-06-05 at 04:46 -0400, Adam Belay wrote:
> > This patch modifies pci_disable_device() to clear IO and MEM from the
> > COMMAND PCI config register.  This is required before entering D3,  but
> > also probably a good general practice for system suspend.
> 
> And will break a great deal of platforms. Don't do it :) The problem is,
> I think, mostly related to firmware issues.
> 
> Ben.

If the device must be enabled before passing control to firmware, then
shouldn't its controlling driver never call pci_disable_device()?  I'd
like to have pci_disable_device() actually disable devices, as this is
needed for D3.

Thanks,
Adam


