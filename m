Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbTDRCfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 22:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTDRCfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 22:35:14 -0400
Received: from ip68-6-164-6.sd.sd.cox.net ([68.6.164.6]:54227 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP id S262764AbTDRCfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 22:35:13 -0400
Date: Thu, 17 Apr 2003 19:47:09 -0700
From: Marc Wilson <msw@cox.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine dirve in 2.4.21-pre7
Message-ID: <20030418024709.GD14527@moonkingdom.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1049706637.963.6.camel@athlon> <1050602030.988.4.camel@athlon> <20030417175924.GE25696@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417175924.GE25696@gtf.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 01:59:24PM -0400, Jeff Garzik wrote:
> Until further notice, please do not attempt to use Via IOAPIC support.
> This has nothing to do with via-rhine, and remains an open issue.

I thought I'd read everything about the Rhine and Via in my lurking on
lkml, but I must have missed something.  This box here is an Abit KD7-RAID
(Via KT400 + Rhine II) and I have IOAPIC enabled and am using Roger's latest
driver with 2.4.21-pre6 with great success.

rei $ uname -a
Linux rei 2.4.21-pre6-preempt #1 Mon Mar 31 17:05:40 PST 2003 i686 unknown unknown GNU/Linux

rei $ cat /var/log/dmesg | egrep -i "via|rhine"
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
PCI: Via IRQ fixup for 00:10.0, from 10 to 5
PCI: Via IRQ fixup for 00:10.2, from 11 to 5
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
agpgart: Detected Via Apollo Pro KT400 chipset
via-rhine.c:v1.10-LK1.1.17  March-1-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xd800, 00:50:8d:45:af:b7, IRQ 23.

rei $ grep APIC /usr/src/linux/.config
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

What am I missing here?  It sounds like it's dangerous to use, but it
doesn't look like it's broken.

-- 
 Marc Wilson |     One big pile is better than two little piles.  --
 msw@cox.net |     Arlo Guthrie
