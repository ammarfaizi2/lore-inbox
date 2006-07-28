Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWG1Xjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWG1Xjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWG1Xjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:39:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54693 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161374AbWG1Xjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:39:52 -0400
Date: Fri, 28 Jul 2006 19:39:50 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: via sata oops on init
Message-ID: <20060728233950.GD3217@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-rc2-git6

BUG: unable to handle kernel NULL pointer dereference at 00000000
EIP is at make_class_name+0x27
eax: 00000000 ebx: ffffffff ecx: ffffffff edx: 00000009
esi: f8d16cc2 edi: 00000000 ebp: f7fa9d3c esp: f7fa9d2c

Call Trace:
class_device_del+0xac
class_device_unregister
scsi_remove_host
ata_host_remove
ata_device_add
svia_init_one
pci_device_probe
driver_probe_device
__driver_attach
bus_for_each_dev
driver_attach
bus_add_driver
driver_register
__pci_register_driver
svia_init
sys_init_module
syscall_call


		Dave

-- 
http://www.codemonkey.org.uk
