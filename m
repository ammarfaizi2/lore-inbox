Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSGaSdb>; Wed, 31 Jul 2002 14:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318441AbSGaSdb>; Wed, 31 Jul 2002 14:33:31 -0400
Received: from mail01d.rapidsite.net ([207.158.192.52]:29121 "HELO
	mail01d.rapidsite.net") by vger.kernel.org with SMTP
	id <S318440AbSGaSd2>; Wed, 31 Jul 2002 14:33:28 -0400
Message-ID: <3D482E45.2040809@theworld.com>
Date: Wed, 31 Jul 2002 14:36:53 -0400
From: John Muir Kumph <ninjo@theworld.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1a) Gecko/20020611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: un killable processes - stuck file system
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me if this is the wrong place to send this bug report - but
here goes:

I have a DVD-RAM with an IDE interface - currently /dev/hdc.
I foolishly ejected the disk while it was still mounted and
flipped the write protect tab - and lo!:

cat > foo.tmp failed and got stuck

In fact nothing could kill this process now listed as D.

In fact the drive now can't be mounted or unmounted.  I
did some reading and it appears that a forced mount or
lazy mount might work - but umount -f fails with:

umount2: Device or resource busy
umount: /dev/hdc: not mounted
umount: /media/cdrom: Illegal seek

I'm sure that if I reboot - all will be fine...  But
we try to avoid rebooting

Seems like:
- one shouldn't be able to eject media that's mounted
- if one does - it shouldn't take down the device
- if it does take down the device - it'd be nice to be
   able to fix it without rebooting

I'll monitor the list for any questions - but feel free to
email too and I'll post a summary of the answers.

John Muir Kumph

Output of scripts/ver_linux
Linux lurch 2.4.18-4GB #1 Wed Mar 27 13:57:05 UTC 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.26
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23 13:34 
/lib/libc.so
.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         vmnet vmppuser vmmon iptable_mangle iptable_nat 
ip_conntrac
k iptable_filter ip_tables nls_iso8859-1 ntfs vfat fat snd-pcm-oss 
snd-mixer-oss p
arport_pc lp parport snd-cmipci snd-pcm snd-opl3-lib snd-hwdep snd-timer 
snd-mpu40
1-uart snd-rawmidi snd-seq-device snd soundcore ipv6 isa-pnp st sg 
usb-storage joy
dev evdev input usb-uhci usbcore af_packet 8139too mii reiserfs

