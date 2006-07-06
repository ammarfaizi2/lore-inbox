Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWGFPfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWGFPfx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWGFPfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:35:53 -0400
Received: from ip-140-150.sn2.eutelia.it ([83.211.140.150]:44764 "HELO
	intranet.antek.it") by vger.kernel.org with SMTP id S1030341AbWGFPfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:35:52 -0400
Message-ID: <44AD2DBF.4060200@antek.it>
Date: Thu, 06 Jul 2006 17:35:27 +0200
From: Luca Ognibene <ognibene@antek.it>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ftdi error in /var/log/messages when connecting to gprs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i have an error very often when using a USB modem (from Hamlet) to
connect to gprs. This is the log from /var/log/messages:

Jul  6 17:06:51 aylook012 chat[4783]: Failed (NO CARRIER)
Jul  6 17:06:52 aylook012 pppd[4756]: Modem hangup
Jul  6 17:06:52 aylook012 pppd[4756]: Exit.
Jul  6 17:06:52 aylook012 pppd[4795]: pppd 2.4.3 started by root, uid 0
Jul  6 17:06:52 aylook012 kernel: c01e58c5
Jul  6 17:06:52 aylook012 kernel: Modules linked in: ppp_deflate
zlib_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc ftdi_sio
usbserial bttv video_buf firmware_class v4l2_common btcx_risc tveeprom
videodev i2c_algo_bit i2c_core snd_intel8x0 snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc sd_mod
pcmcia yenta_socket rsrc_nonstatic pcmcia_core ipv6 ipt_REJECT ipt_LOG
ipt_state ipt_pkttype ipt_recent ipt_iprange ipt_physdev ipt_multiport
ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp
iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack
iptable_filter ip_tables ohci_hcd usbcore sata_sis libata scsi_mod
8139too mii ide_cd cdrom rtc ext3 jbd ide_disk ide_generic via82cxxx
trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix
pdc202xx_old opti621 ns87415 hpt366 hpt34x
generic cy82c693 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx
pdc202xx_new ide_core unix fbcon tileblit font bitblit
vesafb cfbcopyarea cfbimgblt
Jul  6 17:06:52 aylook012 kernel: fbfillrect softcursor capability commoncap
Jul  6 17:06:52 aylook012 kernel: CPU:    0
Jul  6 17:06:52 aylook012 kernel: EIP:    0060:[tty_get_baud_rate+5/76]
   Not tainted VLI
Jul  6 17:06:52 aylook012 kernel: EFLAGS: 00010282   (2.6.12-1-386)
Jul  6 17:06:52 aylook012 kernel: EIP is at tty_get_baud_rate+0x5/0x4c
Jul  6 17:06:52 aylook012 pppd[4797]: pppd 2.4.3 started by root, uid 0
Jul  6 17:06:52 aylook012 pppd[4797]: Removed stale lock on modem (pid 4795)
Jul  6 17:06:52 aylook012 kernel: eax: cb14ca00   ebx: 00000000   ecx:
cef2f080   edx: cef2a000
Jul  6 17:06:52 aylook012 kernel: esi: cb14ca00   edi: cb14f580   ebp:
cef2f080   esp: c42a5e34
Jul  6 17:06:52 aylook012 kernel: ds: 007b   es: 007b   ss: 0068
Jul  6 17:06:52 aylook012 kernel: Process pppd (pid: 4795,
threadinfo=c42a4000 task=c26ee020)
Jul  6 17:06:52 aylook012 kernel: Stack: cea28f40 cfb3e279 00000000
cea28f40 cb14ca00 cb14f580 cfb3e205 cb14ca00
Jul  6 17:06:52 aylook012 kernel:        00000008 80000cbd cb14f580
ce712c00 cfb3ff15 cb14ca00 00000000 8000007b
Jul  6 17:06:52 aylook012 kernel:        cb14f580 cb14ca00 cb14ca00
ce712c00 cfb3eecb cb14ca00 c42a5e90 ce53695c
Jul  6 17:06:52 aylook012 kernel: Call Trace:
Jul  6 17:06:52 aylook012 kernel:  [pg0+259613305/1069900800]
get_ftdi_divisor+0x15/0x2b8 [ftdi_sio]
Jul  6 17:06:52 aylook012 kernel:  [pg0+259613189/1069900800]
change_speed+0x29/0x88 [ftdi_sio]
Jul  6 17:06:52 aylook012 kernel:  [pg0+259620629/1069900800]
ftdi_set_termios+0x201/0x574 [ftdi_sio]
Jul  6 17:06:52 aylook012 kernel:  [pg0+259616459/1069900800]
ftdi_open+0x77/0x160 [ftdi_sio]
Jul  6 17:06:52 aylook012 kernel:  [link_path_walk+86/244]
link_path_walk+0x56/0xf4
Jul  6 17:06:52 aylook012 kernel:  [pg0+259654503/1069900800]
serial_open+0x7b/0xfc [usbserial]
Jul  6 17:06:52 aylook012 kernel:  [tty_open+250/700] tty_open+0xfa/0x2bc
Jul  6 17:06:52 aylook012 kernel:  [chrdev_open+107/304]
chrdev_open+0x6b/0x130
Jul  6 17:06:52 aylook012 kernel:  [dentry_open+178/460]
dentry_open+0xb2/0x1cc
Jul  6 17:06:52 aylook012 kernel:  [filp_open+70/80] filp_open+0x46/0x50
Jul  6 17:06:52 aylook012 kernel:  [__fput+157/236] __fput+0x9d/0xec
Jul  6 17:06:52 aylook012 kernel:  [sys_open+47/104] sys_open+0x2f/0x68
Jul  6 17:06:52 aylook012 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  6 17:06:52 aylook012 kernel: Code: ef 89 43 08 8b 04 95 20 52 30 c0
5b c3 90 8d 4a 0f 3b 0d 9c 52 30 c0 77 e5 89 ca 8b 04 95 20 52 30 c0 5b
c3 89 f6 53 8b 5c 24 08 <ff> 73 68 e8 af ff ff ff 5a 3d 00 96 00 00 74
03 5b c3 90 8b 93
Jul  6 17:06:52 aylook012 kernel:  <1>Unable to handle kernel NULL
pointer dereference at virtual address 00000084
Jul  6 17:06:52 aylook012 kernel: cfb48bac

Motherboard: Asus P5S800-VM
Modem (from lsusb):
Bus 002 Device 002: ID 0403:6001 Future Technology Devices
International, Ltd 8-bit FIFO
Linux: i'm using a Debian sarge (kernel 2.6.8), i've also tried with a
2.6.16 from debian backport (the log is using 2.6.16)

Any idea on what can be wrong?
(please CC me as i'm not subscribed to the list)

ciao
Luca
