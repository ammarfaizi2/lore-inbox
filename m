Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTA0UwB>; Mon, 27 Jan 2003 15:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbTA0UwB>; Mon, 27 Jan 2003 15:52:01 -0500
Received: from newpeace.netnation.com ([204.174.223.7]:61581 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S263215AbTA0Uv6>; Mon, 27 Jan 2003 15:51:58 -0500
Date: Mon, 27 Jan 2003 13:01:16 -0800
From: Simon Kirby <sim@netnation.com>
To: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: [2.4.21-pre3] Netfilter does not compile with this .config
Message-ID: <20030127210116.GB23198@netnation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I tried changing some netfilter config stuff around (so that I could
choose to not include conntrack when I don't need it), to find that
compilation borked with an allowed config:

ld -m elf_i386 -T /var/kernel/servers/web/linux.alfie/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/media/media.o drivers/md/mddev.o drivers/hotplug/vmlinux-obj.o \
        net/network.o \
        /var/kernel/servers/web/linux.alfie/arch/i386/lib/lib.a /var/kernel/servers/web/linux.alfie/lib/lib.a /var/kernel/servers/web/linux.alfie/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o(.text+0x42485): In function `match':
: undefined reference to `ip_conntrack_get'
net/network.o(.text.init+0x13ca): In function `init':
: undefined reference to `ip_conntrack_module'
make: *** [vmlinux] Error 1

.config attached.

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]

--OXfL5xGRrasGEqWY
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
M+jvS2oM/wd9qOQ9Y0oAAA==

--OXfL5xGRrasGEqWY--
