Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280583AbRLDD0b>; Mon, 3 Dec 2001 22:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279818AbRLDDYh>; Mon, 3 Dec 2001 22:24:37 -0500
Received: from S36-149.r1.attbi.com ([12.224.36.149]:41487 "HELO kroah.com")
	by vger.kernel.org with SMTP id <S280510AbRLDDXN>;
	Mon, 3 Dec 2001 22:23:13 -0500
Date: Mon, 3 Dec 2001 19:22:36 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Stodden <stodden@in.tum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pci: dev->driver "runtime" acquisition?
Message-ID: <20011203192236.D18576@kroah.com>
In-Reply-To: <1007400598.6982.2.camel@atbode65>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007400598.6982.2.camel@atbode65>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 06 Nov 2001 01:10:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2001 at 06:29:57PM +0100, Daniel Stodden wrote:
> hi.
> 
> supposing i've got a "hotplug" style pci_driver,

Any hints on what kind of driver this is? :)

> but who's going to gain access to a device _not_ at initialization time,
> i.e. not within pci_register_driver(), but rather somehere in a bottom
> half. no pci_device_id* at pci_register_driver( ), since i don't
> know the signature yet.

Take a look at the pci_read_config_*_nodev() and
pci_write_config_*_nodev() functions in the
drivers/hotplug/pci_hotplug.h file.  Do these functions help you out?

thanks,

greg k-h
