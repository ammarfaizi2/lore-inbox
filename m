Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVG1JsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVG1JsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVG1JsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:48:08 -0400
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:1204 "EHLO
	averel.grnet-hq.admin.grnet.gr") by vger.kernel.org with ESMTP
	id S261339AbVG1JsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:48:05 -0400
Message-ID: <42E8A9D0.1000003@grnet.gr>
Date: Thu, 28 Jul 2005 12:48:00 +0300
From: "Constantinos A. Kotsokalis" <ckotso@grnet.gr>
Organization: Greek Research and Technology Network
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB wireless keyboard/mouse will not work
Content-Type: multipart/mixed;
 boundary="------------030005020600090508050205"
X-OriginalArrivalTime: 28 Jul 2005 09:48:03.0537 (UTC) FILETIME=[72AEFC10:01C59359]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030005020600090508050205
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Apologies for sending this to the list but I am not sure about who is the 
maintainer: It is a USB (HID) specific problem but the error messages are 
coming from the base bus.c driver.

Full problem details follow.

Thank you in advance,

  Costas

-------------------------------------------------------------------------

Problem:

[1.] One line summary of the problem:
Microsoft Wireless Optical Desktop (USB) will not work although recognized.


[2.] Full description of the problem/report:
System is a fresh Debian Sarge installation. Host computer is a Toshiba 
M10 laptop (no PS/2 ports...). Keyboard/mouse set is the following:
http://www.microsoft.com/hardware/mouseandkeyboard/productdetails.aspx?pid=028
I have found 2 reports on the web stating that it will work with PS/2, but 
it does not work with USB. I have been using other wireless USB 
keyboard/mouse sets (e.g. Logitech's) without any problem whatsoever. This 
  one's behaviour is the following:
* When connected with the host computer already on:
   - Device is recognized, then keeps connecting/disconnecting. Even when
     seemingly connected, it will not respond to clicks. The log is the
     following:
------------------------------------------------------------------------
Jul 28 12:44:00 localhost kernel: usb 1-1: new low speed USB device using 
address 71
Jul 28 12:44:00 localhost usb.agent[17103]:      usbhid: already loaded
Jul 28 12:44:00 localhost kernel: drivers/usb/input/hid-core.c: ctrl urb 
status -84 received
Jul 28 12:44:00 localhost input.agent[17142]:      evdev: already loaded
Jul 28 12:44:00 localhost input.agent[17171]:      evdev: already loaded
Jul 28 12:44:00 localhost input.agent[17171]:      joydev: already loaded
Jul 28 12:44:00 localhost kernel: input: USB HID v1.11 Keyboard [Microsft 
Microsoft Wireless Optical Desktop� 2.10] on usb-0000:00:1d.0-1
Jul 28 12:44:01 localhost kernel: usbhid: probe of 1-1:1.1 failed with 
error -5
Jul 28 12:44:01 localhost usb.agent[17211]:      usbhid: already loaded
Jul 28 12:44:01 localhost kernel: usb 1-1: USB disconnect, address 71
------------------------------------------------------------------------
     The above message is repeated endlessly, causing the host computer to
     slow down significantly. When the USB received is disconnected from
     the USB port (physically disconnected), everything's back to normal.
     The address mentioned on the first and last line is incremented by
     one in each message.

* When set is connected to the host computer before it switches on:
   - The keyboard is actually working (checked it on the boot loader menu).
     As soon as it is first recognized during the boot-up process, behavior
     is identical to the previous case.


[3.] Keywords (i.e., modules, networking, kernel):
USB, Wireless desktop, Microsoft, keyboard, mouse


[4.] Kernel version (from /proc/version):
Linux version 2.6.8-2-686 (horms@tabatha.lab.ultramonkey.org) (gcc version 
3.3.5 (Debian 1:3.3.5-12)) #1 Thu May 19 17:53:30 JST 2005


[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
Does not apply.


[6.] A small shell script or example program which triggers the
      problem (if possible)
Does not apply.


[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
Linux gimp 2.6.8-2-686 #1 Thu May 19 17:53:30 JST 2005 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.16.1
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
pcmcia-cs              3.2.5
PPP                    2.4.3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         ds lp toshiba_acpi ipv6 af_packet parport_pc 
parport irtty_sir sir_dev irda crc_ccitt pcspkr snd_intel8x0m slamr 
snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer 
snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd 
soundcore pci_hotplug intel_agp agpgart joydev usbhid ehci_hcd uhci_hcd 
usbcore eth1394 ipw2100 firmware_class ieee80211 ieee80211_crypt e100 mii 
yenta_socket pcmcia_core ohci1394 mousedev capability evdev tsdev 
commoncap battery ac sr_mod sbp2 ieee1394 psmouse ide_cd cdrom rtc isofs 
reiserfs ext2 ext3 jbd mbcache ide_generic ide_disk piix ide_core sd_mod 
ata_piix libata scsi_mod unix font vesafb cfbcopyarea cfbimgblt cfbfillrect


[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1600MHz
stepping        : 5
cpu MHz         : 1596.137
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca 
cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips        : 3162.11


[7.3.] Module information (from /proc/modules):
ds 18756 4 - Live 0xe0e03000
lp 11176 0 - Live 0xe0dd7000
toshiba_acpi 6012 0 - Live 0xe0ddb000
ipv6 264740 8 - Live 0xe0ef8000
af_packet 22568 2 - Live 0xe0d52000
parport_pc 36900 1 - Live 0xe0df1000
parport 41800 2 lp,parport_pc, Live 0xe0de5000
irtty_sir 9152 0 - Live 0xe0dd3000
sir_dev 19244 1 irtty_sir, Live 0xe0d85000
irda 197120 2 irtty_sir,sir_dev, Live 0xe0e11000
crc_ccitt 2144 1 irda, Live 0xe0d50000
pcspkr 3592 0 - Live 0xe0d44000
snd_intel8x0m 20264 0 - Live 0xe0d7f000
slamr 376868 2 - Live 0xe0e4e000
snd_intel8x0 36460 1 - Live 0xe0d8b000
snd_ac97_codec 69988 2 snd_intel8x0m,snd_intel8x0, Live 0xe0dc0000
snd_pcm_oss 55080 0 - Live 0xe0db1000
snd_mixer_oss 20096 1 snd_pcm_oss, Live 0xe0d79000
snd_pcm 98728 3 snd_intel8x0m,snd_intel8x0,snd_pcm_oss, Live 0xe0d97000
snd_timer 25732 1 snd_pcm, Live 0xe0d71000
snd_page_alloc 11752 3 snd_intel8x0m,snd_intel8x0,snd_pcm, Live 0xe0cc6000
gameport 4704 1 snd_intel8x0, Live 0xe0cd7000
snd_mpu401_uart 7968 1 snd_intel8x0, Live 0xe0cca000
snd_rawmidi 25124 1 snd_mpu401_uart, Live 0xe0d59000
snd_seq_device 8200 1 snd_rawmidi, Live 0xe0d3e000
snd 57156 12 
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xe0d
62000
soundcore 10336 1 snd, Live 0xe0d3a000
pci_hotplug 34640 0 - Live 0xe0d46000
intel_agp 22816 1 - Live 0xe0ca4000
agpgart 34664 1 intel_agp, Live 0xe0ccd000
joydev 9984 0 - Live 0xe0c17000
usbhid 32224 0 - Live 0xe0c6a000
ehci_hcd 32004 0 - Live 0xe0c74000
uhci_hcd 33136 0 - Live 0xe0cb7000
usbcore 119012 5 usbhid,ehci_hcd,uhci_hcd, Live 0xe0cda000
eth1394 21576 0 - Live 0xe0c1b000
ipw2100 151468 0 - Live 0xe0c7e000
firmware_class 10176 1 ipw2100, Live 0xe0beb000
ieee80211 40804 1 ipw2100, Live 0xe0cac000
ieee80211_crypt 6056 2 ipw2100,ieee80211, Live 0xe0bd7000
e100 32608 0 - Live 0xe0be2000
mii 5120 1 e100, Live 0xe0bbf000
yenta_socket 21728 0 - Live 0xe0bb8000
pcmcia_core 70868 2 ds,yenta_socket, Live 0xe0bc4000
ohci1394 35492 0 - Live 0xe0b9c000
mousedev 10476 2 - Live 0xe0ab6000
capability 4520 0 - Live 0xe0ac2000
evdev 9600 0 - Live 0xe0abe000
tsdev 7392 0 - Live 0xe0959000
commoncap 7232 1 capability, Live 0xe0953000
battery 9388 0 - Live 0xe0aba000
ac 4812 0 - Live 0xe0956000
sr_mod 17316 0 - Live 0xe0ab0000
sbp2 24392 0 - Live 0xe0aa9000
ieee1394 111512 3 eth1394,ohci1394,sbp2, Live 0xe0aca000
psmouse 20360 0 - Live 0xe08cb000
ide_cd 42656 0 - Live 0xe0943000
cdrom 40732 2 sr_mod,ide_cd, Live 0xe08f9000
rtc 12760 0 - Live 0xe085a000
isofs 37272 0 - Live 0xe08ee000
reiserfs 250992 2 - Live 0xe095c000
ext2 71880 0 - Live 0xe0904000
ext3 127240 0 - Live 0xe0881000
jbd 62616 1 ext3, Live 0xe08dd000
mbcache 9348 2 ext2,ext3, Live 0xe0820000
ide_generic 1408 0 - Live 0xe08a5000
ide_disk 19296 4 - Live 0xe08d2000
piix 13440 1 - Live 0xe08d8000
ide_core 139940 4 ide_cd,ide_generic,ide_disk,piix, Live 0xe08a7000
sd_mod 21728 0 - Live 0xe0841000
ata_piix 8132 0 - Live 0xe0828000
libata 41700 1 ata_piix, Live 0xe0848000
scsi_mod 125228 4 sr_mod,sbp2,sd_mod,libata, Live 0xe0861000
unix 28756 287 - Live 0xe0831000
font 8320 0 - Live 0xe0824000
vesafb 6656 0 - Live 0xe0819000
cfbcopyarea 3872 1 vesafb, Live 0xe081e000
cfbimgblt 3040 1 vesafb, Live 0xe081c000
cfbfillrect 3776 1 vesafb, Live 0xe0800000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
IOPORTS:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
1000-101f : 0000:00:1d.2
   1000-101f : uhci_hcd
1040-107f : 0000:00:1f.5
1080-10ff : 0000:00:1f.6
   1080-10ff : ICH4
1400-14ff : 0000:00:1f.5
1800-18ff : 0000:00:1f.6
   1800-18ff : ICH4
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
4800-48ff : PCI CardBus #07
4c00-4cff : PCI CardBus #07
bfa0-bfaf : 0000:00:1f.1
   bfa0-bfa7 : ide0
   bfa8-bfaf : ide1
cf40-cf7f : 0000:02:08.0
   cf40-cf7f : e100
d800-d87f : 0000:00:1f.0
eec0-eeff : 0000:00:1f.0
ef80-ef9f : 0000:00:1d.1
   ef80-ef9f : uhci_hcd
efe0-efff : 0000:00:1d.0
   efe0-efff : uhci_hcd

IOMEM:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000e0000-000eedff : reserved
000eee00-000eefff : ACPI Non-volatile Storage
000f0000-000fffff : System ROM
00100000-1ffcffff : System RAM
   00100000-00283f92 : Kernel code
   00283f93-00330adf : Kernel data
1ffd0000-1ffdffff : ACPI Tables
1ffe0000-1fffffff : reserved
20000000-200003ff : 0000:00:1d.7
   20000000-200003ff : ehci_hcd
20000400-200007ff : 0000:00:1f.1
20000800-200009ff : 0000:00:1f.5
   20000800-200009ff : Intel 82801DB-ICH4 - AC'97
20000a00-20000aff : 0000:00:1f.5
   20000a00-20000aff : Intel 82801DB-ICH4 - Controller
20000c00-20000dff : 0000:02:0d.0
20001000-200017ff : 0000:02:07.0
   20001000-200017ff : ohci1394
20002000-20002fff : 0000:02:0b.0
   20002000-20002fff : yenta_socket
20003000-20003fff : 0000:02:0b.1
   20003000-20003fff : yenta_socket
20004000-20007fff : 0000:02:07.0
20400000-207fffff : PCI CardBus #03
20800000-20bfffff : PCI CardBus #03
20c00000-20ffffff : PCI CardBus #07
21000000-213fffff : PCI CardBus #07
dbf00000-dfffffff : PCI Bus #01
   dbf80000-dbffffff : 0000:01:00.0
   dc000000-dfffffff : 0000:01:00.0
e0000000-efffffff : 0000:00:00.0
fcefe000-fcefefff : 0000:02:0a.0
   fcefe000-fcefefff : ipw2100
fceff000-fcefffff : 0000:02:08.0
   fceff000-fcefffff : e100
fd000000-fdffffff : PCI Bus #01
   fd000000-fdffffff : 0000:01:00.0
feda0000-fedbffff : reserved
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
Attached.


[7.6.] SCSI information (from /proc/scsi/scsi)
No SCSI devices attached.


[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
In /proc/bus/usb/devices, when receiver is attached, there are the 
following extra lines:
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 54 Spd=1.5 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=009d Rev= 0.38
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=(none)
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=10ms



--------------030005020600090508050205
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="lspci.txt"

MDAwMDowMDowMC4wIEhvc3QgYnJpZGdlOiBJbnRlbCBDb3JwLiA4Mjg1NVBNIFByb2Nlc3Nv
ciB0byBJL08gQ29udHJvbGxlciAocmV2IDAzKQoJU3Vic3lzdGVtOiBUb3NoaWJhIEFtZXJp
Y2EgSW5mbyBTeXN0ZW1zOiBVbmtub3duIGRldmljZSAwMDAxCglDb250cm9sOiBJL08tIE1l
bSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0
ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RC
MkIrIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydCsgPlNF
UlItIDxQRVJSLQoJTGF0ZW5jeTogMAoJUmVnaW9uIDA6IE1lbW9yeSBhdCBlMDAwMDAwMCAo
MzItYml0LCBwcmVmZXRjaGFibGUpIFtzaXplPTI1Nk1dCglDYXBhYmlsaXRpZXM6IFtlNF0g
IzA5IFtmMTA0XQoJQ2FwYWJpbGl0aWVzOiBbYTBdIEFHUCB2ZXJzaW9uIDIuMAoJCVN0YXR1
czogUlE9MzIgSXNvLSBBcnFTej0wIENhbD0wIFNCQSsgSVRBQ29oLSBHQVJUNjQtIEhUcmFu
cy0gNjRiaXQtIEZXKyBBR1AzLSBSYXRlPXgxLHgyLHg0CgkJQ29tbWFuZDogUlE9MSBBcnFT
ej0wIENhbD0wIFNCQS0gQUdQLSBHQVJUNjQtIDY0Yml0LSBGVy0gUmF0ZT08bm9uZT4KCjAw
MDA6MDA6MDEuMCBQQ0kgYnJpZGdlOiBJbnRlbCBDb3JwLiA4Mjg1NVBNIFByb2Nlc3NvciB0
byBBR1AgQ29udHJvbGxlciAocmV2IDAzKSAocHJvZy1pZiAwMCBbTm9ybWFsIGRlY29kZV0p
CglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZH
QVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLQoJU3RhdHVzOiBDYXAt
IDY2TUh6KyBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRB
Ym9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJTGF0ZW5jeTogNjQKCUJ1czogcHJpbWFy
eT0wMCwgc2Vjb25kYXJ5PTAxLCBzdWJvcmRpbmF0ZT0wMSwgc2VjLWxhdGVuY3k9NjQKCUkv
TyBiZWhpbmQgYnJpZGdlOiAwMDAwZjAwMC0wMDAwMGZmZgoJTWVtb3J5IGJlaGluZCBicmlk
Z2U6IGZkMDAwMDAwLWZkZmZmZmZmCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGluZCBicmlk
Z2U6IGRiZjAwMDAwLWRmZmZmZmZmCglCcmlkZ2VDdGw6IFBhcml0eS0gU0VSUi0gTm9JU0Et
IFZHQSsgTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgowMDAwOjAwOjFkLjAgVVNCIENvbnRy
b2xsZXI6IEludGVsIENvcnAuIDgyODAxREIvREJML0RCTSAoSUNINC9JQ0g0LUwvSUNINC1N
KSBVU0IgVUhDSSBDb250cm9sbGVyICMxIChyZXYgMDMpIChwcm9nLWlmIDAwIFtVSENJXSkK
CVN1YnN5c3RlbTogVG9zaGliYSBBbWVyaWNhIEluZm8gU3lzdGVtczogVW5rbm93biBkZXZp
Y2UgMDAwMQoJQ29udHJvbDogSS9PKyBNZW0tIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1X
SU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1
czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRB
Ym9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJTGF0ZW5jeTogMAoJSW50
ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDExCglSZWdpb24gNDogSS9PIHBvcnRzIGF0
IGVmZTAgW3NpemU9MzJdCgowMDAwOjAwOjFkLjEgVVNCIENvbnRyb2xsZXI6IEludGVsIENv
cnAuIDgyODAxREIvREJML0RCTSAoSUNINC9JQ0g0LUwvSUNINC1NKSBVU0IgVUhDSSBDb250
cm9sbGVyICMyIChyZXYgMDMpIChwcm9nLWlmIDAwIFtVSENJXSkKCVN1YnN5c3RlbTogVG9z
aGliYSBBbWVyaWNhIEluZm8gU3lzdGVtczogVW5rbm93biBkZXZpY2UgMDAwMQoJQ29udHJv
bDogSS9PKyBNZW0tIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0g
UGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czogQ2FwLSA2Nk1Iei0g
VURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4gQiBy
b3V0ZWQgdG8gSVJRIDExCglSZWdpb24gNDogSS9PIHBvcnRzIGF0IGVmODAgW3NpemU9MzJd
CgowMDAwOjAwOjFkLjIgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnAuIDgyODAxREIvREJM
L0RCTSAoSUNINC9JQ0g0LUwvSUNINC1NKSBVU0IgVUhDSSBDb250cm9sbGVyICMzIChyZXYg
MDMpIChwcm9nLWlmIDAwIFtVSENJXSkKCVN1YnN5c3RlbTogVG9zaGliYSBBbWVyaWNhIElu
Zm8gU3lzdGVtczogVW5rbm93biBkZXZpY2UgMDAwMQoJQ29udHJvbDogSS9PKyBNZW0tIEJ1
c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGlu
Zy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCKyBQ
YXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlIt
IDxQRVJSLQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4gQyByb3V0ZWQgdG8gSVJRIDEx
CglSZWdpb24gNDogSS9PIHBvcnRzIGF0IDEwMDAgW3NpemU9MzJdCgowMDAwOjAwOjFkLjcg
VVNCIENvbnRyb2xsZXI6IEludGVsIENvcnAuIDgyODAxREIvREJNIChJQ0g0L0lDSDQtTSkg
VVNCIDIuMCBFSENJIENvbnRyb2xsZXIgKHJldiAwMykgKHByb2ctaWYgMjAgW0VIQ0ldKQoJ
U3Vic3lzdGVtOiBUb3NoaWJhIEFtZXJpY2EgSW5mbyBTeXN0ZW1zOiBVbmtub3duIGRldmlj
ZSAwMDAxCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLQoJU3RhdHVz
OiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFi
b3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItCglMYXRlbmN5OiAwCglJbnRl
cnJ1cHQ6IHBpbiBEIHJvdXRlZCB0byBJUlEgMTEKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgMjAw
MDAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MUtdCglDYXBhYmlsaXRp
ZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDIKCQlGbGFnczogUE1FQ2xrLSBE
U0ktIEQxLSBEMi0gQXV4Q3VycmVudD0zNzVtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQz
Y29sZCspCgkJU3RhdHVzOiBEMCBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJ
Q2FwYWJpbGl0aWVzOiBbNThdICMwYSBbMjA4MF0KCjAwMDA6MDA6MWUuMCBQQ0kgYnJpZGdl
OiBJbnRlbCBDb3JwLiA4MjgwMSBQQ0kgQnJpZGdlIChyZXYgODMpIChwcm9nLWlmIDAwIFtO
b3JtYWwgZGVjb2RlXSkKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNs
ZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkIt
CglTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9ZmFz
dCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlIrCglMYXRlbmN5OiAw
CglCdXM6IHByaW1hcnk9MDAsIHNlY29uZGFyeT0wMiwgc3Vib3JkaW5hdGU9MDUsIHNlYy1s
YXRlbmN5PTY0CglJL08gYmVoaW5kIGJyaWRnZTogMDAwMGMwMDAtMDAwMGNmZmYKCU1lbW9y
eSBiZWhpbmQgYnJpZGdlOiBmY2UwMDAwMC1mY2VmZmZmZgoJUHJlZmV0Y2hhYmxlIG1lbW9y
eSBiZWhpbmQgYnJpZGdlOiBmZmYwMDAwMC0wMDBmZmZmZgoJQnJpZGdlQ3RsOiBQYXJpdHkt
IFNFUlItIE5vSVNBLSBWR0EtIE1BYm9ydC0gPlJlc2V0LSBGYXN0QjJCLQoKMDAwMDowMDox
Zi4wIElTQSBicmlkZ2U6IEludGVsIENvcnAuIDgyODAxREJNIExQQyBJbnRlcmZhY2UgQ29u
dHJvbGxlciAocmV2IDAzKQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5
Y2xlKyBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIy
Qi0KCVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1t
ZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJTGF0ZW5j
eTogMAoKMDAwMDowMDoxZi4xIElERSBpbnRlcmZhY2U6IEludGVsIENvcnAuIDgyODAxREJN
IChJQ0g0KSBVbHRyYSBBVEEgU3RvcmFnZSBDb250cm9sbGVyIChyZXYgMDMpIChwcm9nLWlm
IDhhIFtNYXN0ZXIgU2VjUCBQcmlQXSkKCVN1YnN5c3RlbTogVG9zaGliYSBBbWVyaWNhIElu
Zm8gU3lzdGVtczogVW5rbm93biBkZXZpY2UgMDAwMQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1
c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGlu
Zy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCKyBQ
YXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlIt
IDxQRVJSLQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDEx
CglSZWdpb24gMDogSS9PIHBvcnRzIGF0IDxpZ25vcmVkPgoJUmVnaW9uIDE6IEkvTyBwb3J0
cyBhdCA8aWdub3JlZD4KCVJlZ2lvbiAyOiBJL08gcG9ydHMgYXQgPGlnbm9yZWQ+CglSZWdp
b24gMzogSS9PIHBvcnRzIGF0IDxpZ25vcmVkPgoJUmVnaW9uIDQ6IEkvTyBwb3J0cyBhdCBi
ZmEwIFtzaXplPTE2XQoJUmVnaW9uIDU6IE1lbW9yeSBhdCAyMDAwMDQwMCAoMzItYml0LCBu
b24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xS10KCjAwMDA6MDA6MWYuNSBNdWx0aW1lZGlhIGF1
ZGlvIGNvbnRyb2xsZXI6IEludGVsIENvcnAuIDgyODAxREIvREJML0RCTSAoSUNINC9JQ0g0
LUwvSUNINC1NKSBBQyc5NyBBdWRpbyBDb250cm9sbGVyIChyZXYgMDMpCglTdWJzeXN0ZW06
IFRvc2hpYmEgQW1lcmljYSBJbmZvIFN5c3RlbXM6IFVua25vd24gZGV2aWNlIDAyMDIKCUNv
bnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25v
b3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItCglTdGF0dXM6IENhcCsgNjZN
SHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJv
cnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGlu
IEIgcm91dGVkIHRvIElSUSAxMQoJUmVnaW9uIDA6IEkvTyBwb3J0cyBhdCAxNDAwIFtzaXpl
PTI1Nl0KCVJlZ2lvbiAxOiBJL08gcG9ydHMgYXQgMTA0MCBbc2l6ZT02NF0KCVJlZ2lvbiAy
OiBNZW1vcnkgYXQgMjAwMDA4MDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9
NTEyXQoJUmVnaW9uIDM6IE1lbW9yeSBhdCAyMDAwMGEwMCAoMzItYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbc2l6ZT0yNTZdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVu
dCB2ZXJzaW9uIDIKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD0z
NzVtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBQTUUt
RW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoKMDAwMDowMDoxZi42IE1vZGVtOiBJbnRl
bCBDb3JwLiA4MjgwMURCL0RCTC9EQk0gKElDSDQvSUNINC1ML0lDSDQtTSkgQUMnOTcgTW9k
ZW0gQ29udHJvbGxlciAocmV2IDAzKSAocHJvZy1pZiAwMCBbR2VuZXJpY10pCglTdWJzeXN0
ZW06IFRvc2hpYmEgQW1lcmljYSBJbmZvIFN5c3RlbXM6IFVua25vd24gZGV2aWNlIDAwMDEK
CUNvbnRyb2w6IEkvTysgTWVtLSBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdB
U25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItCglTdGF0dXM6IENhcCsg
NjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxU
QWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0KCUxhdGVuY3k6IDAKCUludGVycnVwdDog
cGluIEIgcm91dGVkIHRvIElSUSAxMQoJUmVnaW9uIDA6IEkvTyBwb3J0cyBhdCAxODAwIFtz
aXplPTI1Nl0KCVJlZ2lvbiAxOiBJL08gcG9ydHMgYXQgMTA4MCBbc2l6ZT0xMjhdCglDYXBh
YmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDIKCQlGbGFnczogUE1F
Q2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD0zNzVtQSBQTUUoRDArLEQxLSxEMi0sRDNo
b3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAg
UE1FLQoKMDAwMDowMTowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IG5WaWRpYSBD
b3Jwb3JhdGlvbiBOVjE3IFtHZUZvcmNlNCA0MjAgR29dIChyZXYgYTMpIChwcm9nLWlmIDAw
IFtWR0FdKQoJU3Vic3lzdGVtOiBUb3NoaWJhIEFtZXJpY2EgSW5mbyBTeXN0ZW1zOiBVbmtu
b3duIGRldmljZSAwMDEwCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3lj
bGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJC
LQoJU3RhdHVzOiBDYXArIDY2TUh6KyBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPW1l
ZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItCglMYXRlbmN5
OiA2NCAoMTI1MG5zIG1pbiwgMjUwbnMgbWF4KQoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQg
dG8gSVJRIDEwCglSZWdpb24gMDogTWVtb3J5IGF0IGZkMDAwMDAwICgzMi1iaXQsIG5vbi1w
cmVmZXRjaGFibGUpIFtzaXplPTE2TV0KCVJlZ2lvbiAxOiBNZW1vcnkgYXQgZGMwMDAwMDAg
KDMyLWJpdCwgcHJlZmV0Y2hhYmxlKSBbc2l6ZT02NE1dCglSZWdpb24gMjogTWVtb3J5IGF0
IGRiZjgwMDAwICgzMi1iaXQsIHByZWZldGNoYWJsZSkgW3NpemU9NTEyS10KCUNhcGFiaWxp
dGllczogWzYwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMgoJCUZsYWdzOiBQTUVDbGst
IERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3QtLEQz
Y29sZC0pCgkJU3RhdHVzOiBEMCBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJ
Q2FwYWJpbGl0aWVzOiBbNDRdIEFHUCB2ZXJzaW9uIDIuMAoJCVN0YXR1czogUlE9MzIgSXNv
LSBBcnFTej0wIENhbD0wIFNCQS0gSVRBQ29oLSBHQVJUNjQtIEhUcmFucy0gNjRiaXQtIEZX
KyBBR1AzLSBSYXRlPXgxLHgyLHg0CgkJQ29tbWFuZDogUlE9MSBBcnFTej0wIENhbD0wIFNC
QS0gQUdQLSBHQVJUNjQtIDY0Yml0LSBGVy0gUmF0ZT08bm9uZT4KCjAwMDA6MDI6MDcuMCBG
aXJlV2lyZSAoSUVFRSAxMzk0KTogVGV4YXMgSW5zdHJ1bWVudHMgVFNCNDNBQjIyL0EgSUVF
RS0xMzk0YS0yMDAwIENvbnRyb2xsZXIgKFBIWS9MaW5rKSAocHJvZy1pZiAxMCBbT0hDSV0p
CglTdWJzeXN0ZW06IFRvc2hpYmEgQW1lcmljYSBJbmZvIFN5c3RlbXM6IFVua25vd24gZGV2
aWNlIDAwMDEKCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVt
V0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItCglTdGF0
dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9bWVkaXVtID5U
QWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0KCUxhdGVuY3k6IDY0ICg1
MDBucyBtaW4sIDEwMDBucyBtYXgpLCBDYWNoZSBMaW5lIFNpemU6IDB4MDggKDMyIGJ5dGVz
KQoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDExCglSZWdpb24gMDogTWVtb3J5
IGF0IDIwMDAxMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJLXQoJUmVn
aW9uIDE6IE1lbW9yeSBhdCAyMDAwNDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBb
c2l6ZT0xNktdCglDYXBhYmlsaXRpZXM6IFs0NF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9u
IDIKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxKyBEMisgQXV4Q3VycmVudD0wbUEgUE1FKEQw
KyxEMSssRDIrLEQzaG90KyxEM2NvbGQtKQoJCVN0YXR1czogRDAgUE1FLUVuYWJsZS0gRFNl
bD0wIERTY2FsZT0wIFBNRSsKCjAwMDA6MDI6MDguMCBFdGhlcm5ldCBjb250cm9sbGVyOiBJ
bnRlbCBDb3JwLiA4MjgwMUJEIFBSTy8xMDAgVkUgKE1PQikgRXRoZXJuZXQgQ29udHJvbGxl
ciAocmV2IDgzKQoJU3Vic3lzdGVtOiBUb3NoaWJhIEFtZXJpY2EgSW5mbyBTeXN0ZW1zOiBV
bmtub3duIGRldmljZSAwMDAxCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVj
Q3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0
QjJCLQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VM
PW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItCglMYXRl
bmN5OiA2NCAoMjAwMG5zIG1pbiwgMTQwMDBucyBtYXgpLCBDYWNoZSBMaW5lIFNpemU6IDB4
MDggKDMyIGJ5dGVzKQoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDExCglSZWdp
b24gMDogTWVtb3J5IGF0IGZjZWZmMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtz
aXplPTRLXQoJUmVnaW9uIDE6IEkvTyBwb3J0cyBhdCBjZjQwIFtzaXplPTY0XQoJQ2FwYWJp
bGl0aWVzOiBbZGNdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgkJRmxhZ3M6IFBNRUNs
ay0gRFNJKyBEMSsgRDIrIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDErLEQyKyxEM2hvdCss
RDNjb2xkKykKCQlTdGF0dXM6IEQwIFBNRS1FbmFibGUrIERTZWw9MCBEU2NhbGU9MiBQTUUt
CgowMDAwOjAyOjBhLjAgTmV0d29yayBjb250cm9sbGVyOiBJbnRlbCBDb3JwLiBQUk8vV2ly
ZWxlc3MgTEFOIDIxMDAgM0IgTWluaSBQQ0kgQWRhcHRlciAocmV2IDA0KQoJU3Vic3lzdGVt
OiBJbnRlbCBDb3JwLjogVW5rbm93biBkZXZpY2UgMjU4MQoJQ29udHJvbDogSS9PLSBNZW0r
IEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVw
cGluZy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJC
KyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLQoJTGF0ZW5jeTogNjQgKDUwMG5zIG1pbiwgODUwMG5zIG1heCksIENhY2hl
IExpbmUgU2l6ZTogMHgwOCAoMzIgYnl0ZXMpCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0
byBJUlEgMTEKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZmNlZmUwMDAgKDMyLWJpdCwgbm9uLXBy
ZWZldGNoYWJsZSkgW3NpemU9NEtdCglDYXBhYmlsaXRpZXM6IFtkY10gUG93ZXIgTWFuYWdl
bWVudCB2ZXJzaW9uIDIKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVu
dD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQoJCVN0YXR1czogRDAgUE1F
LUVuYWJsZS0gRFNlbD0wIERTY2FsZT0xIFBNRS0KCjAwMDA6MDI6MGIuMCBDYXJkQnVzIGJy
aWRnZTogVG9zaGliYSBBbWVyaWNhIEluZm8gU3lzdGVtcyBUb1BJQzk1IFBDSSB0byBDYXJk
YnVzIEJyaWRnZSB3aXRoIFpWIFN1cHBvcnQgKHJldiAzMikKCVN1YnN5c3RlbTogVG9zaGli
YSBBbWVyaWNhIEluZm8gU3lzdGVtczogVW5rbm93biBkZXZpY2UgMDAwMQoJQ29udHJvbDog
SS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFy
RXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURG
LSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1zbG93ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJv
cnQtID5TRVJSLSA8UEVSUi0KCUxhdGVuY3k6IDE2OAoJSW50ZXJydXB0OiBwaW4gQSByb3V0
ZWQgdG8gSVJRIDExCglSZWdpb24gMDogTWVtb3J5IGF0IDIwMDAyMDAwICgzMi1iaXQsIG5v
bi1wcmVmZXRjaGFibGUpIFtzaXplPTRLXQoJQnVzOiBwcmltYXJ5PTAyLCBzZWNvbmRhcnk9
MDMsIHN1Ym9yZGluYXRlPTA2LCBzZWMtbGF0ZW5jeT0wCglNZW1vcnkgd2luZG93IDA6IDIw
NDAwMDAwLTIwN2ZmMDAwIChwcmVmZXRjaGFibGUpCglNZW1vcnkgd2luZG93IDE6IDIwODAw
MDAwLTIwYmZmMDAwCglJL08gd2luZG93IDA6IDAwMDA0MDAwLTAwMDA0MGZmCglJL08gd2lu
ZG93IDE6IDAwMDA0NDAwLTAwMDA0NGZmCglCcmlkZ2VDdGw6IFBhcml0eS0gU0VSUi0gSVNB
LSBWR0EtIE1BYm9ydC0gPlJlc2V0LSAxNmJJbnQrIFBvc3RXcml0ZSsKCTE2LWJpdCBsZWdh
Y3kgaW50ZXJmYWNlIHBvcnRzIGF0IDAwMDEKCjAwMDA6MDI6MGIuMSBDYXJkQnVzIGJyaWRn
ZTogVG9zaGliYSBBbWVyaWNhIEluZm8gU3lzdGVtcyBUb1BJQzk1IFBDSSB0byBDYXJkYnVz
IEJyaWRnZSB3aXRoIFpWIFN1cHBvcnQgKHJldiAzMikKCVN1YnN5c3RlbTogVG9zaGliYSBB
bWVyaWNhIEluZm8gU3lzdGVtczogVW5rbm93biBkZXZpY2UgMDAwMQoJQ29udHJvbDogSS9P
KyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJy
LSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBG
YXN0QjJCKyBQYXJFcnItIERFVlNFTD1zbG93ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQt
ID5TRVJSLSA8UEVSUi0KCUxhdGVuY3k6IDE2OAoJSW50ZXJydXB0OiBwaW4gQiByb3V0ZWQg
dG8gSVJRIDExCglSZWdpb24gMDogTWVtb3J5IGF0IDIwMDAzMDAwICgzMi1iaXQsIG5vbi1w
cmVmZXRjaGFibGUpIFtzaXplPTRLXQoJQnVzOiBwcmltYXJ5PTAyLCBzZWNvbmRhcnk9MDcs
IHN1Ym9yZGluYXRlPTBhLCBzZWMtbGF0ZW5jeT0wCglNZW1vcnkgd2luZG93IDA6IDIwYzAw
MDAwLTIwZmZmMDAwIChwcmVmZXRjaGFibGUpCglNZW1vcnkgd2luZG93IDE6IDIxMDAwMDAw
LTIxM2ZmMDAwCglJL08gd2luZG93IDA6IDAwMDA0ODAwLTAwMDA0OGZmCglJL08gd2luZG93
IDE6IDAwMDA0YzAwLTAwMDA0Y2ZmCglCcmlkZ2VDdGw6IFBhcml0eS0gU0VSUi0gSVNBLSBW
R0EtIE1BYm9ydC0gPlJlc2V0LSAxNmJJbnQrIFBvc3RXcml0ZSsKCTE2LWJpdCBsZWdhY3kg
aW50ZXJmYWNlIHBvcnRzIGF0IDAwMDEKCjAwMDA6MDI6MGQuMCBTeXN0ZW0gcGVyaXBoZXJh
bDogVG9zaGliYSBBbWVyaWNhIEluZm8gU3lzdGVtcyBTRCBUeXBBIENvbnRyb2xsZXIgKHJl
diAwMykKCVN1YnN5c3RlbTogVG9zaGliYSBBbWVyaWNhIEluZm8gU3lzdGVtczogVW5rbm93
biBkZXZpY2UgMDAwMQoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0gU3BlY0N5Y2xl
LSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0K
CVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRp
dW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJSW50ZXJydXB0
OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDExCglSZWdpb24gMDogTWVtb3J5IGF0IDIwMDAwYzAw
ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0gW3NpemU9NTEyXQoJQ2Fw
YWJpbGl0aWVzOiBbODBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgkJRmxhZ3M6IFBN
RUNsay0gRFNJLSBEMSsgRDIrIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDErLEQyKyxEM2hv
dCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQ
TUUtCgo=
--------------030005020600090508050205--
