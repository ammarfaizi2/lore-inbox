Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTKQURh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTKQURh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:17:37 -0500
Received: from ghost.anime.pl ([81.219.64.71]:32896 "EHLO ghost.anime.pl")
	by vger.kernel.org with ESMTP id S263700AbTKQURf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:17:35 -0500
Date: Mon, 17 Nov 2003 21:16:47 +0100
To: linux-kernel@vger.kernel.org
Cc: cltien@cmedia.com.tw
Subject: PROBLEM: kernel panic with cmpci audio driver
Message-ID: <20031117201647.GA2081@ghost.anime.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Weather: Zbiera sie na burze, aczkolwiek nie mielismy jeszcze trzesienia ziemi
From: Dariush Pietrzak <eyck@ghost.anime.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 My kernel (2.4.23-rc1-xfs) panics every time I send ^c to mpg123 program.
It says 'Aii, killing interrupt handler', and then goes on looping showing
<e48dd9ed> <e38dda4e> <co108..> etc..
 I replaced cmpci.c file with the one found in wolk4.9 ( this file is older
- revision 5.64 - ) and now the kernel seems stable.

Background info:
Linux ghost 2.4.23-rc1-xfs #1 Mon Nov 17 20:21:26 CET 2003 i686 unknown
 
 Gnu C                  2.95.4
 Gnu make               3.79.1

 util-linux             2.11n
 mount                  2.11n
 modutils               2.4.15
 e2fsprogs              1.27
 Linux C Library        2.2.5
 Dynamic linker (ldd)   2.2.5
 Procps                 2.0.7
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               2.0.11
 Modules Loaded         irtty irda sd_mod sg sr_mod binfmt_misc tun smbfs
 sch_htb ipt_multiport ipt_state ipt_MASQUERADE iptable_mangle
 iptable_filter iptable_nat ip_conntrack ip_tables serial isa-pnp softdog
 i810_audio ac97_codec cmpci soundcore i2c-proc i2c-core nbd radeon agpgart
 eepro100 winbond-840 mii ide-scsi keybdev usbkbd input usb-storage
 scsi_mod usb-ohci usbcore

eyck@ghost:~$ dmesg|grep cmpc
cmpci: version $Revision: 5.64 $ time 20:34:49 Nov 17 2003
cmpci: found CM8738 adapter at io 0xd400 irq 11
cmpci: chip version = 039
cmpci: Enable SPDIF loop

sending ^c to mpg123 causes it to close the file it's playing and start
playing next one on playlist.

-- 
Key fingerprint = 40D0 9FFB 9939 7320 8294  05E0 BCC7 02C4 75CC 50D9
Namagumi namagomi namagoroshi
