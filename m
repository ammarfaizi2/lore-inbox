Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266584AbSKLOSp>; Tue, 12 Nov 2002 09:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266626AbSKLOSp>; Tue, 12 Nov 2002 09:18:45 -0500
Received: from bpdcwm01.bpcl.broadband.hu ([195.184.181.2]:50157 "HELO
	mx01.broadband.hu") by vger.kernel.org with SMTP id <S266584AbSKLOSl>;
	Tue, 12 Nov 2002 09:18:41 -0500
Message-ID: <3DD10F58.5090903@freemail.hu>
Date: Tue, 12 Nov 2002 15:25:28 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.47-mm1 oops
Content-Type: multipart/mixed;
 boundary="------------070806080205090006060201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070806080205090006060201
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I got this booting RedHat 8.0 with a freshly installed Linux-2.5.47-mm1, 
preempt,
4GB highmem+SHAREPTE configured.

All my ifs are RTL8139 complatibles, so I didn't have net...

Anyway, the whole system is very fast! Mozilla comes up under 2 seconds,
OpenOffice.org was similar (but took a little longer) first time, 
quitting and
starting second time was not successful, it stopped at the splash 
screen. Maybe the
"KDE wm does not start" bug is not a KDE wm bug?

Best regards,
Zoltán Böszörményi


--------------070806080205090006060201
Content-Type: text/plain;
 name="dmesg-2.5.47-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.5.47-mm1"

8139too Fast Ethernet driver 0.9.26
Unable to handle kernel paging request at virtual address e08a8014
 printing eip:
c01c3562
*pde = 015ec067
Oops: 0002
8139too mii crc32 ipt_state ipt_MASQUERADE ipt_REDIRECT iptable_nat ip_conntrack iptable_filter ip_tables es1371 soundcore gameport ac97_codec ide-cd sr_mod cdrom scsi_mod  
CPU:    1
EIP:    0060:[<c01c3562>]    Not tainted
EFLAGS: 00010246
EIP is at kobject_register+0xe2/0xf0
eax: e08d9954   ebx: e08d9940   ecx: e08a8014   edx: c03c7754
esi: c03c775c   edi: c03c772c   ebp: 00000000   esp: deaa5ed0
ds: 0068   es: 0068   ss: 0068
Process modprobe (pid: 472, threadinfo=deaa4000 task=df192760)
Stack: c02d83a8 00000042 00000000 e08d9928 e08d7f20 e08d9950 e08d9940 c01f72c7 
       e08d9940 0000000a ffffffea 00000002 00000002 e08d5000 c01c6c3b e08d9928 
       e08d7c2f e08d9900 ffffffea c0124b6f e08d5060 08099740 00004938 e08d8ca4 
Call Trace:
 [<e08d9928>] rtl8139_pci_driver+0x28/0x98 [8139too]
 [<e08d7f20>] .rodata.str1.1+0xf6/0x1b6 [8139too]
 [<e08d9950>] rtl8139_pci_driver+0x50/0x98 [8139too]
 [<e08d9940>] rtl8139_pci_driver+0x40/0x98 [8139too]
 [<c01f72c7>] driver_register+0x67/0xb0
 [<e08d9940>] rtl8139_pci_driver+0x40/0x98 [8139too]
 [<c01c6c3b>] pci_register_driver+0x4b/0x60
 [<e08d9928>] rtl8139_pci_driver+0x28/0x98 [8139too]
 [<e08d7c2f>] rtl8139_init_module+0x1f/0x50 [8139too]
 [<e08d9900>] rtl8139_pci_driver+0x0/0x98 [8139too]
 [<c0124b6f>] sys_init_module+0x4ef/0x640
 [<e08d5060>] __rtl8139_cleanup_dev+0x0/0x120 [8139too]
 [<e08d8ca4>] .kmodtab+0x0/0x18 [8139too]
 [<e08d5060>] __rtl8139_cleanup_dev+0x0/0x120 [8139too]
 [<c01096b3>] syscall_call+0x7/0xb

Code: 89 01 89 7b 1c eb 8a 90 8d b6 00 00 00 00 83 ec 14 89 7c 24 
 <1>Unable to handle kernel paging request at virtual address e08a80a8
 printing eip:
c01c3562
*pde = 015ec067
Oops: 0002
parport_pc lp parport autofs4 8139too mii crc32 ipt_state ipt_MASQUERADE ipt_REDIRECT iptable_nat ip_conntrack iptable_filter ip_tables es1371 soundcore gameport ac97_codec ide-cd sr_mod cdrom scsi_mod  
CPU:    1
EIP:    0060:[<c01c3562>]    Not tainted
EFLAGS: 00010246
EIP is at kobject_register+0xe2/0xf0
eax: e08f60a8   ebx: e08f6094   ecx: e08a80a8   edx: c03d2ef4
esi: c03d2efc   edi: c03d2ecc   ebp: 00000000   esp: de063e8c
ds: 0068   es: 0068   ss: 0068
Process modprobe (pid: 738, threadinfo=de062000 task=deb18660)
Stack: c02d83a8 00000042 00000000 e08f607c e08f3c86 e08f60a4 e08f6094 c01f72c7 
       e08f6094 c14b0708 e08f6060 e08f6160 e08f6200 e08f61c0 c024690e e08f607c 
       e08f6100 e08f2293 e08f6060 c0146975 c03c2380 00000000 000001d0 00000000 
Call Trace:
 [<e08f607c>] parport_pc_pnp_driver+0x1c/0xa0 [parport_pc]
 [<e08f3c86>] .rodata.str1.1+0x3c3/0x3dd [parport_pc]
 [<e08f60a4>] parport_pc_pnp_driver+0x44/0xa0 [parport_pc]
 [<e08f6094>] parport_pc_pnp_driver+0x34/0xa0 [parport_pc]
 [<c01f72c7>] driver_register+0x67/0xb0
 [<e08f6094>] parport_pc_pnp_driver+0x34/0xa0 [parport_pc]
 [<e08f6060>] parport_pc_pnp_driver+0x0/0xa0 [parport_pc]
 [<e08f6160>] io_hi+0x0/0x60 [parport_pc]
 [<e08f6200>] irqval+0x0/0x40 [parport_pc]
 [<e08f61c0>] dmaval+0x0/0x40 [parport_pc]
 [<c024690e>] pnp_register_driver+0x2e/0x70
 [<e08f607c>] parport_pc_pnp_driver+0x1c/0xa0 [parport_pc]
 [<e08f6100>] io+0x0/0x60 [parport_pc]
 [<e08f2293>] parport_pc_init+0x33/0xf0 [parport_pc]
 [<e08f6060>] parport_pc_pnp_driver+0x0/0xa0 [parport_pc]
 [<c0146975>] __alloc_pages+0x95/0x2b0
 [<e08f23c1>] init_module+0x71/0x180 [parport_pc]
 [<e08f6100>] io+0x0/0x60 [parport_pc]
 [<e08f6160>] io_hi+0x0/0x60 [parport_pc]
 [<e08f6200>] irqval+0x0/0x40 [parport_pc]
 [<e08f61c0>] dmaval+0x0/0x40 [parport_pc]
 [<c0124b6f>] sys_init_module+0x4ef/0x640
 [<e08ee060>] parport_pc_find_nonpci_ports+0x0/0x10 [parport_pc]
 [<e08f3f38>] .kmodtab+0x0/0xc [parport_pc]
 [<e08ee060>] parport_pc_find_nonpci_ports+0x0/0x10 [parport_pc]
 [<c01096b3>] syscall_call+0x7/0xb

Code: 89 01 89 7b 1c eb 8a 90 8d b6 00 00 00 00 83 ec 14 89 7c 24 
 <6>lp: driver loaded but no devices found

--------------070806080205090006060201--

