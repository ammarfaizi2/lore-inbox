Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272011AbTHDRVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272008AbTHDRVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:21:42 -0400
Received: from mx2.undergrid.net ([64.174.245.170]:54687 "EHLO
	mail.undergrid.net") by vger.kernel.org with ESMTP id S272045AbTHDRTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:19:45 -0400
From: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>
Date: Mon, 4 Aug 2003 10:18:59 -0700
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Problem with wireless PCMCIA card insertion on 2.6.0-test2
Message-ID: <20030804171858.GA3215@UnderGrid.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Please find attached further information regarding the
specifics of this problem. Basically since upgrading from 2.4.21 to
2.6.0-test2 the use of my PCMCIA wireless card (Cisco Aironet 350) has
been non-existent as it locks up the laptop. The only recourse is total
cold-boot power cycling without the PCMCIA card inserted.

	Please Cc me as I am not subscribe to the ML as I'm already on
enough high volume lists.

	Regards,
	Jeremy T. Bouse

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lkml-bugreport.txt"
Content-Transfer-Encoding: quoted-printable

[1.]
Problem with Wireless PCMCIA card insertion.

[2.]
Sony Vaio PCG-C1MWP was working fine with 2.4.21 using either Cisco=20
Aironet 350 or Orinoco Gold PCMCIA 802.11b wireless card. Upgraded to=20
2.6.0-test2 to test it out and everything works but PCMCIA. When=20
inserting a card system locks up after logging entries like those in=20
section 5. PCMCIA cards are good as the operate properly under 2.4 and=20
in other machines. Originally compiled with pre-emptive code but later=20
disabled to try and remove that as cause of problem but problem still=20
remained without pre-emptive code included.

[3.]
modules, pcmcia, kobject_
[4.]
Linux version 2.6.0-test2-pcg-c1mwp (undrgrid@vaio) (gcc version 3.3.1=20
20030722 (Debian prerelease)) #1 Tue Jul 29 16:40:40 PDT 2003

[5.]
Jul 28 18:02:10 vaio kernel: airo:  Probing for PCI adapters
Jul 28 18:02:10 vaio kernel: kobject_register failed for airo (-17)
Jul 28 18:02:10 vaio kernel: Call Trace:
Jul 28 18:02:10 vaio kernel:  [kobject_register+89/96]=20
kobject_register+0x59/0x60
Jul 28 18:02:10 vaio kernel:  [bus_add_driver+82/176]=20
bus_add_driver+0x52/0xb0
Jul 28 18:02:10 vaio kernel:  [driver_register+47/64]=20
driver_register+0x2f/0x40
Jul 28 18:02:10 vaio kernel:  [create_proc_entry+132/208]=20
create_proc_entry+0x84/0xd0
Jul 28 18:02:10 vaio kernel:  [pci_register_driver+114/160]=20
pci_register_driver+0x72/0xa0
Jul 28 18:02:10 vaio kernel:  [__crc_snd_card_proc_new+1653989/2456049]=20
airo_init_module+0xe8/0x10d [airo]
Jul 28 18:02:10 vaio kernel:  [sys_init_module+255/528]=20
sys_init_module+0xff/0x210
Jul 28 18:02:10 vaio kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 28 18:02:10 vaio kernel:=20
Jul 28 18:02:10 vaio kernel: airo:  Finished probing for PCI adapters

Jul 28 18:09:25 vaio kernel: cs: memory probe 0xa0000000-0xa0ffffff:=20
clean.
Jul 28 18:09:25 vaio kernel: airo: Doing fast bap_reads
Jul 28 18:09:25 vaio kernel: airo: MAC enabled eth1 0:40:96:58:be:46
Jul 28 18:09:25 vaio kernel: eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3,=20
io 0x0100-0x013f
Jul 28 18:09:25 vaio kernel: bad: scheduling while atomic!
Jul 28 18:09:25 vaio kernel: Call Trace:
Jul 28 18:09:25 vaio kernel:  [schedule+951/960] schedule+0x3b7/0x3c0
Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2038071/2456049]=20
sendcommand+0xaa/0xe0 [airo]
Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2037849/2456049]=20
issuecommand+0x5c/0x90 [airo]
Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2039319/2456049]=20
PC4500_accessrid+0x4a/0x90 [airo]
Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2039486/2456049]=20
PC4500_readrid+0x61/0x130 [airo]
Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2028126/2456049]=20
readStatsRid+0x31/0x50 [airo]
Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2029844/2456049]=20
airo_read_stats+0x67/0x150 [airo]
Jul 28 18:09:25 vaio kernel:  [update_wall_time+22/64]=20
update_wall_time+0x16/0x40
Jul 28 18:09:25 vaio kernel:  [do_timer+224/240] do_timer+0xe0/0xf0
Jul 28 18:09:25 vaio kernel:  [rcu_process_callbacks+131/256]=20
rcu_process_callbacks+0x83/0x100
Jul 28 18:09:25 vaio kernel:  [tasklet_action+70/112]=20
tasklet_action+0x46/0x70
Jul 28 18:09:25 vaio kernel:  [buffered_rmqueue+209/368]=20
buffered_rmqueue+0xd1/0x170
Jul 28 18:09:25 vaio kernel:  [buffered_rmqueue+209/368]=20
buffered_rmqueue+0xd1/0x170
Jul 28 18:09:25 vaio kernel:  [__alloc_pages+144/784]=20
__alloc_pages+0x90/0x310
Jul 28 18:09:25 vaio kernel:  [proc_alloc_inode+76/128]=20
proc_alloc_inode+0x4c/0x80
Jul 28 18:09:25 vaio kernel:  [proc_alloc_inode+76/128]=20
proc_alloc_inode+0x4c/0x80
Jul 28 18:09:25 vaio kernel:  [alloc_inode+208/384]=20
alloc_inode+0xd0/0x180
Jul 28 18:09:25 vaio kernel:  [do_pollfd+17/160] do_pollfd+0x11/0xa0
Jul 28 18:09:25 vaio kernel:  [iget_locked+149/192]=20
iget_locked+0x95/0xc0
Jul 28 18:09:25 vaio kernel:  [proc_read_inode+23/64]=20
proc_read_inode+0x17/0x40
Jul 28 18:09:25 vaio kernel:  [wake_up_inode+15/48]=20
wake_up_inode+0xf/0x30
Jul 28 18:09:25 vaio kernel:  [proc_get_inode+278/320]=20
proc_get_inode+0x116/0x140
Jul 28 18:09:25 vaio kernel:  [d_instantiate+102/128]=20
d_instantiate+0x66/0x80
Jul 28 18:09:25 vaio kernel:  [vsnprintf+582/1136] vsnprintf+0x246/0x470
Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2030099/2456049]=20
airo_get_stats+0x16/0x20 [airo]
Jul 28 18:09:25 vaio kernel:  [dev_seq_printf_stats+235/256]=20
dev_seq_printf_stats+0xeb/0x100
Jul 28 18:09:25 vaio kernel:  [dev_seq_show+40/144]=20
dev_seq_show+0x28/0x90
Jul 28 18:09:25 vaio kernel:  [seq_read+477/784] seq_read+0x1dd/0x310
Jul 28 18:09:25 vaio kernel:  [vfs_read+236/336] vfs_read+0xec/0x150
Jul 28 18:09:25 vaio kernel:  [sys_read+66/112] sys_read+0x42/0x70
Jul 28 18:09:25 vaio kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Jul 28 18:09:26 vaio kernel: ------------[ cut here ]------------
Jul 28 18:09:26 vaio kernel: kernel BUG at kernel/workqueue.c:77!
Jul 28 18:09:26 vaio kernel: invalid operand: 0000 [#1]
Jul 28 18:09:26 vaio kernel: CPU:    0
Jul 28 18:09:26 vaio kernel: EIP:    0060:[queue_work+140/160]    Not=20
tainted
Jul 28 18:09:26 vaio kernel: EFLAGS: 00210217
Jul 28 18:09:26 vaio kernel: EIP is at queue_work+0x8c/0xa0
Jul 28 18:09:26 vaio kernel: eax: 00000000   ebx: 00000000   ecx:=20
c7afc394   edx: c7afc390
Jul 28 18:09:26 vaio kernel: esi: c7afc390   edi: ca13a000   ebp:=20
ceffdc20   esp: ca13bce8
Jul 28 18:09:26 vaio kernel: ds: 007b   es: 007b   ss: 0068
Jul 28 18:09:26 vaio kernel: Process gkrellm (pid: 581,=20
threadinfo=3Dca13a000 task=3Dca640640)
Jul 28 18:09:26 vaio kernel: Stack: c7afc37c d00c5cb0 c7afc000 c7afc220=20
d00c5df2
 c7afc220 ca13bd0c 0000ff68=20
Jul 28 18:09:26 vaio kernel:        00000000 000001a4 00000000 00000018=20
00000001 00000000 00000002 0000000f=20
Jul 28 18:09:26 vaio kernel:        00000000 00000000 00000000 00000000=20
00000000 00000000 00000000 00000000=20
Jul 28 18:09:26 vaio kernel: Call Trace:
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2029741/2456049]=20
airo_read_stats+0x0/0x150 [airo]
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2030063/2456049]=20
airo_read_stats+0x142/0x150 [airo]
Jul 28 18:09:26 vaio kernel:  [buffered_rmqueue+209/368]=20
buffered_rmqueue+0xd1/0x170
Jul 28 18:09:26 vaio kernel:  [buffered_rmqueue+209/368]=20
buffered_rmqueue+0xd1/0x170
Jul 28 18:09:26 vaio kernel:  [__alloc_pages+144/784]=20
__alloc_pages+0x90/0x310
Jul 28 18:09:26 vaio kernel:  [do_anonymous_page+283/528]=20
do_anonymous_page+0x11b/0x210
Jul 28 18:09:26 vaio kernel:  [do_page_fault+604/1145]=20
do_page_fault+0x25c/0x479
Jul 28 18:09:26 vaio kernel:  [vsnprintf+582/1136] vsnprintf+0x246/0x470
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2030099/2456049]=20
airo_get_stats+0x16/0x20 [airo]
Jul 28 18:09:26 vaio kernel:  [dev_seq_printf_stats+235/256]=20
dev_seq_printf_stats+0xeb/0x100
Jul 28 18:09:26 vaio kernel:  [dev_seq_show+40/144]=20
dev_seq_show+0x28/0x90
Jul 28 18:09:26 vaio kernel:  [seq_read+477/784] seq_read+0x1dd/0x310
Jul 28 18:09:26 vaio kernel:  [vfs_read+236/336] vfs_read+0xec/0x150
Jul 28 18:09:26 vaio kernel:  [sys_read+66/112] sys_read+0x42/0x70
Jul 28 18:09:26 vaio kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 28 18:09:26 vaio kernel:=20
Jul 28 18:09:26 vaio kernel: Code: 0f 0b 4d 00 85 10 43 c0 eb 90 8d 76=20
00 8d bc 27 00 00 00 00=20
Jul 28 18:09:26 vaio kernel:  <6>note: gkrellm[581] exited with=20
preempt_count 2
Jul 28 18:09:26 vaio kernel: bad: scheduling while atomic!
Jul 28 18:09:26 vaio kernel: Call Trace:
Jul 28 18:09:26 vaio kernel:  [schedule+951/960] schedule+0x3b7/0x3c0
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2038071/2456049]=20
sendcommand+0xaa/0xe0 [airo]
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2037849/2456049]=20
issuecommand+0x5c/0x90 [airo]
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2039319/2456049]=20
PC4500_accessrid+0x4a/0x90 [airo]
Jul 28 18:09:26 vaio kernel:  [error_code+45/56] error_code+0x2d/0x38
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2039486/2456049]=20
PC4500_readrid+0x61/0x130 [airo]
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2028126/2456049]=20
readStatsRid+0x31/0x50 [airo]
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2029844/2456049]=20
airo_read_stats+0x67/0x150 [airo]
Jul 28 18:09:26 vaio kernel:  [find_get_page+44/96]=20
find_get_page+0x2c/0x60
Jul 28 18:09:26 vaio kernel:  [filemap_nopage+654/800]=20
filemap_nopage+0x28e/0x320
Jul 28 18:09:26 vaio kernel:  [do_no_page+388/736]=20
do_no_page+0x184/0x2e0
Jul 28 18:09:26 vaio kernel:  [proc_alloc_inode+76/128]=20
proc_alloc_inode+0x4c/0x80
Jul 28 18:09:26 vaio kernel:  [proc_alloc_inode+76/128]=20
proc_alloc_inode+0x4c/0x80
Jul 28 18:09:26 vaio kernel:  [alloc_inode+208/384]=20
alloc_inode+0xd0/0x180
Jul 28 18:09:26 vaio kernel:  [do_pollfd+17/160] do_pollfd+0x11/0xa0
Jul 28 18:09:26 vaio kernel:  [iget_locked+149/192]=20
iget_locked+0x95/0xc0
Jul 28 18:09:26 vaio kernel:  [find_get_page+44/96]=20
find_get_page+0x2c/0x60
Jul 28 18:09:26 vaio kernel:  [filemap_nopage+654/800]=20
filemap_nopage+0x28e/0x320
Jul 28 18:09:26 vaio kernel:  [vsnprintf+582/1136] vsnprintf+0x246/0x470
Jul 28 18:09:26 vaio kernel:  [__crc_snd_card_proc_new+2030099/2456049]=20
airo_get_stats+0x16/0x20 [airo]
Jul 28 18:09:26 vaio kernel:  [dev_seq_printf_stats+235/256]=20
dev_seq_printf_stats+0xeb/0x100
Jul 28 18:09:26 vaio kernel:  [dev_seq_show+40/144]=20
dev_seq_show+0x28/0x90
Jul 28 18:09:26 vaio kernel:  [seq_read+477/784] seq_read+0x1dd/0x310
Jul 28 18:09:26 vaio kernel:  [vfs_read+236/336] vfs_read+0xec/0x150
Jul 28 18:09:26 vaio kernel:  [sys_read+66/112] sys_read+0x42/0x70
Jul 28 18:09:26 vaio kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 28 18:09:26 vaio kernel:=20
Jul 31 13:12:11 vaio kernel: airo:  Probing for PCI adapters
Jul 31 13:12:11 vaio kernel: kobject_register failed for airo (-17)
Jul 31 13:12:11 vaio kernel: Call Trace:
Jul 31 13:12:11 vaio kernel:  [kobject_register+89/96]=20
kobject_register+0x59/0x60
Jul 31 13:12:11 vaio kernel:  [bus_add_driver+82/176]=20
bus_add_driver+0x52/0xb0
Jul 31 13:12:11 vaio kernel:  [driver_register+47/64]=20
driver_register+0x2f/0x40
Jul 31 13:12:11 vaio kernel:  [create_proc_entry+132/208]=20
create_proc_entry+0x84/0xd0
Jul 31 13:12:11 vaio kernel:  [pci_register_driver+114/160]=20
pci_register_driver+0x72/0xa0
Jul 31 13:12:11 vaio kernel:  [__crc_snd_card_proc_new+1674469/2456049]=20
airo_init_module+0xe8/0x10d [airo]
Jul 31 13:12:11 vaio kernel:  [sys_init_module+231/432]=20
sys_init_module+0xe7/0x1b0
Jul 31 13:12:11 vaio kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 31 13:12:11 vaio kernel:=20
Jul 31 13:12:11 vaio kernel: airo:  Finished probing for PCI adapters
Jul 31 13:12:11 vaio kernel: airo: Doing fast bap_reads
Jul 31 13:12:11 vaio kernel: airo: MAC enabled eth1 0:40:96:58:be:46
Jul 31 13:12:11 vaio kernel: eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3,=20
io 0x0100-0x013f

[6.]
None really as all it takes is inserting the PCMCIA 802.11b wireless=20
card into the computer to lock it up.

[7.]
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_EXPERIMENTAL=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_KALLSYMS=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy
CONFIG_X86_PC=3Dy
CONFIG_MCRUSOE=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
CONFIG_NOHIGHMEM=3Dy
CONFIG_MTRR=3Dy
CONFIG_PM=3Dy
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_ISA=3Dy
CONFIG_SCx200=3Dm
CONFIG_HOTPLUG=3Dy
CONFIG_PCMCIA=3Dy
CONFIG_YENTA=3Dy
CONFIG_CARDBUS=3Dy
CONFIG_PCMCIA_PROBE=3Dy
CONFIG_KCORE_ELF=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_FW_LOADER=3Dm
CONFIG_PNP=3Dy
CONFIG_PNP_NAMES=3Dy
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D4096
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
CONFIG_BLK_DEV_IDESCSI=3Dm
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_OFFBOARD=3Dy
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_BLK_DEV_ADMA=3Dy
CONFIG_BLK_DEV_ALI15X3=3Dy
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_BLK_DEV_IDE_MODES=3Dy
CONFIG_SCSI=3Dy
CONFIG_BLK_DEV_SD=3Dy
CONFIG_BLK_DEV_SR=3Dy
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dy
CONFIG_SCSI_REPORT_LUNS=3Dy
CONFIG_IEEE1394=3Dy
CONFIG_IEEE1394_OUI_DB=3Dy
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_SBP2=3Dm
CONFIG_IEEE1394_SBP2_PHYS_DMA=3Dy
CONFIG_IEEE1394_DV1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
CONFIG_IEEE1394_CMP=3Dm
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_NETFILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dy
CONFIG_INET_ESP=3Dy
CONFIG_INET_IPCOMP=3Dy
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_TFTP=3Dm
CONFIG_IP_NF_AMANDA=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_RECENT=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_NAT_TFTP=3Dm
CONFIG_IP_NF_NAT_AMANDA=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm
CONFIG_IPV6=3Dy
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_INET6_AH=3Dy
CONFIG_INET6_ESP=3Dy
CONFIG_INET6_IPCOMP=3Dy
CONFIG_IPV6_TUNNEL=3Dy
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_LIMIT=3Dm
CONFIG_IP6_NF_MATCH_MAC=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP6_NF_MATCH_OWNER=3Dm
CONFIG_IP6_NF_MATCH_MARK=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_AHESP=3Dm
CONFIG_IP6_NF_MATCH_LENGTH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_LOG=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_TARGET_MARK=3Dm
CONFIG_XFRM_USER=3Dy
CONFIG_IPV6_SCTP__=3Dy
CONFIG_VLAN_8021Q=3Dm
CONFIG_NETDEVICES=3Dy
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dm
CONFIG_NET_PCI=3Dy
CONFIG_8139TOO=3Dy
CONFIG_PPP=3Dy
CONFIG_PPP_SYNC_TTY=3Dy
CONFIG_PPP_DEFLATE=3Dy
CONFIG_PPP_BSDCOMP=3Dy
CONFIG_NET_RADIO=3Dy
CONFIG_STRIP=3Dm
CONFIG_ARLAN=3Dm
CONFIG_WAVELAN=3Dm
CONFIG_PCMCIA_WAVELAN=3Dm
CONFIG_PCMCIA_NETWAVE=3Dm
CONFIG_PCMCIA_RAYCS=3Dm
CONFIG_AIRO=3Dm
CONFIG_HERMES=3Dm
CONFIG_PLX_HERMES=3Dm
CONFIG_PCI_HERMES=3Dm
CONFIG_PCMCIA_HERMES=3Dm
CONFIG_AIRO_CS=3Dm
CONFIG_PCMCIA_ATMEL=3Dm
CONFIG_NET_WIRELESS=3Dy
CONFIG_NET_PCMCIA=3Dy
CONFIG_INPUT=3Dy
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D600
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_WATCHDOG=3Dy
CONFIG_RTC=3Dy
CONFIG_SONYPI=3Dm
CONFIG_AGP=3Dy
CONFIG_AGP_ALI=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_RADEON=3Dm
CONFIG_VIDEO_DEV=3Dy
CONFIG_VIDEO_PROC_FS=3Dy
CONFIG_VIDEO_CPIA=3Dm
CONFIG_VIDEO_MEYE=3Dm
CONFIG_EXT2_FS=3Dy
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_JBD=3Dy
CONFIG_FS_MBCACHE=3Dy
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QUOTACTL=3Dy
CONFIG_AUTOFS4_FS=3Dy
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dy
CONFIG_UDF_FS=3Dy
CONFIG_FAT_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_NTFS_FS=3Dy
CONFIG_PROC_FS=3Dy
CONFIG_DEVPTS_FS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_CRAMFS=3Dm
CONFIG_NFS_FS=3Dy
CONFIG_NFSD=3Dy
CONFIG_LOCKD=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SMB_FS=3Dm
CONFIG_CIFS=3Dm
CONFIG_NCP_FS=3Dm
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_15=3Dy
CONFIG_NLS_UTF8=3Dy
CONFIG_FB=3Dy
CONFIG_VIDEO_SELECT=3Dy
CONFIG_FB_RADEON=3Dy
CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_PCI_CONSOLE=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy
CONFIG_SOUND=3Dy
CONFIG_SND=3Dy
CONFIG_SND_SEQUENCER=3Dy
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dy
CONFIG_SND_PCM_OSS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm
CONFIG_SND_ALI5451=3Dy
CONFIG_SND_TRIDENT=3Dy
CONFIG_SND_YMFPCI=3Dy
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_VXPOCKET=3Dm
CONFIG_SND_VXP440=3Dm
CONFIG_USB=3Dy
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_UHCI_HCD=3Dy
CONFIG_USB_AUDIO=3Dm
CONFIG_USB_MIDI=3Dm
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dy
CONFIG_USB_HID=3Dm
CONFIG_USB_KBD=3Dm
CONFIG_USB_MOUSE=3Dm
CONFIG_USB_AIPTEK=3Dm
CONFIG_USB_WACOM=3Dm
CONFIG_USB_KBTAB=3Dm
CONFIG_USB_POWERMATE=3Dm
CONFIG_USB_XPAD=3Dm
CONFIG_USB_MDC800=3Dm
CONFIG_USB_SCANNER=3Dm
CONFIG_USB_MICROTEK=3Dm
CONFIG_USB_HPUSBSCSI=3Dm
CONFIG_USB_DABUSB=3Dm
CONFIG_USB_VICAM=3Dm
CONFIG_USB_DSBR=3Dm
CONFIG_USB_IBMCAM=3Dm
CONFIG_USB_KONICAWC=3Dm
CONFIG_USB_OV511=3Dm
CONFIG_USB_PWC=3Dm
CONFIG_USB_SE401=3Dm
CONFIG_USB_STV680=3Dm
CONFIG_USB_AX8817X=3Dm
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_USBNET=3Dm
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_GENESYS=3Dy
CONFIG_USB_NET1080=3Dy
CONFIG_USB_PL2301=3Dy
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_ZAURUS=3Dy
CONFIG_USB_CDCETHER=3Dy
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_EZUSB=3Dy
CONFIG_USB_EMI26=3Dm
CONFIG_USB_TIGL=3Dm
CONFIG_USB_AUERSWALD=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_BRLVGER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_GADGET=3Dm
CONFIG_USB_NET2280=3Dm
CONFIG_USB_ZERO=3Dm
CONFIG_USB_ZERO_NET2280=3Dy
CONFIG_USB_ETH=3Dm
CONFIG_USB_ETH_NET2280=3Dy
CONFIG_BT=3Dy
CONFIG_BT_L2CAP=3Dy
CONFIG_BT_SCO=3Dy
CONFIG_BT_RFCOMM=3Dy
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dy
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_HCIUSB=3Dm
CONFIG_BT_USB_SCO=3Dy
CONFIG_BT_USB_ZERO_PACKET=3Dy
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIUART_BCSP_TXCRC=3Dy
CONFIG_BT_HCIDTL1=3Dm
CONFIG_BT_HCIBT3C=3Dm
CONFIG_BT_HCIBLUECARD=3Dm
CONFIG_BT_HCIBTUART=3Dm
CONFIG_BT_HCIVHCI=3Dm
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_X86_EXTRA_IRQS=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy
CONFIG_SECURITY=3Dy
CONFIG_SECURITY_CAPABILITIES=3Dy
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dy
CONFIG_CRYPTO_MD4=3Dy
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dy
CONFIG_CRYPTO_SHA512=3Dy
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_BLOWFISH=3Dy
CONFIG_CRYPTO_TWOFISH=3Dy
CONFIG_CRYPTO_SERPENT=3Dy
CONFIG_CRYPTO_AES=3Dy
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRC32=3Dy
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy

[7.1]
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux vaio 2.6.0-test2-pcg-c1mwp #1 Tue Jul 29 16:40:40 PDT 2003 i686=20
GNU/Linux
=20
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34
pcmcia-cs              3.2.2
nfs-utils              1.0.5
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         radeon meye sonypi cmp raw1394 dv1394 video1394=20
sbp2 ohci1394

[7.2]
processor       : 0
vendor_id       : GenuineTMx86
cpu family      : 6
model           : 4
model name      : Transmeta(tm) Crusoe(tm) Processor TM5800
stepping        : 3
cpu MHz         : 860.248
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 sep cmov mmx
bogomips        : 1372.16

[7.3]
radeon 119372 0 - Live 0xd00d3000
meye 26052 0 - Live 0xd00a7000
sonypi 22812 2 meye, Live 0xd00a0000
cmp 3872 0 - Live 0xd006d000
raw1394 27404 0 - Live 0xd0090000
dv1394 19392 0 - Live 0xd008a000
video1394 17568 0 - Live 0xd0084000
sbp2 24168 0 - Live 0xd007d000
ohci1394 34504 2 dv1394,video1394, Live 0xd0073000

[7.4]
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #01
  1080-109f : Sony Programable I/O Device
1400-140f : ALi Corporation M5229 IDE
  1400-1407 : ide0
  1408-140f : ide1
1800-18ff : ALi Corporation M5451 PCI AC-Link Co
  1800-18ff : ALI 5451
1c00-1cff : ALi Corporation M5457 AC-Link Modem=20
2000-20ff : PCI device 10cf:2011 (Citicorp TTI)
2400-24ff : Realtek Semiconducto RTL-8139/8139C/8139C
  2400-24ff : 8139too
2800-28ff : ATI Technologies Inc Radeon Mobility M6 L
2c00-2cff : PCI CardBus #01
8000-803f : ALi Corporation M7101 PMU
8040-805f : ALi Corporation M7101 PMU

00000000-0009afff : System RAM
0009b000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000dc000-000dffff : reserved
000e0000-000e0fff : ALi Corporation USB 1.1 Controller (#2)
  000e0000-000e0fff : ohci-hcd
000f0000-000fffff : System ROM
00100000-0eeeffff : System RAM
  00100000-003f3c1e : Kernel code
  003f3c1f-0052c91f : Kernel data
0eef0000-0eefbfff : ACPI Tables
0eefc000-0eefffff : ACPI Non-volatile Storage
0ef00000-0effffff : System RAM
10000000-10000fff : Ricoh Co Ltd RL5c475
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
e8000000-e80fffff : Transmeta Corporatio LongRun Northbridge
e8100000-e8100fff : ALi Corporation M5451 PCI AC-Link Co
e8101000-e8101fff : ALi Corporation M5457 AC-Link Modem=20
e8102000-e81027ff : Texas Instruments TSB43AB22/A IEEE-139
  e8102000-e81027ff : ohci1394
e8102800-e81028ff : Realtek Semiconducto RTL-8139/8139C/8139C
  e8102800-e81028ff : 8139too
e8103000-e8103fff : ALi Corporation USB 1.1 Controller
  e8103000-e8103fff : ohci-hcd
e8104000-e8107fff : Texas Instruments TSB43AB22/A IEEE-139
e8110000-e811ffff : ATI Technologies Inc Radeon Mobility M6 L
  e8110000-e811ffff : radeonfb
e8200000-e82fffff : PCI device 10cf:2011 (Citicorp TTI)
f0000000-f7ffffff : ATI Technologies Inc Radeon Mobility M6 L
  f0000000-f7ffffff : radeonfb
fff80000-ffffffff : reserved

[7.5]
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 02)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=3D1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Cont=
roller Audio Device (rev 02)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1800 [size=3D256]
	Region 1: Memory at e8100000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem] (prog-if 00 =
[Generic])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8101000 (32-bit, non-prefetchable) [disabled] [size=
=3D4K]
	Region 1: I/O ports at 1c00 [disabled] [size=3D256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:09.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000=
 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8102000 (32-bit, non-prefetchable) [size=3D2K]
	Region 1: Memory at e8104000 (32-bit, non-prefetchable) [size=3D16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+

00:0a.0 Multimedia controller: Citicorp TTI: Unknown device 2011
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 2000 [disabled] [size=3D256]
	Region 1: Memory at e8200000 (32-bit, non-prefetchable) [disabled] [size=
=3D1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C=
/8139C+ (rev 10)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 128 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 2400 [size=3D256]
	Region 1: Memory at e8102800 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 =
LY (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: I/O ports at 2800 [size=3D256]
	Region 2: Memory at e8110000 (32-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-i=
f 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8103000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if a0)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at 1400 [size=3D16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 Non-VGA unclassified device: ALi Corporation M7101 PMU
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

00:12.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D01, subordinate=3D04, sec-latency=3D176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00002c00-00002cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-i=
f 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 000e0000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

[7.6]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Sony     Model: MSC-U03          Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02


--2oS5YaxWCcQjTEyO--

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE/LpWCVExIaGLb32IRAtQrAJ9bQ+BUwW1xpBrkwGJLQIzcPHY0MACfTh8m
aYS8NMnlrTwVxhGqZ1uxgpk=
=xMaf
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
