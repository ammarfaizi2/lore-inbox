Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291531AbSBAEMo>; Thu, 31 Jan 2002 23:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291530AbSBAEMd>; Thu, 31 Jan 2002 23:12:33 -0500
Received: from mx3.fuse.net ([216.68.1.123]:52677 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id <S291529AbSBAEM1>;
	Thu, 31 Jan 2002 23:12:27 -0500
Message-ID: <3C5A159F.2010108@fuse.net>
Date: Thu, 31 Jan 2002 23:12:15 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [Fwd: Re: Linux 2.5.3-dj1]
Content-Type: multipart/mixed;
 boundary="------------060308010404020802020801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060308010404020802020801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060308010404020802020801
Content-Type: message/rfc822;
 name="Re: Linux 2.5.3-dj1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: Linux 2.5.3-dj1"


>From - Thu Jan 31 23:07:29 2002
X-Mozilla-Status2: 00000000
Message-ID: <3C5A147F.6040800@fuse.net>
Date: Thu, 31 Jan 2002 23:07:27 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
Subject: Re: Linux 2.5.3-dj1
In-Reply-To: <20020201013930.A24971@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dave Jones wrote:

>And we start all over again.. Sync against 2.5.3, and merge some
>more pending items. Hopefully this fixes the reiserfs issues
>that popped up in -dj7 (but mysteriously not in mainline).
>please report reiserfs success/failure stories.
>
>Patch against 2.5.3 vanilla is available from:
>ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/
>
> -- Davej.
>
[snip]

Compiling with ZISOFS I get an undefined reference to "zisofs_cleanup":

ld -m elf_i386 -T 
/home/expsoft/src/linux-kernel/linux-2.5/linux-2.5.3-dj1-nwf/arch/i386/vmlinux.lds 
-e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o 
init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
        
/home/expsoft/src/linux-kernel/linux-2.5/linux-2.5.3-dj1-nwf/arch/i386/lib/lib.a 
/home/expsoft/src/linux-kernel/linux-2.5/linux-2.5.3-dj1-nwf/lib/lib.a 
/home/expsoft/src/linux-kernel/linux-2.5/linux-2.5.3-dj1-nwf/arch/i386/lib/lib.a 
\
         drivers/acpi/acpi.o drivers/base/base.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o 
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o 
drivers/pnp/pnp.o drivers/video/video.o drivers/input/inputdrv.o 
drivers/input/serio/seriodrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
fs/fs.o: In function `init_iso9660_fs':
fs/fs.o(.text.init+0xe71): undefined reference to `zisofs_cleanup'
make: *** [vmlinux] Error 1

Kernel is patched thus:
2.5.3
2.5.3-dj1
preempt-kernel-2.5.3-1
acpi-2.4.17 (again missing some Configure.help entries, manually deleted 
acpitable.c from arch/i386/kernel)
acpi-pci-irq-routing patch

Thanks!

--Nathan



--------------060308010404020802020801--


