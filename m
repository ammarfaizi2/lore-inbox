Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265079AbUFAOWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbUFAOWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265058AbUFAOV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:21:59 -0400
Received: from havoc.gtf.org ([216.162.42.101]:58518 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265080AbUFAOVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:21:43 -0400
Date: Tue, 1 Jun 2004 10:21:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
Message-ID: <20040601142122.GA7537@havoc.gtf.org>
References: <40BC788A.3020103@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BC788A.3020103@shadowconnect.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 02:37:30PM +0200, Markus Lidel wrote:
> Hello,
> 
> could someone help me with a ioremap problem. If there are two 
> controllers plugged in, the ioremap request for the first controller is 
> successfull, but the second returns NULL. Here is the output of the driver:
> 
> i2o: Checking for PCI I2O controllers...
> i2o: I2O controller on bus 0 at 72.
> i2o: PCI I2O controller at 0xD0000000 size=134217728
> I2O: MTRR workaround for Intel i960 processor
> i2o/iop0: Installed at IRQ17
> i2o: I2O controller on bus 0 at 96.
> i2o: PCI I2O controller at 0xD8000000 size=134217728
> i2o: Unable to map controller.

If "size=xxxx" indicates the size you are remapping, then that's
probably too large an area to be remapping.  Try remapping only the
memory area needed, and not the entire area.

	Jeff



