Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbUCJTE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbUCJTE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:04:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:33238 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262773AbUCJTE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:04:26 -0500
Date: Wed, 10 Mar 2004 10:57:11 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Davis, Todd C" <todd.c.davis@intel.com>
Subject: Re: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-ID: <20040310185711.GA18892@kroah.com>
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de> <404F3BC3.2090906@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404F3BC3.2090906@acm.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 10:01:07AM -0600, Corey Minyard wrote:
> You need to run off the panic events, the config flag IPMI_PANIC_EVENT, 
> and it should compile fine.  This is a flag that causes the driver to 
> put some information about the panic into an event log in the IPMI 
> controller so it can be fetched later.
> 
> To do this, the driver needs a way to run each operation to completion 
> without scheduling, interrupts. or the like.  It needs this to do send 
> the panic event (since you cannot schedule during a panic), although it 
> also really needs it to do things like extend the watchdog timer time at 
> panic time.  The I2C driver does not currently have this, so it doesn't 
> work with this option and the SMBus driver.
> 
> I have included a patch from Todd Davis at Intel that adds this function 
> to the I2C driver.  I believe Todd has been working on getting this in 
> through the I2C driver writers, although the patch is fairly non-intrusive.

All I've seen are some 2.4 patches, no 2.6 patches.

Anyone care to send them to the i2c maintainers?

thanks,

greg k-h
