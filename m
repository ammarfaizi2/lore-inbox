Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTGAIaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 04:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTGAIaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 04:30:02 -0400
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:48881 "EHLO
	imf21aec.bellsouth.net") by vger.kernel.org with ESMTP
	id S261249AbTGAI37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 04:29:59 -0400
Message-ID: <3F012202.4010303@bellsouth.net>
Date: Tue, 01 Jul 2003 01:54:10 -0400
From: CarlosRomero <caberome@bellsouth.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3) Gecko/20030322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: simple pnp bios io resources bug makes  system unusable
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my one line patch just skips an io registration with a simple sanity check.
never once have i heard a device with an ioport of 0x0.
question is why it happens and only once.
tested with

ISA Plug and Play:
U.S. Robotics Sportster 33600 FAX/Voice Int
Creative ViBRA16C PnP
Crystal Codec

Host/PCI Bridge:
VIA Technologies, In VT82C585VP [Apollo V
VIA Technologies, In VT82C586/A/B PCI-to-
VIA Technologies, In VT82C586/B/686A/B PI
VIA Technologies, In USB
VIA Technologies, In VT82C586B ACPI

(also noticing cutoff in /sys/devices/pci0/*/name)

>Yes, I also ran into this problem, Adam is was also working on a fix
>although I wonder if it's the same fix?

>Shawn S.

>>List:     linux-kernel
>>Subject:  simple pnp bios io resources bug makes  system unusable
>>From:     CarlosRomero <caberome () bellsouth ! net>
>>Date:     2003-07-01 3:38:17

>>cat /sys/devices/pnp0/00\:0c/name
>>Reserved Motherboard Resources

>>cat /sys/devices/pnp0/00\:0c/resources
>>state = active
>>io 0x4d0-0x4d1
>>io 0xcf8-0xcff
>>io 0x3f7-0x3f7
>>io 0x401-0x407
>>io 0x298-0x298
>>io 0x00000000-0xffffffff
>>mem 0xfffe0000-0xffffffff
>>mem 0x100000-0x7ffffff

>>fixup: check for null io base, other devices are now able to initialize.


