Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTEMD2C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 23:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTEMD2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 23:28:02 -0400
Received: from granite.he.net ([216.218.226.66]:46860 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261860AbTEMD2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 23:28:01 -0400
Date: Mon, 12 May 2003 20:41:47 -0700
From: Greg KH <greg@kroah.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: re-scanning the PCI bus after boot for configurable device...
Message-ID: <20030513034147.GA5938@kroah.com>
References: <Pine.LNX.4.53.0305130225240.20908@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305130225240.20908@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 02:29:33AM +0100, Dave Airlie wrote:
> 
> hi,
> 	I've got a PCI card that has an FPGA on it which I want to program
> at run time, and then load a device driver for depending on what I've
> loaded in to the FPGA,
> 
> The FPGA is downloaded via JTAG so that is all fine, but if I boot Linux,
> download over the JTAG, how can I get Linux to see the device? can I use
> the hotplugging support or do I still need to do more work? I know the
> hotplug allows for PCMCIA and CompactPCI to add devices after boot, but
> this is plain PCI but the device won't be there until the system is
> running,

I've posted a driver to the linux-hotplug-devel mailing list a year or
so ago that might help you out with this.  On module load it rescans the
PCI address space, adding or removind devices that are new or now gone.
This will probably do what you want.

I didn't write the driver, and it's probably very out of date by now,
but it's something for you to start with if you are interested.

Good luck,

greg k-h
