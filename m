Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290293AbSBKT6l>; Mon, 11 Feb 2002 14:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290285AbSBKT6V>; Mon, 11 Feb 2002 14:58:21 -0500
Received: from speech.linux-speakup.org ([129.100.109.30]:56220 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S290284AbSBKT6P>; Mon, 11 Feb 2002 14:58:15 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.4 error building vmlinuz
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 11 Feb 2002 14:58:10 -0500
In-Reply-To: <3C681C1D.9D9819BF@zip.com.au>
Message-ID: <x7sn87pz8t.fsf_-_@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks:  I downloaded the 2.5.4 tar ball and applied a one line
patch by Dave ??? I don't remember his last name.  Most of the kernel
compiled just fine until I got to the loader stage.  I have tried the
compile a number of times removing newer features I had included from
the 2.5.4 configuration.  It continually dies just after the ld
stage.  Here's the log:

ld -m elf_i386 -T /usr/src/linux-2.5.4/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	/usr/src/linux-2.5.4/arch/i386/lib/lib.a /usr/src/linux-2.5.4/lib/lib.a /usr/src/linux-2.5.4/arch/i386/lib/lib.a \
	 drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o \
	net/network.o \
	--end-group \
	-o vmlinux
drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols in discarded section .text.exit'
drivers/net/net.o(.data+0x174): undefined reference to `local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

Once again could someone help the clewless?
  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
