Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUCLAoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUCLAoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:44:16 -0500
Received: from smtp09.auna.com ([62.81.186.19]:1720 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261863AbUCLAoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:44:07 -0500
Date: Fri, 12 Mar 2004 01:44:03 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: inlining in gcc-3.4
Message-ID: <20040312004403.GA3084@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Building with gcc-3.4 (Mandrake 10.0), the inlining limit seems to be lowered,
I get all this warnings. Is some of them fatal ? The kernel (2.6.4-mm1) still
works. Perhaps more 'always_inine' are needed...

arch/i386/kernel/setup.c: In function `setup_memory_region':
arch/i386/kernel/setup.c:60: warning: inlining failed in call to 'machine_specific_memory_setup': function body not available
arch/i386/kernel/setup.c:480: warning: called from here
kernel/signal.c: In function `group_send_sig_info':
kernel/signal.c:947: warning: inlining failed in call to '__group_send_sig_info': function not considered for inlining
kernel/signal.c:1039: warning: called from here
kernel/signal.c: In function `do_notify_parent':
kernel/signal.c:947: warning: inlining failed in call to '__group_send_sig_info': function not considered for inlining
kernel/signal.c:1471: warning: called from here
kernel/signal.c: In function `do_notify_parent_cldstop':
kernel/signal.c:947: warning: inlining failed in call to '__group_send_sig_info': function not considered for inlining
kernel/signal.c:1517: warning: called from here
arch/i386/kernel/smp.c: In function `flush_tlb_others':
arch/i386/kernel/smp.c:162: warning: inlining failed in call to 'send_IPI_mask_bitmask': function not considered for inlining
arch/i386/kernel/smp.c:9: warning: called from here
arch/i386/kernel/smp.c: In function `smp_send_reschedule':
arch/i386/kernel/smp.c:162: warning: inlining failed in call to 'send_IPI_mask_bitmask': function not considered for inlining
arch/i386/kernel/smp.c:9: warning: called from here
arch/i386/kernel/smp.c: In function `smp_call_function':
arch/i386/kernel/smp.c:127: warning: inlining failed in call to '__send_IPI_shortcut': function not considered for inlining
arch/i386/kernel/smp.c:21: warning: called from here
kernel/posix-timers.c: In function `do_schedule_next_timer':
kernel/posix-timers.c:192: warning: inlining failed in call to 'unlock_timer': function body not available
kernel/posix-timers.c:282: warning: called from here
kernel/posix-timers.c: In function `posix_timer_fn':
kernel/posix-timers.c:192: warning: inlining failed in call to 'unlock_timer': function body not available
kernel/posix-timers.c:349: warning: called from here
arch/i386/kernel/io_apic.c: In function `setup_IO_APIC':
arch/i386/kernel/io_apic.c:2157: warning: inlining failed in call to 'check_timer': function not considered for inlining
arch/i386/kernel/io_apic.c:2297: warning: called from here
arch/i386/kernel/io_apic.c: In function `check_timer':
arch/i386/kernel/io_apic.c:2096: warning: inlining failed in call to 'unlock_ExtINT_logic': function not considered for inlining
arch/i386/kernel/io_apic.c:2255: warning: called from here
fs/exec.c: In function `flush_old_exec':
fs/exec.c:566: warning: inlining failed in call to 'de_thread': function not considered for inlining
fs/exec.c:798: warning: called from here
fs/namei.c: In function `link_path_walk':
fs/namei.c:487: warning: inlining failed in call to 'follow_dotdot': function not considered for inlining
fs/namei.c:633: warning: called from here
fs/namei.c:487: warning: inlining failed in call to 'follow_dotdot': function not considered for inlining
fs/namei.c:701: warning: called from here
drivers/char/n_tty.c: In function `n_tty_receive_buf':
drivers/char/n_tty.c:529: warning: inlining failed in call to 'n_tty_receive_char': function not considered for inlining
drivers/char/n_tty.c:789: warning: called from here
drivers/char/vt_ioctl.c: In function `vt_ioctl':
drivers/char/vt_ioctl.c:187: warning: inlining failed in call to 'do_kdgkb_ioctl': function not considered for inlining
drivers/char/vt_ioctl.c:582: warning: called from here
drivers/i2c/algos/i2c-algo-bit.c: In function `bit_xfer':
drivers/i2c/algos/i2c-algo-bit.c:368: warning: inlining failed in call to 'readbytes': function not considered for inlining
drivers/i2c/algos/i2c-algo-bit.c:492: warning: called from here
drivers/char/agp/intel-agp.c:1453: warning: `__used__' attribute ignored
sound/oss/emu10k1/main.c:155: warning: `__used__' attribute ignored
arch/i386/pci/pcbios.c: In function `pcibios_get_irq_routing_table':
arch/i386/pci/pcbios.c:424: warning: read-write constraint does not allow a register
arch/i386/pci/pcbios.c:424: warning: read-write constraint does not allow a register
drivers/input/joydev.c:502: warning: `__used__' attribute ignored
drivers/input/evdev.c:456: warning: `__used__' attribute ignored
drivers/input/gameport/emu10k1-gp.c:58: warning: `__used__' attribute ignored
drivers/net/3c59x.c:626: warning: `__used__' attribute ignored
drivers/net/ne2k-pci.c:155: warning: `__used__' attribute ignored
drivers/net/8139too.c:274: warning: `__used__' attribute ignored
drivers/net/8139too.c: In function `rtl8139_open':
drivers/net/8139too.c:609: warning: inlining failed in call to 'rtl8139_start_thread': function body not available
drivers/net/8139too.c:1356: warning: called from here
drivers/scsi/sg.c: In function `sg_ioctl':
drivers/scsi/sg.c:219: warning: inlining failed in call to 'sg_jif_to_ms': function body not available
drivers/scsi/sg.c:941: warning: called from here
drivers/scsi/sg.c: In function `sg_cmd_done':
drivers/scsi/sg.c:219: warning: inlining failed in call to 'sg_jif_to_ms': function body not available
drivers/scsi/sg.c:1265: warning: called from here
drivers/usb/class/usblp.c:1156: warning: `__used__' attribute ignored
drivers/usb/core/hub.c:1160: warning: `__used__' attribute ignored
net/ipv4/netfilter/ip_tables.c: In function `translate_table':
net/ipv4/netfilter/ip_tables.c:674: warning: inlining failed in call to 'check_entry': function not considered for inlining
net/ipv4/netfilter/ip_tables.c:853: warning: called from here
fs/nfsd/nfsxdr.c: In function `nfssvc_encode_attrstat':
fs/nfsd/nfsxdr.c:150: warning: inlining failed in call to 'encode_fattr': function not considered for inlining
fs/nfsd/nfsxdr.c:386: warning: called from here
fs/nfsd/nfsxdr.c: In function `nfssvc_encode_diropres':
fs/nfsd/nfsxdr.c:150: warning: inlining failed in call to 'encode_fattr': function not considered for inlining
fs/nfsd/nfsxdr.c:395: warning: called from here
fs/nfsd/nfsxdr.c: In function `nfssvc_encode_readres':
fs/nfsd/nfsxdr.c:150: warning: inlining failed in call to 'encode_fattr': function not considered for inlining
fs/nfsd/nfsxdr.c:420: warning: called from here
drivers/usb/host/uhci-hcd.c:2544: warning: `__used__' attribute ignored
fs/nfsd/nfs3xdr.c: In function `encode_post_op_attr':
fs/nfsd/nfs3xdr.c:168: warning: inlining failed in call to 'encode_fattr3': function not considered for inlining
fs/nfsd/nfs3xdr.c:246: warning: called from here
fs/nfsd/nfs3xdr.c: In function `encode_wcc_data':
fs/nfsd/nfs3xdr.c:204: warning: inlining failed in call to 'encode_saved_post_attr': function not considered for inlining
fs/nfsd/nfs3xdr.c:269: warning: called from here
drivers/usb/input/hid-core.c:1766: warning: `__used__' attribute ignored
drivers/usb/input/usbkbd.c:358: warning: `__used__' attribute ignored
drivers/usb/input/usbmouse.c:239: warning: `__used__' attribute ignored
fs/nfsd/nfs3xdr.c: In function `nfs3svc_encode_attrstat':
fs/nfsd/nfs3xdr.c:168: warning: inlining failed in call to 'encode_fattr3': function not considered for inlining
fs/nfsd/nfs3xdr.c:618: warning: called from here
drivers/usb/storage/usb.c:144: warning: `__used__' attribute ignored
net/sunrpc/xprt.c: In function `xprt_reserve':
net/sunrpc/xprt.c:84: warning: inlining failed in call to 'do_xprt_reserve': function body not available
net/sunrpc/xprt.c:1294: warning: called from here
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:169: Warning: value 0x37ffffff truncated to 0x37ffffff

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Community) for i586
Linux 2.6.4-jam1 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.4mdk))
