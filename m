Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288238AbSBGXTf>; Thu, 7 Feb 2002 18:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288985AbSBGXT0>; Thu, 7 Feb 2002 18:19:26 -0500
Received: from dialin-145-254-134-221.arcor-ip.net ([145.254.134.221]:516 "EHLO
	dale.home") by vger.kernel.org with ESMTP id <S288238AbSBGXTO>;
	Thu, 7 Feb 2002 18:19:14 -0500
Date: Fri, 8 Feb 2002 00:18:31 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18-pre8-K2: Kernel panic: CPU context corrupt
Message-ID: <20020208001831.A200@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frozen while compiling galeon (1.1.2, 778 files in ~50Mb),
also had xmms playing something (alsa-0.5.12, Ensoniq AudioPCI ES1371),
and some ssh (slow traffic, NIC Digital Equipment Corporation DECchip 21142/43).
NFS traffic (kernel automounter). XFree86 4.2.0, usb devices (mouse, for example).
Low static electricity.

It looks really bad :(
Ok, continue...

alt-sysrq-b booted, and sync seems also worked:

Feb  7 23:45:31 steel kernel: CPU 0: Machine Check Exception: 0000000000000004
Feb  7 23:45:31 steel kernel: Bank 4: b200000000040151
Feb  7 23:45:31 steel kernel: Kernel panic: CPU context corrupt
Feb  7 23:46:07 steel kernel:  <6>SysRq : Emergency Sync
Feb  7 23:46:07 steel kernel: Syncing device 03:02 ... OK

I've pressed sysrq-s many times, at the moments sound played a second,
two or three times.

No serial console output, sorry, thought the system went stable.

Booted 2.5.4-pre1 before, recovered home reiserfs (--rebuild-tree)
from the mess it left. Rebooted in 2.4.18-pre8-K2. Got the panic.

-alex

P.S. no nasty suspections about processor, please. No funds reserved
for a new one :)

PIII-700, ASUS CUV4X (VIA KT133), <512Mb

ver_linux:

Linux steel 2.4.18-pre8-K2 #2 Thu Feb 7 00:02:26 CET 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.23
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nfs lockd sunrpc ide-cd cdrom snd-seq-midi snd-seq-midi-event snd-seq snd-card-ens1371 snd-ens1371 snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd-mixer snd soundcore autofs4 tulip mousedev usbmouse usb-uhci usbcore input reiserfs ext3 jbd nls_iso8859-1 nls_cp437 vfat fat


