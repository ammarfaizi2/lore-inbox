Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbSKOSka>; Fri, 15 Nov 2002 13:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266443AbSKOSka>; Fri, 15 Nov 2002 13:40:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11026 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266438AbSKOSk3>;
	Fri, 15 Nov 2002 13:40:29 -0500
Date: Fri, 15 Nov 2002 18:47:25 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Dead & Dying interfaces
Message-ID: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We forgot to remove a lot of crap interfaces during 2.5 development.
Let's start a list now so we don't forget during 2.7.

This list is a combination of interfaces which have gone during 2.5 and
interfaces that should go during 2.7.  Think of it as a `updating your
driver/filesystem to sane code' guide.

sleep_on, sleep_on_timeout, interruptible_sleep_on,
	interruptible_sleep_on_timeout
 -> use wait_event interfaces

flush_page_to_ram
 -> Documentation/cachetlb.txt

cli, sti, save_flags
 -> Documentation/cli-sti-removal.txt

pcibios_*
 -> Documentation/pci.txt

virt_to_bus, bus_to_virt
 -> Documentation/DMA-mapping.txt

check_region
 -> Just use request_region and handle the failure

kmap
 -> Use kmap_atomic instead

task queues
 -> work queues

lock_kernel
 -> spinlocks

smp_processor_id
 -> get_cpu

-- 
Revolutions do not require corporate support.
