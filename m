Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUCLWza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 17:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUCLWza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 17:55:30 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:47620 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263007AbUCLWz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 17:55:29 -0500
Date: Sat, 13 Mar 2004 01:55:26 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Thomas Steudten <alpha@steudten.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Msg from scsi aic7xxx driver or PCI layer on alpha
Message-ID: <20040313015526.A4021@den.park.msu.ru>
References: <4051DA83.90902@steudten.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <4051DA83.90902@steudten.com>; from alpha@steudten.com on Fri, Mar 12, 2004 at 04:42:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 04:42:59PM +0100, Thomas Steudten wrote:
> I got this messages from the pci allocator and the
> scsi aic7xxx driver on kernel 2.6.4 on alpha after
> reboot: (why is this driver don´t using dma?)

I suspect that you have both "old" and "new" AIC7xxx drivers enabled,
so all sorts of weird things can happen.

> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

This is from "new" driver.

> XXX PCI: Unable to reserve mem region #2:1000@a051000 for device 0000:00:07.0
> aic7xxx: <Adaptec AHA-294X Ultra SCSI host adapter> at PCI 0/7/0
> XXX aic7xxx: I/O ports already in use, ignoring.

And this is from "old" one. Naturally, I/O ports are already reserved
by the "new" driver.

Ivan.
