Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVFGFEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVFGFEL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVFGFEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:04:11 -0400
Received: from colo.lackof.org ([198.49.126.79]:46006 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261711AbVFGFDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:03:52 -0400
Date: Mon, 6 Jun 2005 23:07:27 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: greg@kroah.com, linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bodo Eggert <7eggert@gmx.de>, Dipankar Sarma <dipankar@in.ibm.com>,
       Grant Grundler <grundler@parisc-linux.org>, stern@rowland.harvard.edu,
       awilliam@fc.hp.com, bjorn.helgaas@hp.com
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050607050727.GB12781@colo.lackof.org>
References: <1118113637.42a50f65773eb@imap.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118113637.42a50f65773eb@imap.linux.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 11:07:17PM -0400, Vivek Goyal wrote:
>   So even if interrupts are disabled on PCI-PCI bridge, interrupts generated
>   by PCI devices on secondary bus are not blocked and I hope device should
>   be working fine.

How did you plan on disabling interrupts?
Did you see the MSI discussion that going on now in linux-pci mailing list?

> But at the same time kdump kernels are not supposed to
> do a great deal except capture and save the dump.

I'd think you want to stop DMA for all devices.
Just to prevent them from messing more with memory
that you want to dump - ie get a consistent snapshot.
Leaving VGA devices alone should be safe.

> Disabling interrupts at PCI level should increase the reliability of capturing
> the dump on newer machines with hardware compliant with PCI 2.3 or higher. 

*lots* of PCI devices predate PCI2.3. Possibly even the majority.

hth,
grant
