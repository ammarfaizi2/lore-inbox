Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVI2HEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVI2HEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVI2HEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:04:36 -0400
Received: from web31609.mail.mud.yahoo.com ([68.142.198.155]:5292 "HELO
	web31609.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932108AbVI2HEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:04:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hTg6+0+mJbGz6e30JqapGpk9ba3Eiij6jYZoDAy+xVwNfxr/SYSbvy1ZLqzv2LyDFZlbOGNo/maiI4/64vHoO6xanRDc0m9O5GiizzjYomVApcoeBcIgUgg0ncbD0kTVIccse/7s/SzlUnXLcGMdozPbXItVaB2qd1RyaFqKjJc=  ;
Message-ID: <20050929070428.14769.qmail@web31609.mail.mud.yahoo.com>
Date: Thu, 29 Sep 2005 00:04:28 -0700 (PDT)
From: fil fil <grossebaf@yahoo.com>
Subject: kernel BUG at kernel/workqueue.c
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sep 27 17:08:38 je kernel: ------------[ cut here
]------------
Sep 27 17:08:38 je kernel: kernel BUG at
kernel/workqueue.c:311!
Sep 27 17:08:38 je kernel: invalid operand: 0000 [#1]
Sep 27 17:08:38 je kernel: SMP
Sep 27 17:08:38 je kernel: Modules linked in: lpfc md5
ipv6 parport_pc lp
parport autofs4 i2c_dev i2c_core sunrpc ipt_REJECT 
ipt_state ip_conntrack
iptable_filter ip_tables dm_mod video button battery
ac uhci_hcd ehci_hcd
hw_random tg3 floppy ext3 jbd scsi_transport_fc cciss
sd_mod scsi_mod
Sep 27 17:08:38 je kernel: CPU:    3
Sep 27 17:08:38 je kernel: EIP:    0060:[<c012fa16>]  
 Not tainted VLI
Sep 27 17:08:38 je kernel: EFLAGS: 00010202  
(2.6.12-Test_LPFC)
Sep 27 17:08:38 je kernel: EIP is at
__create_workqueue+0x193/0x1a0
Sep 27 17:08:38 je kernel: eax: 00000000   ebx:
f5a6b0c9   ecx: 0000000b
edx: 00000001
Sep 27 17:08:38 je kernel: esi: f5a6b0c9   edi:
f5a6b0d5   ebp: 00000000
esp: f5ffde78
Sep 27 17:08:38 je kernel: ds: 007b   es: 007b   ss:
0068
Sep 27 17:08:38 je kernel: Process modprobe (pid:
24185, threadinfo=f5ffd000
task=f7372020)
Sep 27 17:08:38 je kernel: Stack: f5a6b000 00000001
f5a6b0c9 f5a6b000 00000000
f5a6b100 f883f3da f5a6b0c9
Sep 27 17:08:38 je kernel:        00000014 f884960c
00000064 f5a6b1b4 f58b1a80
00000000 f7f7dc44 f5a6b220
Sep 27 17:08:38 je kernel:        f88a7fc1 f88a2698
f5a6b220 f88aed30 00000000
00000000 000008ca 00000001
Sep 27 17:08:38 je kernel: Call Trace:
Sep 27 17:08:38 je kernel:  [<f883f3da>]
scsi_add_host+0x14b/0x1cf [scsi_mod]
Sep 27 17:08:38 je kernel:  [<f88a7fc1>]
lpfc_pci_probe_one+0x677/0x989 [lpfc]
Sep 27 17:08:38 je kernel:  [<f88a2698>]
lpfc_do_work+0x0/0x12b [lpfc]
Sep 27 17:08:38 je kernel:  [<c01c4f52>]
kobject_hotplug+0x25a/0x28d
Sep 27 17:08:38 je kernel:  [<c01cf2e8>]
pci_device_probe_static+0x30/0x43
Sep 27 17:08:38 je kernel:  [<c01cf31d>]
__pci_device_probe+0x22/0x33
Sep 27 17:08:38 je kernel:  [<c01cf349>]
pci_device_probe+0x1b/0x32
Sep 27 17:08:38 je kernel:  [<c022e110>]
driver_probe_device+0x21/0x55
Sep 27 17:08:38 je kernel:  [<c022e21c>]
driver_attach+0x46/0x85
Sep 27 17:08:38 je kernel:  [<c01c46df>]
kobject_register+0x2e/0x59
Sep 27 17:08:38 je kernel:  [<c022e632>]
bus_add_driver+0x88/0xb6
Sep 27 17:08:38 je kernel:  [<c01cf51f>]
pci_register_driver+0x79/0x90
Sep 27 17:08:38 je kernel:  [<f8818032>]
lpfc_init+0x32/0x4d [lpfc]
Sep 27 17:08:38 je kernel:  [<c0139947>]
sys_init_module+0x153/0x204
Sep 27 17:08:38 je kernel:  [<c0103e0b>]
sysenter_past_esp+0x54/0x75
Sep 27 17:08:38 je kernel: Code: 00 00 83 f8 05 0f 4d
c2 83 f8 03 89 c6 7e c7
85 ed 0f 84 09 ff ff ff 8b 04 24 e8 4b 00 00 0 0 c7 04
24 00 00 00 00 e9 f5 fe
ff ff <0f> 0b 37 01 fc 87 30 c0 e9 86 fe ff ff c1 e2
07 56 53 8d 1c 02



	
		
______________________________________________________ 
Yahoo! for Good 
Donate to the Hurricane Katrina relief effort. 
http://store.yahoo.com/redcross-donate3/ 

