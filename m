Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbUBIUKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbUBIUKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:10:55 -0500
Received: from main.gmane.org ([80.91.224.249]:60323 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265406AbUBIUKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:10:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Karl Vogel" <karl.vogel@seagha.com>
Subject: Re: 2.6.3-rc1-mm1
Date: Mon, 9 Feb 2004 20:02:20 +0000 (UTC)
Message-ID: <slrnc2fpqc.2k0.kvo--gm@kvo.local.org>
References: <20040209014035.251b26d1.akpm@osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: d51a50695.kabel.telenet.be
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040209014035.251b26d1.akpm@osdl.org>, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2.6.3-rc1-mm1/
> 

---- kernel log ---
SCSI subsystem initialized
request_module: failed /sbin/modprobe -- char-major-21-1. error = 256
ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[dffff000-dffff7ff]  Max Packet=[2048]
kudzu: numerical sysctl 1 49 is obsolete.
kudzu: numerical sysctl 1 49 is obsolete.
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0010b9f7007a8edf]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[00023c003000f0f2]
Badness in kobject_get at lib/kobject.c:431
Call Trace:
 [<c01e5114>] kobject_get+0x44/0x50
 [<c022bd7e>] get_device+0xe/0x20
 [<c022cb4e>] bus_for_each_dev+0x4e/0xa0
 [<e0ae5c60>] nodemgr_host_thread+0x200/0xe30 [ieee1394]
 [<e0ae59d0>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
 [<c031ed32>] ret_from_fork+0x6/0x14
 [<e0ae5a60>] nodemgr_host_thread+0x0/0xe30 [ieee1394]
 [<c01085f5>] kernel_thread_helper+0x5/0x10

Unable to handle kernel paging request at virtual address 852cec83
 printing eip:
852cec83
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<852cec83>]    Not tainted VLI
EFLAGS: 00010282
EIP is at 0x852cec83
eax: e0b14b84   ebx: e0b14b84   ecx: e0b14b60   edx: 852cec83
esi: e0ae5720   edi: 00000000   ebp: e0ae4980   esp: df42becc
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 354, threadinfo=df42a000 task=df42d7c0)
Stack: c01e52b7 e0b14b60 e0b14b68 e0b14ac0 df311044 c022cb63 e0b14b0c 00000000 
       df42bf9c df311000 00000000 0000ffc1 de9e4970 e0ae5c60 e0ae59d0 f0000420 
       0000ffff df42bf98 000003ff 3000f0f2 00023c00 00000008 de9e4958 df42a000 
Call Trace:
 [<c01e52b7>] kobject_cleanup+0x97/0xa0
 [<c022cb63>] bus_for_each_dev+0x63/0xa0
 [<e0ae5c60>] nodemgr_host_thread+0x200/0xe30 [ieee1394]
 [<e0ae59d0>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
 [<c031ed32>] ret_from_fork+0x6/0x14
 [<e0ae5a60>] nodemgr_host_thread+0x0/0xe30 [ieee1394]
 [<c01085f5>] kernel_thread_helper+0x5/0x10

Code:  Bad EIP value.
 <6>sbp2: $Rev: 1096 $ Ben Collins <bcollins@debian.org>
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 10Mbps, half-duplex, lpa 0x0000

--- IEEE1394 .config settings ---
CONFIG_IEEE1394=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

Tried both with and without CONFIG_PREEMPT. The IEEE1394 is the onboard
controller of a Creative Labs Audigy I (if that matters). The attached
device is a Maxtor OneTouch diskdrive.

/sys/bus/ieee1394 looks like:
