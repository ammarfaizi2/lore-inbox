Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759723AbWLDV1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759723AbWLDV1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759726AbWLDV1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:27:23 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:54354 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759723AbWLDV1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:27:22 -0500
Message-ID: <457492B2.2050107@ccr.jussieu.fr>
Date: Mon, 04 Dec 2006 22:27:14 +0100
From: Bernard Pidoux <pidoux@ccr.jussieu.fr>
Organization: Universite Pierre & Marie Curie - Paris 6
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why SCSI module needed for PCI-IDE ATA only disks ?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am asking why need to compile the following modules while I do not
have any SCSI device ?

Modules Loaded

rose netrom mkiss ax25 crc16 mach64 drm nfsd exportfs lockd nfs_acl
sunrpc ipv6 snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
ne2k_pci 8390 snd_pcm_oss snd_mixer_oss snd_ens1371 gameport snd_rawmidi
snd_seq_device snd_ac97_codec snd_ac97_bus af_packet snd_pcm snd_timer
snd_page_alloc snd soundcore floppy ide_cd binfmt_misc loop supermount

ahci ata_piix libata scsi_mod dm_mod

cpufreq_ondemand cpufreq_conservative cpufreq_powersave speedstep_lib
freq_table intel_agp agpgart uhci_hcd usbcore evdev tsdev ext3 jbd

Hardware is :

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
00:0d.0 Mass storage controller: Promise Technology, Inc. PDC20262
(FastTrak66/Ultra66) (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c)

ata_piix needs scsi_mod

When making menuconfig, the need to select SCSI submenu options seems
rather surprising to me for an IDE ATA disk only system.

Bernard Pidoux

