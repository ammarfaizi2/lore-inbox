Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUEELSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUEELSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 07:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUEELSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 07:18:47 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:36808 "EHLO
	mailfe05.swip.net") by vger.kernel.org with ESMTP id S264530AbUEELSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 07:18:43 -0400
X-T2-Posting-ID: BRDanst2gKhoMyJYeX8opk+mB0Q5BdOtN5BQ9BTnzIE=
From: Daniel Moyne <dmoyne@tiscali.fr>
Organization: home
To: linux-kernel@vger.kernel.org
Subject: [bug kernel 2.6 / USB / SCSI] report
Date: Wed, 5 May 2004 13:18:49 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405051318.50204.dmoyne@tiscali.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is my bug report :

a) data of my system

Linux azun.home.fr 2.6.3-4mdk #1 Tue Mar 2 07:26:13 CET 2004 i686 unknown 
unknown GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.34
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.1.2
Modules Loaded         sg autofs4 tdfx lp md5 ipv6 snd-seq-midi 
snd-emu10k1-synth snd-emux-synth snd-seq-virmidi snd-seq-midi-emul 
snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-emu10k1 
snd-rawmidi snd-pcm snd-timer snd-seq-device snd-ac97-codec snd-page-alloc 
snd-util-mem snd-hwdep snd soundcore ppp_synctty ppp_async ppp_generic slhc 
af_packet hid sr_mod raw ide-floppy ide-tape ide-cd cdrom floppy 8139too mii 
supermount via-agp agpgart ppa parport_pc imm parport usblp ehci-hcd uhci-hcd 
usbcore rtc ext3 jbd sd_mod dc395x scsi_mod

Other :
distribution : MDK 10.0 Community kernel 2.6.3-4mdk
Motherboard : MSI K7T Turbo 2 with CPU AMD Duron 1 GHz

b) problems :
2.4.x works fine.
2.6.x is much faster but shows some problems with USB and SCSI drives.

USB :

- the only way to get my USB printer recognized is to use the following 
modules (from lsmod) :
usblp                  12256  0
ehci-hcd               24196  0
uhci-hcd               29104  0
usbcore                99132  6 hid,usblp,ehci-hcd,uhci-hcd

and set the following "append" option in lilo :
	append="devfs=mount noapic resume=/dev/hda5"
what is relevant here is obviously the "noapic" option ("apic=ht" works fine 
for kernel 2.4.x)

- ohci does not work !

SCSI / CD drives :

- following some recommandations I removed the SCSI IDE mulation from both 
"lilo.conf" and "modules.conf" files.

- both K3b and XCDroast cannot locate my SCSI CD drives : K3b gets stuck from 
the very beginning when searching CD devices and XCDroast finds my IDE drive 
but then gets stuck also.

- GCombust works fine

I am willing to answer your questions to pursue diagnosing the various 
problems.
Regards.
-- 
Daniel Moyne (Nulix)----------------------------------------------------------
Software : Mandrake 10.0 Community \\|//    kernel "2.6.3-4mdk"
KDE 3.2                           / --- \
                                 (' o-o ')
--------------------------------oOO-(_)-OOo-----------------------------------
