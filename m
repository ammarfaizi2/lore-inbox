Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSFYSSW>; Tue, 25 Jun 2002 14:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSFYSSV>; Tue, 25 Jun 2002 14:18:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6300 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S314514AbSFYSSV>;
	Tue, 25 Jun 2002 14:18:21 -0400
Date: Tue, 25 Jun 2002 11:13:15 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Douglas Gilbert <dougg@torque.net>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <3D14D301.F2C8DBBE@torque.net>
Message-ID: <Pine.LNX.4.33.0206250949300.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So the "target id" we put in driverfs could have one of
> these suggested formats:
>    <number>              - 0 to 1 for ATA
>    <number>              - 0 to 15 for SCSI parallel interface
>    <number>              - 24 bit number for fibre channel
>    <EUI 64+discovery_id> - ieee1394
>    <???>                 - usb (mass storage + scanner)
>    <WWUI> ":" <num>      - iSCSI   [something better than ":"?]

In the physical device tree, what's wrong with setting the name to 
something simple, like 'iscsi0', etc. All you're looking for is 
a locally unique ID. 

You need a globally unique ID to do persitant attribute setting and 
restoration, including naming. When /sinb/hotplug gets a call to name the 
device, it can look up the GUID to determine what to name the device.

	-pat

