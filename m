Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWDVUux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWDVUux (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDVUux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:50:53 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52180 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751184AbWDVUuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:50:52 -0400
From: thomas klein <tkl@laposte.net>
To: linux-kernel@vger.kernel.org
Subject: sky2 driver network freeze while transfering data
Date: Sat, 22 Apr 2006 12:45:44 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604221245.44894.tkl@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pitfall@archon:~/kernel/linux-2.6.16.9$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux archon 2.6.15-20-686 #1 SMP PREEMPT Tue Apr 4 18:37:00 UTC 2006 
i686 GNU/Linux

Gnu C                  4.0.3
Gnu make               3.81beta4
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.7.7
pcmcia-cs              3.2.8
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
udev                   079pitfall@archon:~/kernel/linux-2.6.16.9$ sh 
scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux archon 2.6.15-20-686 #1 SMP PREEMPT Tue Apr 4 18:37:00 UTC 2006 
i686 GNU/Linux

Gnu C                  4.0.3
Gnu make               3.81beta4
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.7.7
pcmcia-cs              3.2.8
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
udev                   079
Modules Loaded         binfmt_misc rfcomm l2cap bluetooth sonypi 
speedstep_centrino cpufreq_userspace cpufreq_stats freq_table 
cpufreq_powersave cpufreq_ondemand cpufreq_conservative video 
tc1100_wmi sony_acpi pcc_acpi hotkey dev_acpi container button 
acpi_sbs battery ac i2c_acpi_ec ipv6 dm_mod af_packet md_mod sr_mod 
sbp2 parport_pc lp parport pcmcia joydev yenta_socket rsrc_nonstatic 
ohci1394 sky2 pcmcia_core ieee1394 nvidia i2c_core rtc psmouse 
serio_raw snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss 
snd_pcm snd_timer snd soundcore snd_page_alloc shpchp pci_hotplug 
intel_agp agpgart tsdev evdev sg usbhid ext3 jbd ide_generic ehci_hcd 
uhci_hcd usbcore sd_mod ata_piix libata scsi_mod ide_cd cdrom piix 
generic thermal processor fan capability commoncap vga16fb vgastate 
fbcon tileblit font bitblit softcursor
Modules Loaded         binfmt_misc rfcomm l2cap bluetooth sonypi 
speedstep_centrino cpufreq_userspace cpufreq_stats freq_table 
cpufreq_powersave cpufreq_ondemand cpufreq_conservative video 
tc1100_wmi sony_acpi pcc_acpi hotkey dev_acpi container button 
acpi_sbs battery ac i2c_acpi_ec ipv6 dm_mod af_packet md_mod sr_mod 
sbp2 parport_pc lp parport pcmcia joydev yenta_socket rsrc_nonstatic 
ohci1394 sky2 pcmcia_core ieee1394 nvidia i2c_core rtc psmouse 
serio_raw snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss 
snd_pcm snd_timer snd soundcore snd_page_alloc shpchp pci_hotplug 
intel_agp agpgart tsdev evdev sg usbhid ext3 jbd ide_generic ehci_hcd 
uhci_hcd usbcore sd_mod ata_piix libata scsi_mod ide_cd cdrom piix 
generic thermal processor fan capability commoncap vga16fb vgastate 
fbcon tileblit font bitblit softcursor


This is the stock kernel I'm using... I tried the latest 2.6.16.9, the 
problem was the same.

Problem : 
0000:07:00.0 Ethernet controller: Marvell Technology Group Ltd. 
88E8036 Fast Ethernet Controller (rev 15)

I can browse the web, check emails etc... but, If I try some rsync 
from my old laptop (to backup my stuff) the network freeze after 1 or 
2minutes.
the bug is reproductible.
I don't have logs each time, but, sometimes I got this
 Apr 15 11:35:42 archon kernel: [4297572.802000] NETDEV WATCHDOG: 
eth0: transmit timed out
 Apr 15 11:35:42 archon kernel: [4297572.802000] sky2 hardware hung? 
flushing

same freeze with the 2.6.16.9


thanks in advance,

thomas.

PS : I didn't subscribe any linux ml, can I see any progress on this 
report somewhere ?
