Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318850AbSHLWUb>; Mon, 12 Aug 2002 18:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318851AbSHLWUa>; Mon, 12 Aug 2002 18:20:30 -0400
Received: from dhcp80ff237d.dynamic.uiowa.edu ([128.255.35.125]:10624 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S318850AbSHLWUa>;
	Mon, 12 Aug 2002 18:20:30 -0400
Date: Sun, 11 Aug 2002 14:28:58 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.30: undefined references in sound/sound.o and net/network.o
Message-ID: <20020811192858.GA5809@digitasaru.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
From: "Johnnie Q. Hacker" <trelane@paulus.neurotek.dnsalias.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got the following errors when making bzImage for 2.5.30.  Thought y'all
  might like to see 'em.

ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o /usr/local/src/kernel/linux-2.5.30/arch/i386/lib/lib.a lib/lib.a /usr/local/src/kernel/linux-2.5.30/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
sound/sound.o: In function `snd_cs4281_gameport':
sound/sound.o(.text+0x2f739): undefined reference to `gameport_register_port'
sound/sound.o: In function `snd_cs4281_free':
sound/sound.o(.text+0x2f755): undefined reference to `gameport_unregister_port'
net/network.o: In function `sock_init':
net/network.o(.text.init+0x65): undefined reference to `bluez_init'
make: *** [vmlinux] Error 1

-- 
Joseph======================================================jap3003@ksu.edu
"Linux has restored innovation in software development, and the form of
this innovation is not in finding new ways to charge customers or lock them
in to obscure file formats. Linux innovation is about the individual, about
freedom, and yes, about just working."    --Brian Jamison
