Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbUKMJXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUKMJXc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 04:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUKMJXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 04:23:32 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:24248 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261535AbUKMJXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 04:23:31 -0500
Date: Sat, 13 Nov 2004 10:22:06 +0100
From: Andi Kleen <ak@suse.de>
To: Michael Chan <mchan@broadcom.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041113092206.GE30778@wotan.suse.de>
References: <B1508D50A0692F42B217C22C02D84972020F3C9E@NT-IRVA-0741.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1508D50A0692F42B217C22C02D84972020F3C9E@NT-IRVA-0741.brcm.ad.broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Intel mmconfig implementation is non-posted which is a valid
> implementation. Therefore readl is unnecessary and can be removed.

If I got the discussion so far correctly then the PCI-SGI spec does not
guarantee that there is no posting, but you know that the chipset
you are using right now doesn't do it. 

The problem with the explanation is that there will be very soon
chipsets not from Intel that also implement PCI-Express. And also
even systems with non Intel CPUs that also do PCI-Express and
mmconfig.

Did you check with other chipset vendors like Nvidia or VIA too? 

I would like us to not fall into the "all world runs a Intel chipset"
trap.

-Andi
