Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTHTQO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbTHTQO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:14:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:12732 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262041AbTHTQO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:14:57 -0400
Date: Wed, 20 Aug 2003 08:55:31 -0700
From: Greg KH <greg@kroah.com>
To: ckbb ckbb <ckbroadbus@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB device not accepting new address=2 (error=-19)
Message-ID: <20030820155531.GB1354@kroah.com>
References: <BAY1-F130ok1Bkfkll10000c83b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-F130ok1Bkfkll10000c83b@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 10:01:20AM -0400, ckbb ckbb wrote:
> yes it is coustomised board and ISP1161A host controller is connected to a 
> fpga device which is on the PCI bus. Infact it is one of the general 
> purpose io (gpio-23) to which usb interrupt line is connected and gpio is 
> programmed as an interrupt. I am getting the 'sof' interrupt continuously 
> (at every 1msec) and I can see the corresponding interrupt count in 
> /proc/interrupts is incrementing accordingly.
> 
> Regarding hc 1161a, I have been told by phillips factory people that the 
> driver is working fine with the x86 platform. I did a port to the powerpc 
> platform.

Then I would suggest looking at that driver, for that is where the data
comes back from the usb device to.  And it looks like no data is being
received properly.

Good luck,

greg k-h
