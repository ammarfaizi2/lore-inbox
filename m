Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVH0DVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVH0DVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 23:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVH0DVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 23:21:45 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:17273 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030289AbVH0DVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 23:21:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:Reply-To:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=uMrWG1vYICEU4t+wkZfp05eCrzBCdw1jdpGPgs0OiaCgQoDphSEdxK5bJt+Tj7AowYqbZ9Gce3fdBSVzqNKQmWFtieQw687KKMzFTUM963+icvFZD3kgesK9WaX02E5SrN1X3Cwn6sdX13zYQT0iIRBhUjKe6Irmb8pH8RbhhIc=  ;
From: Marek W <marekw1977@yahoo.com.au>
Reply-To: marekw1977@yahoo.com.au
To: linux-kernel@vger.kernel.org
Subject: No DMA with ASUS W3030V - ahci/ata_piix issue? Workarounds?
Date: Sat, 27 Aug 2005 13:23:11 +1000
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508271323.11863.marekw1977@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am having problems with DMA access on my laptops drives. My research so far 
indicates that this is likely to be an issue with the current state of ahci 
development.

There are no BIOS options available for the IDE that are suggested in 
workarounds.

Is there anything I can do to enable DMA for IDE drives, enable/disbale 
options in the kernel?

Any help greatly appreciated.

Kind regards,

The laptop: ASUS W3030V.
Kernel: 2.6.12-gentoo-sources-r9

lspci output:

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express 
Processor to DRAM Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express 
Root Port (rev 03)
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
High Definition Audio Controller (rev 04)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 1 (rev 04)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface 
Bridge (rev 04)
0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller 
(rev 04)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
SMBus Controller (rev 04)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc M24 1P [Radeon 
Mobility X600]
0000:03:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 
Gigabit Ethernet Controller (rev 13)
0000:03:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
0000:03:01.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller 
(rev 08)
0000:03:01.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter 
(rev 17)
0000:03:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host 
Adapter (rev 08)
0000:03:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 
05)

lsmod output:

Module                  Size  Used by
michael_mic             2368  2
arc4                    1600  2
ieee80211_crypt_tkip     9600  2
md5                     3712  1
ipv6                  244608  13
eth1394                17224  0
pcmcia                 21576  2
ohci_hcd               33284  0
psmouse                28804  0
rtc                    10872  0
ipw2200               172552  0
ieee80211              44548  1 ipw2200
ieee80211_crypt         4868  3 ieee80211_crypt_tkip,ipw2200,ieee80211
ohci1394               32052  0
ieee1394              291064  2 eth1394,ohci1394
yenta_socket           20296  1
rsrc_nonstatic          9792  1 yenta_socket
pcmcia_core            42504  3 pcmcia,yenta_socket,rsrc_nonstatic
skge                   33424  0
radeonfb               88128  0
i2c_algo_bit            8520  1 radeonfb
i2c_i801                7564  0
ehci_hcd               43592  0
uhci_hcd               30284  0
evdev                   7552  0
snd_seq                50128  0
snd_seq_device          6860  1 snd_seq
usbcore               118780  4 ohci_hcd,ehci_hcd,uhci_hcd
ntfs                  211252  1
isofs                  32184  0
zlib_inflate           17600  1 isofs
ide_cd                 37956  0
cdrom                  38432  1 ide_cd
cpufreq_userspace       3548  0
cpufreq_powersave       1472  0
cpufreq_ondemand        5276  1
cpufreq_conservative     6308  0
snd_hda_intel          12576  1
snd_hda_codec          56448  1 snd_hda_intel
snd_pcm                84296  2 snd_hda_intel,snd_hda_codec
snd_timer              21892  2 snd_seq,snd_pcm
snd                    45924  8 
snd_seq,snd_seq_device,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
soundcore               7584  1 snd
snd_page_alloc          7620  2 snd_hda_intel,snd_pcm
video                  13892  0
thermal                10504  0
fan                     3204  0
battery                 7556  0
acpi_cpufreq            4868  1
freq_table              3524  1 acpi_cpufreq
processor              18228  2 thermal,acpi_cpufreq
ac                      3396  0
asus_acpi               9556  0
radeon                 76224  0
drm                    61012  1 radeon
intel_agp              20444  1
agpgart                29512  2 drm,intel_agp
ata_piix                7364  0
libata                 42436  1 ata_piix
scsi_mod               85064  1 libata


-- 

Marek W

==========
(2b | !2b)
==========
Send instant messages to your online friends http://au.messenger.yahoo.com 
