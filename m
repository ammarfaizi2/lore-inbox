Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318768AbSH1Kg1>; Wed, 28 Aug 2002 06:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSH1Kg1>; Wed, 28 Aug 2002 06:36:27 -0400
Received: from lars.internetia.pl ([195.114.173.133]:10165 "EHLO
	lars.internetia.pl") by vger.kernel.org with ESMTP
	id <S318768AbSH1Kg0>; Wed, 28 Aug 2002 06:36:26 -0400
Date: Wed, 28 Aug 2002 12:40:32 +0200 (CEST)
From: Piotr Roszatycki <Piotr_Roszatycki@netia.net.pl>
X-X-Sender: dexter@ginger.loc.internetia.pl
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre4-ac2 and ide.o module
Message-ID: <Pine.LNX.4.44.0208281233340.19668-100000@ginger.loc.internetia.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *17k0FV-0006g4-00*kyQR59NgtNA* (Netia Telekom S.A.)
X-Score-Reason: [30] message_body matches remove.+(subject|request|list)
X-Score-Reason: [5] message_body matches remove
X-Score-Reason: [100] h_X-Mailer:h_User-Agent does not match .+
X-Score-Reason: [-100] h_Message-ID: matches ^<PINE\.
X-Score: 215
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't compile IDE kernel modules.

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
/root/kernellabo/tmp/kernel-source-2.4.19/debian/tmp-image -r
2.4.20-pre4-ac2-pentiumiii; fi
depmod: *** Unresolved symbols in
/root/kernellabo/tmp/kernel-source-2.4.19/debian/tmp-image/lib/modules/2.4.20-pre4-ac2-pentiumiii/kernel/drivers/ide/ide-disk.o
depmod:         proc_ide_read_geometry_Rsmp_50fed6f7
depmod:         ide_remove_proc_entries_Rsmp_f0768acf
depmod: *** Unresolved symbols in
/root/kernellabo/tmp/kernel-source-2.4.19/debian/tmp-image/lib/modules/2.4.20-pre4-ac2-pentiumiii/kernel/drivers/ide/ide-floppy.o
depmod:         proc_ide_read_geometry_Rsmp_50fed6f7
depmod:         ide_remove_proc_entries_Rsmp_f0768acf
depmod: *** Unresolved symbols in
/root/kernellabo/tmp/kernel-source-2.4.19/debian/tmp-image/lib/modules/2.4.20-pre4-ac2-pentiumiii/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         create_proc_ide_interfaces_Rsmp_ab2c600e
depmod: *** Unresolved symbols in
/root/kernellabo/tmp/kernel-source-2.4.19/debian/tmp-image/lib/modules/2.4.20-pre4-ac2-pentiumiii/kernel/drivers/ide/ide-tape.o
depmod:         ide_remove_proc_entries_Rsmp_f0768acf
depmod: *** Unresolved symbols in
/root/kernellabo/tmp/kernel-source-2.4.19/debian/tmp-image/lib/modules/2.4.20-pre4-ac2-pentiumiii/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         proc_ide_create_Rsmp_a8e0f104
depmod:         cmd640_vlb
depmod:         ide_probe_for_cmd640x
depmod:         ide_scan_pcibus
depmod:         create_proc_ide_interfaces_Rsmp_ab2c600e
depmod:         destroy_proc_ide_drives_Rsmp_1e6e30aa
depmod:         proc_ide_read_capacity_Rsmp_46b2a30d
depmod:         proc_ide_destroy_Rsmp_35e1351c
depmod:         ide_remove_proc_entries_Rsmp_f0768acf
depmod:         ide_add_proc_entries_Rsmp_bf99dbe4
make[2]: *** [_modinst_post] Error 1

I guess there are still a lot of missing EXPORTs, but I'd be glad to know
if anybody take care of them. Missing EXPORTs for IDE modules are a common
problem, but first time I see so many errors.

-- 
Piotr Roszatycki, Netia Telekom S.A.                    .''`.
mailto:Piotr_Roszatycki@netia.net.pl                   : :' :
mailto:dexter@debian.org                               `. `'
                                                         `-

