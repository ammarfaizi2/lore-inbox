Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283758AbRLEFFt>; Wed, 5 Dec 2001 00:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283760AbRLEFFe>; Wed, 5 Dec 2001 00:05:34 -0500
Received: from femail33.sdc1.sfba.home.com ([24.254.60.23]:64412 "EHLO
	femail33.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S283758AbRLEFFQ>; Wed, 5 Dec 2001 00:05:16 -0500
Date: Wed, 5 Dec 2001 00:05:13 -0500
To: linux-kernel@vger.kernel.org
Subject: Fwd: binutils in debian unstable is broken.
Message-ID: <20011205050513.GD1442@cy599856-a.home.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.4.17pre2 i586 K6-3+
X-Uptime: 14:18:59 up 7 min,  1 user,  load average: 0.06, 0.29, 0.18
From: Josh McKinney <forming@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be a kernel bug which is shown with the new version of ld.  Thought I would
forward this along so maybe it can get fixed.

Josh
----- Forwarded message from safemode <safemode@speakeasy.net> -----

Return-path: <bounce-debian-devel=forming=home.com@lists.debian.org>
Delivery-date: Tue, 04 Dec 2001 01:03:50 -0500
X-Envelope-Sender: safemode@speakeasy.net
Subject: binutils in debian unstable is broken.
From: safemode <safemode@speakeasy.net>
To: debian-devel@lists.debian.org
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 01:00:29 -0500
X-Mailing-List: <debian-devel@lists.debian.org> archive/latest/102306
Resent-Bcc:
Status: RO
X-Status: F
Content-Length: 1111
Lines: 31



binutils 2.11.92.0.12.3-1
has a problem compiling any 2.4.x kernel in recent history, ld
specifically.  Last version that did compile was along with gcc version
gcc version 2.95.4 20011006 (Debian prerelease)

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
drivers/pci/driver.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols
in discarded section .text.exit'
make: *** [vmlinux] Error 1



-- 
To UNSUBSCRIBE, email to debian-devel-request@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org


----- End forwarded message -----

-- 
Linux, the choice                | Kites rise highest against the wind -- not 
of a GNU generation       -o)    | with it.   -- Winston Churchill 
Kernel 2.4.17pre2          /\    | 
on a i586                 _\_v   | 
                                 | 
