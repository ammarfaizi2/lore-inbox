Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbUCKSas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUCKSas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:30:48 -0500
Received: from athmta04.forthnet.gr ([193.92.150.25]:44644 "EHLO forthnet.gr")
	by vger.kernel.org with ESMTP id S261650AbUCKSaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:30:13 -0500
Subject: Re: Kernel panics on VIA motherboard with USB devices
From: Emm Vasilakis <evas@agn.forthnet.gr>
To: linux-kernel@vger.kernel.org
Cc: vda@port.imtp.ilyichevsk.odessa.ua
In-Reply-To: <1079010015.30872.12.camel@sylvester.rd.forthnet.gr>
References: <1079010015.30872.12.camel@sylvester.rd.forthnet.gr>
Content-Type: multipart/mixed; boundary="=-zijugB7/1WbOsoVGEcmU"
Organization: 
Message-Id: <1079029790.4075.5.camel@winterland.thinice.gr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 11 Mar 2004 20:29:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zijugB7/1WbOsoVGEcmU
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit

Hi again,

I'm attaching the outpout from ksymoops, plus some more:

winterland root # lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:0b.0 SCSI storage controller: Initio Corporation 360P (rev 02)
00:0e.0 Multimedia video controller: Brooktree Corporation Bt848 Video
Capture (rev 12)
00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149
(rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800
South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 78)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4200] (rev a3)

winterland root # lsmod
Module                  Size  Used by    Tainted: PF
ppp_deflate             3480   0  (autoclean)
zlib_deflate           18168   0  (autoclean) [ppp_deflate]
bsd_comp                4344   0  (autoclean)
ppp_async               8320   1  (autoclean)
ppp_generic            23104   3  (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    5488   0  (autoclean) [ppp_generic]
nls_iso8859-1           2844   0  (autoclean)
nls_cp437               4348   0  (autoclean)
vfat                   10860   0  (autoclean)
fat                    34648   0  (autoclean) [vfat]
usb-storage           125264   0
snd-mixer-oss          13776   0  (autoclean)
sr_mod                 14232   0  (autoclean) (unused)
nvidia               1632640  11  (autoclean)
ipt_MASQUERADE          1624   1  (autoclean)
iptable_nat            19384   1  (autoclean) [ipt_MASQUERADE]
ip_conntrack           25480   1  (autoclean) [ipt_MASQUERADE
iptable_nat]
iptable_filter          1740   0  (autoclean) (unused)
vmnet                  21288   6
vmmon                  23380   0  (unused)
it87                   10916   0
i2c-isa                 1164   0  (unused)
i2c-proc                7248   0  [it87]
hci_usb                 7548   1
pl2303                 13624   1
usbserial              19836   0  [pl2303]
tuner                  10784   1  (autoclean)
tvaudio                14364   0  (autoclean) (unused)
bttv                   98080   0
videodev                7104   2  [bttv]
i2c-algo-bit            7688   1  [bttv]
i2c-core               14052   0  [it87 i2c-isa i2c-proc tuner tvaudio
bttv i2c-algo-bit]
uhci                   29008   0  (unused)
ehci-hcd               26152   0  (unused)
snd-via82xx            14272   0
snd-pcm                68736   0  [snd-via82xx]
snd-timer              17380   0  [snd-pcm]
snd-ac97-codec         43544   0  [snd-via82xx]
snd-page-alloc          7060   0  [snd-via82xx snd-pcm]
snd-mpu401-uart         4128   0  [snd-via82xx]
snd-rawmidi            15840   0  [snd-mpu401-uart]
snd-seq-device          4452   0  [snd-rawmidi]
snd                    37444   0  [snd-mixer-oss snd-via82xx snd-pcm
snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               4580   1  [bttv snd]
rtc                     8572   0  (autoclean)
rfcomm                 37824   1
l2cap                  21516   1  [rfcomm]
bluez                  38340   3  [hci_usb rfcomm l2cap]
ip_tables              13664   5  [ipt_MASQUERADE iptable_nat
iptable_filter]
initio                 21988   0
via-rhine              13872   1
mii                     2592   0  [via-rhine]

winterland root # cat /proc/interrupts
           CPU0
  0:     105125    IO-APIC-edge  timer
  1:       3705    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  4:     203962    IO-APIC-edge  serial
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:      19569    IO-APIC-edge  PS/2 Mouse
 14:      30651    IO-APIC-edge  ide0
 15:         12    IO-APIC-edge  ide1
 16:      77036   IO-APIC-level  nvidia
 17:          2   IO-APIC-level  bttv
 19:         21   IO-APIC-level  i91u
 21:      17935   IO-APIC-level  ehci_hcd, usb-uhci, usb-uhci, usb-uhci,
usb-uhci
 22:         76   IO-APIC-level  VIA8233
 23:          0   IO-APIC-level  eth0
NMI:          0
LOC:     105068
ERR:          0
MIS:          0

winterland root # uname -r
2.4.25_pre7-gss-r2

Thanks again,
Emmanuel

On Πεμ, 2004-03-11 at 15:00, Emm Vasilakis wrote:
> Hi all,
> 
> I'm trying to get my new machine to work with Linux, but I'm having some
> problems.
> 
> Machine specs:
> ASUS A7V600-X motherboard (KT600 & VIA 8237)
> Athlon XP 2400+
> 512MB RAM
> WD 80G HD on primary IDE
> TV-Tuner (bt848)
> Initio UW-SCSI card
> Nvidia Ti 4200 gfx card
> 
> I'm running gentoo linux, 2.4.25-pre kernel and the latest hotplug.
> 
> The mobo has a total of 4 USB ports 2.0 at the back. The problem lies at
> the usb devices, and hotplug. 
> 
> I have a usb bluetooth dongle connected, and a usb to serial adaptor.
> This setup gets me to KDE ok, and everything works, including some usb
> storage devices that I may plug during up-time.
> 
> But, if I try to restart hotplug, I get kernel oops. From there on,
> pretty much everything will seg fault when I try to load it, I can not
> login to a console, and when the machine tries to reboot, it hangs.
> strace shows that apps hang when trying to access /dev/tty.
> 
> Similar problems exist even with kernel 2.6.4. I have tried the same usb
> devices in 2 more similar PC's (with the same mobo), and all produce the
> same error. When more usb devices are connected at boot, things can lead
> to a total lockup during boot.
> 
> Anyone has any ideas what I can do about this? Are there any known
> problems with VIA chips and linux? I have the results from ksymoops on
> those oop'ses at home, if anyone is interested, I can send them.
> 
> Thanks,
> Emmanuel
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--=-zijugB7/1WbOsoVGEcmU
Content-Disposition: attachment; filename=results
Content-Type: text/plain; name=results; charset=ISO-8859-7
Content-Transfer-Encoding: 7bit

Unable to handle kernel paging request at virtual address e0d5fc70
c026ba16
*pde = 1f763067
Oops: 0000
CPU:    0
EIP:    0010:[<c026ba16>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00008801   ebx: 00000088   ecx: 00008802   edx: e0d5fc60
esi: 00000001   edi: 00008801   ebp: dfe7ecc8   esp: cd09be58
ds: 0018   es: 0018   ss: 0018
Process input.rc (pid: 4586, stackpage=cd09b000)
Stack: dfe7ecc0 00000000 c026c6ae 00008801 c0134d99 d2d2c480 cc131ec0 080bbee6
       00000000 cf5fb2ec d2d2c480 d2d2c49c c011cd02 d2d2c480 cc131ec0 080bbee6
       dfe7ecc0 00000000 df890dc0 dfe7ecc8 c026d3da 00008801 cd09bec8 c158c640
Call Trace:    [<c026c6ae>] [<c0134d99>] [<c011cd02>] [<c026d3da>] [<c0162331>]
  [<c015856c>] [<c019fdca>] [<c0158929>] [<c014bb65>] [<c0149a03>] [<c0149928>]
  [<c0149d1b>] [<c010963f>]
Code: 0f bf 42 10 39 d8 74 12 8b 92 b4 00 00 00 85 d2 75 ee 31 c9
Error (pclose_local): Oops_decode_part pclose failed 0xb
Error (Oops_decode_part): no objdump lines read for /tmp/ksymoops.5JQW9M


>>EIP; c026ba16 <get_tty_driver+16/50>   <=====

>>edx; e0d5fc60 <[tuner].data.end+5245/f645>
>>ebp; dfe7ecc8 <_end+1f9ab184/2074351c>
>>esp; cd09be58 <_end+cbc8314/2074351c>

Trace; c026c6ae <init_dev+1e/4b0>
Trace; c0134d99 <handle_mm_fault+69/a0>
Trace; c011cd02 <do_page_fault+142/4e0>
Trace; c026d3da <tty_open+6a/430>
Trace; c0162331 <dput+21/150>
Trace; c015856c <link_path_walk+4dc/640>
Trace; c019fdca <devfs_open+19a/230>
Trace; c0158929 <path_lookup+39/40>
Trace; c014bb65 <get_empty_filp+65/1a0>
Trace; c0149a03 <dentry_open+d3/1e0>
Trace; c0149928 <filp_open+68/70>
Trace; c0149d1b <sys_open+5b/e0>
Trace; c010963f <system_call+33/38>

Unable to handle kernel paging request at virtual address e0d5fc70
c026ba16
*pde = 1f763067
Oops: 0000
CPU:    0
EIP:    0010:[<c026ba16>]    Tainted: PF
EFLAGS: 00010286
eax: 00008801   ebx: 00000088   ecx: 00008802   edx: e0d5fc60
esi: 00000001   edi: 00008801   ebp: dfe7ecc8   esp: cd09be58
ds: 0018   es: 0018   ss: 0018
Process pci.rc (pid: 4587, stackpage=cd09b000)
Stack: dfe7ecc0 00000000 c026c6ae 00008801 c0134d99 d2d2c480 cf551cc0 080bbee6
       00000000 cf5fa2ec d2d2c480 d2d2c49c c011cd02 d2d2c480 cf551cc0 080bbee6
       dfe7ecc0 00000000 df890dc0 dfe7ecc8 c026d3da 00008801 cd09bec8 c158c640
Call Trace:    [<c026c6ae>] [<c0134d99>] [<c011cd02>] [<c026d3da>] [<c0162331>]
  [<c015856c>] [<c019fdca>] [<c0158929>] [<c014bb65>] [<c0149a03>] [<c0149928>]
  [<c0149d1b>] [<c010963f>]
Code: 0f bf 42 10 39 d8 74 12 8b 92 b4 00 00 00 85 d2 75 ee 31 c9
Error (pclose_local): Oops_decode_part pclose failed 0xb
Error (Oops_decode_part): no objdump lines read for /tmp/ksymoops.wreYXM


>>EIP; c026ba16 <get_tty_driver+16/50>   <=====

>>edx; e0d5fc60 <[tuner].data.end+5245/f645>
>>ebp; dfe7ecc8 <_end+1f9ab184/2074351c>
>>esp; cd09be58 <_end+cbc8314/2074351c>

Trace; c026c6ae <init_dev+1e/4b0>
Trace; c0134d99 <handle_mm_fault+69/a0>
Trace; c011cd02 <do_page_fault+142/4e0>
Trace; c026d3da <tty_open+6a/430>
Trace; c0162331 <dput+21/150>
Trace; c015856c <link_path_walk+4dc/640>
Trace; c019fdca <devfs_open+19a/230>
Trace; c0158929 <path_lookup+39/40>
Trace; c014bb65 <get_empty_filp+65/1a0>
Trace; c0149a03 <dentry_open+d3/1e0>
Trace; c0149928 <filp_open+68/70>
Trace; c0149d1b <sys_open+5b/e0>
Trace; c010963f <system_call+33/38>

Unable to handle kernel paging request at virtual address e0d5fc70
c026ba16
*pde = 1f763067
Oops: 0000
CPU:    0
EIP:    0010:[<c026ba16>]    Tainted: PF
EFLAGS: 00010286
eax: 00008801   ebx: 00000088   ecx: 00008802   edx: e0d5fc60
esi: 00000001   edi: 00008801   ebp: dfe7ecc8   esp: cd09be58
ds: 0018   es: 0018   ss: 0018
Process usb.rc (pid: 4588, stackpage=cd09b000)
Stack: dfe7ecc0 00000000 c026c6ae 00008801 c0134d99 d2d2c480 cf54fa40 080bbee6
       00000000 cf5fb2ec d2d2c480 d2d2c49c c011cd02 d2d2c480 cf54fa40 080bbee6
       dfe7ecc0 00000000 df890dc0 dfe7ecc8 c026d3da 00008801 cd09bec8 c158c640
Call Trace:    [<c026c6ae>] [<c0134d99>] [<c011cd02>] [<c026d3da>] [<c0162331>]
  [<c015856c>] [<c019fdca>] [<c0158929>] [<c014bb65>] [<c0149a03>] [<c0149928>]
  [<c0149d1b>] [<c010963f>]
Code: 0f bf 42 10 39 d8 74 12 8b 92 b4 00 00 00 85 d2 75 ee 31 c9
Error (pclose_local): Oops_decode_part pclose failed 0xb
Error (Oops_decode_part): no objdump lines read for /tmp/ksymoops.Zh8GNM


>>EIP; c026ba16 <get_tty_driver+16/50>   <=====

>>edx; e0d5fc60 <[tuner].data.end+5245/f645>
>>ebp; dfe7ecc8 <_end+1f9ab184/2074351c>
>>esp; cd09be58 <_end+cbc8314/2074351c>

Trace; c026c6ae <init_dev+1e/4b0>
Trace; c0134d99 <handle_mm_fault+69/a0>
Trace; c011cd02 <do_page_fault+142/4e0>
Trace; c026d3da <tty_open+6a/430>
Trace; c0162331 <dput+21/150>
Trace; c015856c <link_path_walk+4dc/640>
Trace; c019fdca <devfs_open+19a/230>
Trace; c0158929 <path_lookup+39/40>
Trace; c014bb65 <get_empty_filp+65/1a0>
Trace; c0149a03 <dentry_open+d3/1e0>
Trace; c0149928 <filp_open+68/70>
Trace; c0149d1b <sys_open+5b/e0>
Trace; c010963f <system_call+33/38>

--=-zijugB7/1WbOsoVGEcmU--

