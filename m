Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSGXVp1>; Wed, 24 Jul 2002 17:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSGXVp1>; Wed, 24 Jul 2002 17:45:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6900 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317619AbSGXVp0>;
	Wed, 24 Jul 2002 17:45:26 -0400
Subject: Re: Linux-2.5.28
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 24 Jul 2002 16:46:27 -0500
Message-Id: <1027547187.7700.67.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Error building 2.5.28:

  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o
--start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o
/usr/src/linux-2.5.28/arch/i386/lib/lib.a lib/lib.a
/usr/src/linux-2.5.28/arch/i386/lib/lib.a drivers/built-in.o
sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `put_cmd640_reg_pci1':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:223: undefined reference to
`save_flags'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:224: undefined reference to
`cli'
drivers/built-in.o: In function `get_cmd640_reg_pci1':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:235: undefined reference to
`save_flags'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:236: undefined reference to
`cli'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:239: undefined reference to
`restore_flags'
drivers/built-in.o: In function `put_cmd640_reg_pci2':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:249: undefined reference to
`save_flags'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:250: undefined reference to
`cli'
drivers/built-in.o: In function `get_cmd640_reg_pci2':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:262: undefined reference to
`save_flags'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:263: undefined reference to
`cli'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:267: undefined reference to
`restore_flags'
drivers/built-in.o: In function `put_cmd640_reg_vlb':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:277: undefined reference to
`save_flags'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:278: undefined reference to
`cli'
drivers/built-in.o: In function `get_cmd640_reg_vlb':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:289: undefined reference to
`save_flags'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:290: undefined reference to
`cli'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:293: undefined reference to
`restore_flags'
drivers/built-in.o: In function `put_cmd640_reg_pci1':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:227: undefined reference to
`restore_flags'
drivers/built-in.o: In function `put_cmd640_reg_pci2':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:254: undefined reference to
`restore_flags'
drivers/built-in.o: In function `put_cmd640_reg_vlb':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:281: undefined reference to
`restore_flags'
drivers/built-in.o: In function `secondary_port_responding':
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:370: undefined reference to
`save_flags'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:371: undefined reference to
`cli'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:379: undefined reference to
`restore_flags'
/usr/src/linux-2.5.28/drivers/ide/cmd640.c:383: undefined reference to
`restore_flags'
make: *** [vmlinux] Error 1


