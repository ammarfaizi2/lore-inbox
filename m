Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSFXSr7>; Mon, 24 Jun 2002 14:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSFXSr6>; Mon, 24 Jun 2002 14:47:58 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:51670 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S314787AbSFXSr5>; Mon, 24 Jun 2002 14:47:57 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7F56@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Roman Zippel'" <zippel@linux-m68k.org>
Cc: "'David Brownell'" <david-b@pacbell.net>,
       "'Nick Bellinger'" <nickb@attheoffice.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: RE: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map
	 )
Date: Mon, 24 Jun 2002 11:47:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Roman Zippel [mailto:zippel@linux-m68k.org] 
> On Mon, 24 Jun 2002, Grover, Andrew wrote:
> > If a device can be accessed by multiple machines 
> concurrently, it should not
> > be in driverfs.
> 
> I don't think it's that easy. If the computer wakes up again, 
> devices have
> to be reinitialised in the right order, e.g. iSCSI needs a 
> working network
> stack and devices.

Would the iSCSI device be a child of the network device? That would ensure
that the NIC was fully restarted before the iSCSI device.

> Another problem is how to properly shutdown the
> machine. Scripts now "know" that nfs requires the network, 
> but how does
> the script find out, that /dev/sdb2 is an iSCSI device, so that it can
> properly unmount the device, before the network is shutdown?

Would a bottom-up traversal of the device tree do things properly?

Regards -- Andy
