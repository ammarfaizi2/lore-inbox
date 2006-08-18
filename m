Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWHRI7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWHRI7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWHRI7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:59:00 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:14726 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751303AbWHRI65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:58:57 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 18 Aug 2006 09:58:36 +0100 (BST)
From: Matthew Johnson <matt@matthew.ath.cx>
X-X-Sender: mjj29@illythia.matthew.ath.cx
Reply-To: Matthew Johnson <matt@matthew.ath.cx>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: Len Brown <lenb@kernel.org>, Matthew Johnson <matt@matthew.ath.cx>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: IRQ Mis-matches in 2.6.17.7
In-Reply-To: <200608111005.59434.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.63.0608180957130.15208@illythia.matthew.ath.cx>
References: <Pine.LNX.4.63.0608110945510.15208@illythia.matthew.ath.cx>
 <200608111144.36751.len.brown@intel.com> <200608111005.59434.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006, Bjorn Helgaas wrote:

> Is this problem new with 2.6.17.7?  On the face of it, it looks
> like every kernel should have this problem if you have other
> devices on IRQ 4.

It's a recent problem, certainly.

> Other devices (ehci_hcd:usb1  eth0  ohci1394) are already using
> IRQ 4.  lirc_serial doesn't request a shared IRQ unless you use
> the "share_irq" module parameter.  A request for exclusive use
> of IRQ 4 will fail if it's already in use.  So I suspect that if
> you use the "share_irq" parameter, it will work.

This stops the errors coming up, I just get no data afaict. I'll spend
some more time trying to diagnose the problem.

Thanks,

Matt

-- 
Matthew Johnson
http://www.matthew.ath.cx/
