Return-Path: <linux-kernel-owner+w=401wt.eu-S1753011AbWLXWCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbWLXWCJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 17:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbWLXWCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 17:02:09 -0500
Received: from squawk.glines.org ([72.36.206.66]:40486 "EHLO squawk.glines.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbWLXWCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 17:02:08 -0500
X-Greylist: delayed 1979 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 17:02:08 EST
Message-ID: <458EF11B.5030509@glines.org>
Date: Sun, 24 Dec 2006 13:28:59 -0800
From: Mark Glines <mark@glines.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061221)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2: forgot how to make a zImage on powerpc?
References: <fa.tciB/Sye1gyFArGtVgaZAmdArxQ@ifi.uio.no>
In-Reply-To: <fa.tciB/Sye1gyFArGtVgaZAmdArxQ@ifi.uio.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> (much of the latter syntactic cleanups). And arm and powerpc updates.

Hmm.  I'm trying to build 2.6.20-rc2 on a little powerpc box with 
arch/powerpc/configs/linkstation_defconfig, and I get:

paranoid@kuro-2 /usr/src/linux $ make zImage
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/basic/docproc
   HOSTCC  scripts/kconfig/conf.o
   HOSTCC  scripts/kconfig/kxgettext.o
[snip lots of buildspam]
   LD      lib/zlib_deflate/built-in.o
   LD      lib/zlib_inflate/built-in.o
   GEN     .version
   LD      .tmp_vmlinux1
   KSYM    .tmp_kallsyms1.S
   AS      .tmp_kallsyms1.o
   LD      .tmp_vmlinux2
   KSYM    .tmp_kallsyms2.S
   AS      .tmp_kallsyms2.o
   LD      vmlinux
   SYSMAP  System.map
   SYSMAP  .tmp_System.map
   MODPOST vmlinux
ln: accessing `arch/powerpc/boot/zImage': No such file or directory
make[1]: *** [arch/powerpc/boot/zImage] Error 1
make: *** [zImage] Error 2

So, uh, are we forgetting to go into the right subdirectory to make the 
actual zImage, or what?  If I'm just doing something wrong, I'd love to 
know what it is.

I'll follow up here on lkml if I diagnose this further.  Thanks,

Mark

