Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263924AbTDWAqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 20:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTDWAqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 20:46:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64142 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263924AbTDWAqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 20:46:06 -0400
Date: Tue, 22 Apr 2003 17:59:43 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       hannal@us.ibm.com, andmike@us.ibm.com
Subject: Re: [RFC] Device class rework [0/5]
Message-ID: <172940000.1051059583@w-hlinder>
In-Reply-To: <20030422205545.GA4701@kroah.com>
References: <20030422205545.GA4701@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, April 22, 2003 01:55:45 PM -0700 Greg KH <greg@kroah.com> wrote:

> Hi,
> 
> Here's a set of patches that rework the current class support in the
> kernel today into something that works a bit better, and is simpler to
> use.

Greg,

I did a quick sanity test of these patches on a 2-way PIII.
It built and booted fine for me. I don't have any devices that 
span multiple classes but the patch hasnt changed any of my 
existing /sys/class output.

Hanna
---

[root@w-hlinder2 root]# tree /sys/class
/sys/class
|-- cpu
|   |-- devices
|   |   |-- 0 -> ../../../devices/sys/cpu0
|   |   `-- 1 -> ../../../devices/sys/cpu1
|   `-- drivers
|       `-- system:cpu -> ../../../bus/system/drivers/cpu
|-- input
|   |-- devices
|   |   |-- 0 -> ../../../devices/pci0/00:0f.2/usb1/1-1/1-1.1/1-1.1:0
|   |   |-- 1 -> ../../../devices/pci0/00:0f.2/usb1/1-1/1-1.1/1-1.1:1
|   |   `-- 2 -> ../../../devices/pci0/00:0f.2/usb1/1-1/1-1.2/1-1.2:0
|   |-- drivers
|   |   `-- usb:hid -> ../../../bus/usb/drivers/hid
|   `-- mouse
|-- pcmcia_socket
|   |-- devices
|   |-- drivers
|   `-- pcmcia-bus
|-- scsi-host
|   |-- devices
|   `-- drivers
`-- tty
    |-- devices
    `-- drivers
        `-- pci:serial -> ../../../bus/pci/drivers/serial

25 directories, 0 files



