Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281682AbRKQCTF>; Fri, 16 Nov 2001 21:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281683AbRKQCSz>; Fri, 16 Nov 2001 21:18:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:52927 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S281682AbRKQCSr>;
	Fri, 16 Nov 2001 21:18:47 -0500
Date: Fri, 16 Nov 2001 18:15:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Tony Reed <Tony@TRLJC.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: It's me again ...
Message-ID: <20011116181521.F21354@mikef-linux.matchmail.com>
Mail-Followup-To: Tony Reed <Tony@TRLJC.COM>, linux-kernel@vger.kernel.org
In-Reply-To: <20011117015851.531B415B4A@kubrick.trljc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011117015851.531B415B4A@kubrick.trljc.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2001 at 08:58:51PM -0500, Tony Reed wrote:
> I've been building kernels since 2.2.15 or something, and I've never
> had problems before, so bear with me.
> 
> Where is "deacivate_page" defined?  Because, right at the end, I'm
> getting:
> 
> ld -m elf_i386 -T /usr/src/linux-2.4.14/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o arch/i386/math-emu/math.o \
>         net/network.o \
>         /usr/src/linux-2.4.14/linux/arch/i386/lib/lib.a /usr/src/linux-2.4.14/linux/lib/lib.a /usr/src/linux-2.4.14/linux/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0xa8ad): undefined reference to `deactivate_page'
> drivers/block/block.o(.text+0xa8f9): undefined reference to `deactivate_page'
> make: *** [vmlinux] Error 1
> 
> 
> So I'm kinda stuck.  

There is a problem in loop.c that references deactivate_page.  This is
probably related.

deactivate_page by linus in 2.4.14, while it was in 2.4.14-pre8, the last
pre for 2.4.14.... :(

Mike
