Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUBHGCb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 01:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUBHGCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 01:02:31 -0500
Received: from slask.tomt.net ([217.8.136.223]:19584 "EHLO pelle.tomt.net")
	by vger.kernel.org with ESMTP id S262355AbUBHGC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 01:02:29 -0500
Message-ID: <4025D0F2.1020400@tomt.net>
Date: Sun, 08 Feb 2004 07:02:26 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc1
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <4024BCE4.2060600@tomt.net> <200402071722.10242.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402071722.10242.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 07 of February 2004 11:24, Andre Tomt wrote:
>>pdc202xx_old OOPS's on load in case of completely modular IDE (core and
>>pci ide drivers). I have yet to capture the OOPS, as someone has just
>>ran away with the one serial cable over here.
>>
>>If we're lucky Bart knows what's missing without the trace ( :-) ! ). If
>>not, I'll see if I can get netconsole up and running.
> 
> 
> :-(
> 
> Please try to capture this OOPS.

Hmm. Netconsole just hangs my kernel, probably due to me mis-merging it 
into  2.6.3-rc1. So here it is, the pen and paper version :-)

It is somewhat shortened, if you need more information from the oops, 
ask and I'll see what I can do.

Unable to handle kernel virtual paging request at virtual address 24748b24

EIP is at ide_pci_register_host_proc+0x27/0x40 [ide_core]

init_chipset_pdc202xx	[pdc202xx_old]
do_ide_setup_pci_device	[ide_core]
ide_setup_pci_device	[ide_core]
pdc202xx_init_one	[pdc202xx_old]
create_dir
pci_device_probe_static
__pci_device_probe
pci_device_probe
bus_match
driver_attach
bus_add_driver
driver_register
pci_register_driver
ide_pci_register_driver	[ide_core]
pdc202xx_ide_init	[pdc202xx_old]
sys_init_module
syscall_call
