Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSFXSc2>; Mon, 24 Jun 2002 14:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSFXSc1>; Mon, 24 Jun 2002 14:32:27 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:53003 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314748AbSFXScZ>; Mon, 24 Jun 2002 14:32:25 -0400
Date: Mon, 24 Jun 2002 20:32:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'David Brownell'" <david-b@pacbell.net>,
       "'Nick Bellinger'" <nickb@attheoffice.org>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: RE: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map
 )
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7F53@orsmsx111.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0206242017140.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Jun 2002, Grover, Andrew wrote:

> With technologies like USB, infiniband, NFS, iSCSI, and 1394, it's tough,
> but the main question should be:
>
> "If my computer suspends, should this device be turned off?" Which is
> another way of asking is the use of a device exclusive to a particular
> machine.
>
> If a device can be accessed by multiple machines concurrently, it should not
> be in driverfs.

I don't think it's that easy. If the computer wakes up again, devices have
to be reinitialised in the right order, e.g. iSCSI needs a working network
stack and devices. Another problem is how to properly shutdown the
machine. Scripts now "know" that nfs requires the network, but how does
the script find out, that /dev/sdb2 is an iSCSI device, so that it can
properly unmount the device, before the network is shutdown?

bye, Roman

