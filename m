Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272357AbTHEB4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 21:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272358AbTHEB4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 21:56:41 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:61904 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S272357AbTHEB4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 21:56:36 -0400
Message-ID: <3F2F0ED0.4060707@free.fr>
Date: Tue, 05 Aug 2003 03:56:32 +0200
From: Florent Coste <coste.florent@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re 2.6.0-test2-mm4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

pppd won't start with test2-mm4 + Con' patch-O12.3-O13int, it starts 
well with test2-mm2.

(The problem is not trickered by the ISP : rebooting on test2-mm2 just 
after the faillure make it work)
/var/log/messages & others follow.


Regards,

Florent


Aug  5 03:31:26 localhost modem_run[558]: ADSL synchronization has been 
obtained
Aug  5 03:31:26 localhost modem_run[558]: ADSL line is up (608 kbit/s 
down | 160 kbit/s up)
Aug  5 03:31:27 localhost kernel: HDLC line discipline: version 
$Revision: 4.8 $, maxframe=4096
Aug  5 03:31:27 localhost kernel: N_HDLC line discipline registered.
Aug  5 03:31:27 localhost kernel: CSLIP: code copyright 1989 Regents of 
the University of California
Aug  5 03:31:27 localhost kernel: PPP generic driver version 2.4.2
Aug  5 03:31:27 localhost pppd[633]: pppd 2.4.1 started by root, uid 0
Aug  5 03:31:27 localhost pppd[633]: Using interface ppp0
Aug  5 03:31:27 localhost pppd[633]: Connect: ppp0 <--> /dev/pts/0
Aug  5 03:31:28 localhost pppd[633]: Modem hangup
Aug  5 03:31:28 localhost pppd[633]: Connection terminated.
Aug  5 03:31:28 localhost kernel: Badness in kobject_cleanup at 
lib/kobject.c:402
Aug  5 03:31:28 localhost kernel: Call Trace:
Aug  5 03:31:28 localhost kernel:  [kobject_cleanup+96/144] 
kobject_cleanup+0x60/0x90
Aug  5 03:31:28 localhost kernel:  [netdev_unregister_sysfs+62/64] 
netdev_unregister_sysfs+0x3e/0x40
Aug  5 03:31:28 localhost kernel:  [netdev_run_todo+328/464] 
netdev_run_todo+0x148/0x1d0
Aug  5 03:31:28 localhost kernel:  [__crc_tcf_police+5274242/5634509] 
ppp_shutdown_interface+0xa5/0x110 [ppp_generic]
Aug  5 03:31:28 localhost kernel:  [__crc_tcf_police+5260106/5634509] 
ppp_ioctl+0x92d/0x960 [ppp_generic]
Aug  5 03:31:28 localhost kernel:  [__fput+200/304] __fput+0xc8/0x130
Aug  5 03:31:28 localhost kernel:  [sys_ioctl+295/736] sys_ioctl+0x127/0x2e0
Aug  5 03:31:28 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  5 03:31:28 localhost kernel:
Aug  5 03:31:28 localhost kernel: Badness in class_dev_release at 
drivers/base/class.c:201
Aug  5 03:31:28 localhost kernel: Call Trace:
Aug  5 03:31:28 localhost kernel:  [kobject_cleanup+134/144] 
kobject_cleanup+0x86/0x90
Aug  5 03:31:28 localhost kernel:  [class_device_unregister+20/48] 
class_device_unregister+0x14/0x30
Aug  5 03:31:28 localhost kernel:  [netdev_run_todo+328/464] 
netdev_run_todo+0x148/0x1d0
Aug  5 03:31:28 localhost kernel:  [__crc_tcf_police+5274242/5634509] 
ppp_shutdown_interface+0xa5/0x110 [ppp_generic]
Aug  5 03:31:28 localhost kernel:  [__crc_tcf_police+5260106/5634509] 
ppp_ioctl+0x92d/0x960 [ppp_generic]
Aug  5 03:31:28 localhost kernel:  [__fput+200/304] __fput+0xc8/0x130
Aug  5 03:31:28 localhost kernel:  [sys_ioctl+295/736] sys_ioctl+0x127/0x2e0
Aug  5 03:31:28 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  5 03:31:28 localhost kernel:


sormiou:~# lsmod
Module                  Size  Used by
ppp_synctty             9888  1
ppp_generic            33328  5 ppp_synctty
slhc                    7008  1 ppp_generic
n_hdlc                 10244  1
radeon                121836  2
iptable_filter          2624  0
uhci_hcd               34032  0
vfat                   16800  4
fat                    48736  1 vfat
w83781d                35808  0
i2c_sensor              3168  1 w83781d
i2c_isa                 1760  0
i2c_piix4               7404  0
i2c_core               25160  4 w83781d,i2c_sensor,i2c_isa,i2c_piix4
iptable_mangle          2624  0
ip_tables              21760  2 iptable_filter,iptable_mangle
snd_seq_midi            9696  0
snd_seq_oss            36384  0
snd_seq_midi_event      7936  2 snd_seq_midi,snd_seq_oss
snd_seq                63632  5 snd_seq_midi,snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            61252  0
snd_mixer_oss          20960  2 snd_pcm_oss
snd_als100             10564  1
snd_opl3_lib           11680  1 snd_als100
snd_hwdep               9312  1 snd_opl3_lib
snd_sb16_dsp           11008  1 snd_als100
snd_sb_common          16672  2 snd_als100,snd_sb16_dsp
snd_pcm               112288  2 snd_pcm_oss,snd_sb16_dsp
snd_page_alloc         12740  1 snd_pcm
snd_timer              28548  3 snd_seq,snd_opl3_lib,snd_pcm
snd_mpu401_uart         8224  1 snd_als100
snd_rawmidi            26496  2 snd_seq_midi,snd_mpu401_uart
snd_seq_device          8744  5 
snd_seq_midi,snd_seq_oss,snd_seq,snd_opl3_lib,snd_rawmidi
snd                    58148  16 
snd_seq_midi,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_als100,snd_opl3_lib,snd_hwdep,snd_sb16_dsp,snd_sb_common,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
rtc                    13924  0


sormiou:~# cat /proc/bus/usb/devices

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test2-mm2 uhci-hcd
S:  Product=Intel Corp. 82371AB/EB/MB PIIX4
S:  SerialNumber=0000:00:07.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=06b9 ProdID=4061 Rev= 0.00
S:  Manufacturer=ALCATEL
S:  Product=Speed Touch USB
S:  SerialNumber=0090D030D548
C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=50ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
I:  If#= 1 Alt= 1 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
E:  Ad=06(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 2 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
E:  Ad=06(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 3 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbfs
E:  Ad=06(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=05(O) Atr=02(Bulk) MxPS=   8 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=   8 Ivl=0ms



