Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSFYSXz>; Tue, 25 Jun 2002 14:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSFYSXy>; Tue, 25 Jun 2002 14:23:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7324 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315167AbSFYSXx>;
	Tue, 25 Jun 2002 14:23:53 -0400
Date: Tue, 25 Jun 2002 11:18:46 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Nick Bellinger'" <nickb@attheoffice.org>,
       David Brownell <david-b@pacbell.net>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map)
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7F52@orsmsx111.jf.intel.com>
Message-ID: <Pine.LNX.4.33.0206251115340.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is the device PHYSICALLY hooked up to the computer? If not, it shouldn't be
> in devicefs.

But, it should be in driverfs. I'll let the devicefs people decide what to 
do ;)

> The device tree (for which devicefs is the fs representation) was originally
> meant to enable good device power management and configuration. driverfs
> wasn't meant to handle iscsi or tcpip (that is, network) connections, nor
> should it have to.

Both statements are entirely true. driverfs doesn't care about device
types. The only thing the filesystem does is export the kernel data
structures and the relationships between them.

But, those devices are physical devices that the kernel is communicating 
with. Which is exactly what the device tree was designed to do.

	-pat

