Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSIZOvF>; Thu, 26 Sep 2002 10:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbSIZOvF>; Thu, 26 Sep 2002 10:51:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58890 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261302AbSIZOvE>;
	Thu, 26 Sep 2002 10:51:04 -0400
Date: Thu, 26 Sep 2002 15:56:18 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
Message-ID: <20020926155618.D5179@parcelfarce.linux.theplanet.co.uk>
References: <20020925151943.B25721@parcelfarce.linux.theplanet.co.uk> <3D927278.6040205@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D927278.6040205@snapgear.com>; from gerg@snapgear.com on Thu, Sep 26, 2002 at 12:35:36PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 12:35:36PM +1000, Greg Ungerer wrote:
> BTW, the original this came from is in the kernel tree
> at arch/ppc/8xx_io/fec.c.

Heh.. looks like that driver should move to drivers/net too.

> I don't think this will work. This is not a device that can be
> determined to be present like a PCI device. It is more like an
> ISA device, it needs to be probed to figure out if it is really
> there. I can't see any way not to use Space.c for non-auto-detectable
> type devices... (Offcourse I could be missing something :-)

Sure you can use module_init for non-pci devices... look at 3c501.c and
3c59x.c for examples.

-- 
Revolutions do not require corporate support.
