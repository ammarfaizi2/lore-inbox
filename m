Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTJYW5b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 18:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbTJYW5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 18:57:31 -0400
Received: from ns2.onda.com.br ([200.195.199.2]:24018 "EHLO
	maresia.onda.com.br") by vger.kernel.org with ESMTP id S263125AbTJYW5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 18:57:20 -0400
Message-ID: <1067122647.3f9affd774c42@webmail.onda.com.br>
Date: Sat, 25 Oct 2003 20:57:27 -0200
From: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.6.0-test9
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ106712264799ebf782a8bece93fd71bf221d83bead"
User-Agent: Internet Messaging Program (IMP) 3.0
X-WebMail-Company: Onda Provedor de  =?ISO-8859-1?Q?=20Servi=E7os?= S/A.
X-Originating-IP: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ106712264799ebf782a8bece93fd71bf221d83bead
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Please cc me as i'm not subscribed to lkml.
TIA.

irq 18: nobody cared!
Call Trace:
 [] __report_bad_irq+0x2a/0x8b
 [] note_interrupt+0x6f/0x9f
 [] do_IRQ+0x187/0x1d5
 [] default_idle+0x0/0x2d
 [] common_interrupt+0x18/0x20
 [] default_idle+0x0/0x2d
 [] default_idle+0x2a/0x2d
 [] cpu_idle+0x37/0x40
 [] _stext+0x0/0x65
 [] start_kernel+0x17e/0x19c
 [] unknown_bootoption+0x0/0xff
 
handlers:
[] (ide_intr+0x0/0x1ce)
[] (ide_intr+0x0/0x1ce)
Disabling IRQ #18
hquest@phoenix:~$ _
Message from syslogd@phoenix at Sat Oct 25 20:49:19 2003 ...
phoenix last message repeated 10 times
 
Message from syslogd@phoenix at Sat Oct 25 20:50:24 2003 ...
phoenix last message repeated 20 times
 
Message from syslogd@phoenix at Sat Oct 25 20:51:25 2003 ...
phoenix last message repeated 12 times

Hardware is Asus P4P800 Deluxe, CPU P4 2.4C HT enabled. No S-ATA devices attached.

/sbin/lspci
00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller (rev 02)
00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller (rev
02)00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev
02)00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio Controller
(rev 02)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5
(rev 01)
02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller
(rev 46)
02:04.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3164 (rev 06)
02:05.0 Ethernet controller: 3Com Corporation 3c940 1000Base? (rev 12)
02:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture
(rev 11)
02:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
02:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
hquest@phoenix:~$ lsmod
Module                  Size  Used by
tdfx                   38424  2
snd_pcm_oss            53380  0
snd_mixer_oss          19712  2 snd_pcm_oss
ipt_REJECT              7808  72
cls_fw                  6784  2
sch_cbq                18816  1
ipt_MARK                2560  4
ipt_TOS                 2944  1
ipt_MASQUERADE          4864  7
ipt_REDIRECT            2688  0
ipt_LOG                 6272  75
ipt_length              2176  4
ipt_state               2432  11
ip_nat_irc              4976  0
ip_conntrack_irc       71828  1 ip_nat_irc
ip_nat_ftp              5744  0
ip_conntrack_ftp       72724  1 ip_nat_ftp
iptable_mangle          3328  1
iptable_filter          3328  1
iptable_nat            23460  5 ipt_MASQUERADE,ipt_REDIRECT,ip_nat_irc,ip_nat_ftp
ip_conntrack           34592  8
ipt_MASQUERADE,ipt_REDIRECT,ipt_state,ip_nat_irc,ip_conntrack_irc,ip_nat_ftp,ip_conntrack_ftp,iptable_nat
ip_tables              19472  11
ipt_REJECT,ipt_MARK,ipt_TOS,ipt_MASQUERADE,ipt_REDIRECT,ipt_LOG,ipt_length,ipt_state,iptable_mangle,iptable_filter,iptable_nat
md5                     4480  1
ipv6                  275456  16
ppp_synctty            10368  0
ppp_async              12416  1
ppp_generic            33672  6 ppp_synctty,ppp_async
slhc                    7680  1 ppp_generic
ehci_hcd               25472  0
usbcore               111956  3 ehci_hcd
sk98lin               162912  1
w83781d                34688  0
i2c_sensor              3584  1 w83781d
tuner                  15876  0
tvaudio                22784  0
bttv                  137760  0
video_buf              23168  1 bttv
i2c_algo_bit           10888  1 bttv
btcx_risc               5380  1 bttv
i2c_core               25860  6 w83781d,i2c_sensor,tuner,tvaudio,bttv,i2c_algo_bit
v4l2_common             5248  1 bttv
videodev               10240  1 bttv
isofs                  36028  0
zlib_inflate           22656  1 isofs
ide_scsi               15744  0
ide_cd                 40960  0
cdrom                  35232  1 ide_cd
capability              4484  0
commoncap               7296  1 capability
psmouse                18316  0
snd_intel8x0           32836  4
snd_ac97_codec         54660  1 snd_intel8x0
snd_pcm               102144  3 snd_pcm_oss,snd_intel8x0
snd_timer              27008  1 snd_pcm
snd_page_alloc         12164  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         8704  1 snd_intel8x0
snd_rawmidi            25856  1 snd_mpu401_uart
snd_seq_device          8580  1 snd_rawmidi
snd                    51844  14
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               9920  3 bttv,snd
rtc                    14664  0
nls_iso8859_1           4608  1
nls_cp437               6272  1
vfat                   16640  1
fat                    47008  1 vfat
hquest@phoenix:~$ _

-- 
dual_bereta_r0x -- Alexandre Hautequest
ArenaNetwork Lan House & Cyber -- www.arenanetwork.com.br
ICQ 126063524

---MOQ106712264799ebf782a8bece93fd71bf221d83bead
Content-Type: application/x-gzip; name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
p3ChryHFTGJ4CsH//wJKnBg6sH4AAA==

---MOQ106712264799ebf782a8bece93fd71bf221d83bead--

