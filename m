Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbTCJV7H>; Mon, 10 Mar 2003 16:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbTCJV7H>; Mon, 10 Mar 2003 16:59:07 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:2033 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S261491AbTCJV7F>; Mon, 10 Mar 2003 16:59:05 -0500
Message-ID: <3E6D0D25.26B5584F@attbi.com>
Date: Mon, 10 Mar 2003 17:09:41 -0500
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.64 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] driver core support for i2c bus and drivers
References: <20030310072337.GJ6512@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> Hi all,
> 
> Here's a fairly small patch against 2.5.64 that adds initial driver core
> support for the i2c code.  It only has logic for the i2c bus, i2c bus
> controllers, and i2c drivers, but it's a start :)
> 
> As an example, with this patch, the i2c-piix4 driver shows up in the pci
> bus as (other devices omitted for clarity):
> 
> [greg@desk sys]$ tree bus/pci
> bus/pci/
> |-- devices
> |   |-- 00:07.3 -> ../../../devices/pci0/00:07.3
> `-- drivers
>     |-- piix4 smbus
>     |   `-- 00:07.3 -> ../../../../devices/pci0/00:07.3
> 
> And within that device, the first i2c bus is located:
> 
> [greg@desk sys]$ tree devices/pci0/00:07.3
> devices/pci0/00:07.3
> |-- i2c-0
> |   |-- name
> |   `-- power
> 
> And the i2c bus looks like:
> 
> [greg@desk sys]$ tree bus/i2c/
> bus/i2c/
> |-- devices
> `-- drivers
>     `-- EEPROM READER
> 
> I'll move on to adding i2c device support to the core, but that will be
> a bit more work.  Comments on this patch are appreciated.
> 
> thanks,
> 
> greg k-h
> 
> p.s. Yes, I added the i2c-piix4 and i2c-ali15x3 and i2c-i801 drivers to
> my kernel tree, from the i2c CVS tree, and tweaked them to actually work
> properly.  If someone wants those patches right now, please let me know.
> 
I like.  The proc/bus directory was geting cluttered.
I think the driver model would be a good for i2c/sensors.
Do you have any input for isa already in your bag of
goodies?
Albert

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@attbi.com
