Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLPJYy>; Sat, 16 Dec 2000 04:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbQLPJYo>; Sat, 16 Dec 2000 04:24:44 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:19210 "EHLO
	pobox.com") by vger.kernel.org with ESMTP id <S129345AbQLPJYg>;
	Sat, 16 Dec 2000 04:24:36 -0500
From: "Barry K. Nathan" <barryn@pobox.com>
Message-Id: <200012160854.AAA14403@pobox.com>
Subject: Re: test13pre2 - netfilter modiles compile failure
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 16 Dec 2000 00:54:11 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <Pine.LNX.4.10.10012160015521.11822-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 16, 2000 12:23:57 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Does that work for you?

It compiles in the module case [note: I haven't been doing a
modules_install or actually testing the results of my compiles] but it
gives tons of errors in the in-kernel case (these might be word-wrapped in
silly places, but it should give you the picture):

ld -m elf_i386 -T
/home/barryn/lsoft/kernels/buildspace/linux-2.4.0test13pre2bkn-ath/arch/i386/vmlinux.lds
-e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o
drivers/md/mddev.o \
	net/network.o \
	/home/barryn/lsoft/kernels/buildspace/linux-2.4.0test13pre2bkn-ath/arch/i386/lib/lib.a
/home/barryn/lsoft/kernels/buildspace/linux-2.4.0test13pre2bkn-ath/lib/lib.a
/home/barryn/lsoft/kernels/buildspace/linux-2.4.0test13pre2bkn-ath/arch/i386/lib/lib.a
\
	--end-group \
	-o vmlinux
net/network.o: In function `fw_in':
net/network.o(.text+0x2e84d): undefined reference to `ip_ct_gather_frags'
net/network.o(.text+0x2e93f): undefined reference to
`ip_conntrack_confirm'
net/network.o: In function `fw_confirm':
net/network.o(.text+0x2ea6b): undefined reference to
`ip_conntrack_confirm'
net/network.o: In function `do_masquerade':
net/network.o(.text+0x2f387): undefined reference to `ip_conntrack_in'
net/network.o(.text+0x2f3b0): undefined reference to `ip_conntrack_get'
net/network.o(.text+0x2f3cd): undefined reference to `ip_nat_lock'
net/network.o(.text+0x2f3e9): undefined reference to `ip_nat_lock'
net/network.o(.text+0x2f412): undefined reference to `ip_nat_lock'
net/network.o(.text+0x2f4d5): undefined reference to `ip_nat_setup_info'
net/network.o(.text+0x2f4e5): undefined reference to `ip_nat_lock'
net/network.o(.text+0x2f508): undefined reference to `ip_nat_lock'
net/network.o(.text+0x2f51d): undefined reference to `place_in_hashes'
net/network.o(.text+0x2f530): undefined reference to `ip_nat_lock'
net/network.o(.text+0x2f553): undefined reference to `ip_nat_lock'
net/network.o(.text+0x2f571): undefined reference to `do_bindings'
net/network.o: In function `check_for_masq_error':
net/network.o(.text+0x2f5a0): undefined reference to `ip_conntrack_get'
net/network.o(.text+0x2f5b7): undefined reference to
`icmp_reply_translation'
net/network.o(.text+0x2f5d1): undefined reference to
`icmp_reply_translation'
net/network.o: In function `check_for_demasq':
net/network.o(.text+0x2f5f6): undefined reference to `find_proto'
net/network.o(.text+0x2f62b): undefined reference to `icmp_error_track'
net/network.o(.text+0x2f648): undefined reference to
`icmp_reply_translation'
net/network.o(.text+0x2f664): undefined reference to
`icmp_reply_translation'
net/network.o(.text+0x2f67e): undefined reference to `get_tuple'
net/network.o(.text+0x2f6b4): undefined reference to
`ip_conntrack_find_get'
net/network.o(.text+0x2f6dd): undefined reference to `ip_conntrack_in'
net/network.o(.text+0x2f71d): undefined reference to `ip_conntrack_get'
net/network.o(.text+0x2f73b): undefined reference to `do_bindings'
net/network.o: In function `masq_procinfo':
net/network.o(.text+0x2f935): undefined reference to `ip_conntrack_lock'
net/network.o(.text+0x2f954): undefined reference to `ip_conntrack_lock'
net/network.o(.text+0x2f982): undefined reference to `ip_conntrack_lock'
net/network.o(.text+0x2f98a): undefined reference to `ip_conntrack_lock'
net/network.o(.text+0x2f990): undefined reference to
`ip_conntrack_htable_size'
net/network.o(.text+0x2f9a8): undefined reference to `ip_conntrack_hash'
net/network.o(.text+0x2f9b6): undefined reference to `ip_conntrack_lock'
net/network.o(.text+0x2f9da): undefined reference to `ip_conntrack_hash'
net/network.o(.text+0x2f9ea): undefined reference to `ip_conntrack_lock'
net/network.o(.text+0x2fa1e): undefined reference to `ip_conntrack_hash'
net/network.o(.text+0x2fa2a): undefined reference to `ip_conntrack_lock'
net/network.o(.text+0x2fa35): undefined reference to
`ip_conntrack_htable_size'
net/network.o(.text+0x2fa65): undefined reference to `ip_conntrack_lock'
net/network.o: In function `masq_cleanup':
net/network.o(.text+0x2fa91): undefined reference to `ip_nat_cleanup'
net/network.o(.text+0x2fa96): undefined reference to
`ip_conntrack_cleanup'
net/network.o: In function `masq_init':
net/network.o(.text.init+0xf22): undefined reference to
`ip_conntrack_init'
net/network.o(.text.init+0xf2d): undefined reference to `ip_nat_init'
net/network.o(.text.init+0xf61): undefined reference to
`ip_conntrack_cleanup'
make: *** [vmlinux] Error 1

-Barry K. Nathan <barryn@pobox.com>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
