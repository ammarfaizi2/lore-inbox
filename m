Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTLNMbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 07:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTLNMbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 07:31:20 -0500
Received: from mail.orange.sk ([213.151.200.4]:7089 "HELO mail.orangemail.sk")
	by vger.kernel.org with SMTP id S262750AbTLNMa4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 07:30:56 -0500
From: Marian Stepka <mstepka@orangemail.sk>
Reply-To: stepka@tris.sk
Organization: Klifton project
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel pging problem
Date: Sun, 14 Dec 2003 13:28:06 +0100
User-Agent: KMail/1.5.4
Cc: marian.stepka@onsemi.com
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312141328.22811.mstepka@orangemail.sk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi;

1. SUMMARY
- ----------

Kernel paniced and system froze after running Konqueror from KDE desktop.

2. FULL DESCRIPTION
- -------------------

I reinstall my system from RedHat 9 to Fedora Core 1 with latest available 
kernel update from RedHat. I'm using VPN client software which taint the 
kernel but I hope this information could be usefull for kernel development 
and that is reason why I'm posting it. I will include copy of this message to 
proprietary VPN software developers.

After upgrade been done I log in as a regular user and launch Konqueror from 
KDE desktop what froze kernel and whole system. I try to reboot and did same 
again what brought same problem. I uninstalled VPN software and problem is 
gone for now, so that peace of software have something with it.

On the other hand I'm running same client on my notebook without problems so I 
think that this is also have some connection with broken kernel code. Is up 
to you if you decide to do something about it.

3. KEYWORDS
- -----------

kernel, modules, VPN, X, KDE

4. KERNEL VERSION
- ------------------

Linux version 2.4.22-1.2129.nptl (bhcompile@bugs.devel.redhat.com) (gcc 
version 3.2.3 20030422 (Red Hat Linux 3.2.3-6)) #1 Mon Dec 1 08:36:24 EST 
2003

5. OUTPUT OF OOPS
- -----------------

Dec 13 12:38:14 imro kernel: Unable to handle kernel paging request at virtual 
address 9a005f08
Dec 13 12:38:14 imro kernel:  printing eip:
Dec 13 12:38:14 imro kernel: c020655e
Dec 13 12:38:14 imro kernel: *pde = 00000000
Dec 13 12:38:14 imro kernel: Oops: 0000
Dec 13 12:38:14 imro kernel: via82cxxx_audio ac97_codec uart401 sound 
soundcore r128 agpgart parport_pc lp parport nlvcard mishim autofs 
iptable_filter ip_tables sis900 microcode usb-stor
Dec 13 12:38:14 imro kernel: CPU:    0
Dec 13 12:38:14 imro kernel: EIP:    0060:[<c020655e>]    Tainted: P 
Dec 13 12:38:14 imro kernel: EFLAGS: 00010286
Dec 13 12:38:14 imro kernel: 
Dec 13 12:38:14 imro kernel: EIP is at sock_poll [kernel] 0xe 
(2.4.22-1.2129.nptl)
Dec 13 12:38:14 imro kernel: eax: 9a005f00   ebx: 00000000   ecx: dc428800   
edx: 00000000
Dec 13 12:38:14 imro kernel: esi: dc428800   edi: 00000017   ebp: 00800000   
esp: e1ff1f14
Dec 13 12:38:14 imro kernel: ds: 0068   es: 0068   ss: 0068
Dec 13 12:38:14 imro kernel: Process X (pid: 3625, stackpage=e1ff1000)
Dec 13 12:38:14 imro kernel: Stack: 00000000 dc428700 00000016 00000000 
c015422e dc428800 00000000 e1ff0000 
Dec 13 12:38:14 imro kernel:        00000145 e1ff0000 000023a7 00000001 
00000000 00000000 dad69000 00000000 
Dec 13 12:38:14 imro gdm(pam_unix)[3624]: session closed for user ffp3yf
Dec 13 12:38:14 imro kernel:        00000020 e3062240 bfe606f8 c01545be 
00000019 e1ff1f90 e1ff1f8c 0000011f 
Dec 13 12:38:15 imro kernel: Call Trace:   [<c015422e>] do_select [kernel] 
0x21e (0xe1ff1f24)
Dec 13 12:38:15 imro kernel: [<c01545be>] sys_select [kernel] 0x34e 
(0xe1ff1f60)
Dec 13 12:38:15 imro kernel: [<c0108c38>] restore_sigcontext [kernel] 0x128 
(0xe1ff1f7c)
Dec 13 12:38:15 imro kernel: [<c0109747>] system_call [kernel] 0x33 
(0xe1ff1fc0)
Dec 13 12:38:15 imro kernel: 
Dec 13 12:38:15 imro kernel: 
Dec 13 12:38:16 imro kernel: Code: 8b 50 08 8b 44 24 18 81 c2 20 01 00 00 8b 
5a 08 89 44 24 08 
Dec 13 12:38:16 imro kernel:  <1>Unable to handle kernel paging request at 
virtual address 9a005f08
Dec 13 12:38:16 imro kernel:  printing eip:
Dec 13 12:38:16 imro kernel: c015bb2a
Dec 13 12:38:16 imro kernel: *pde = 00000000
Dec 13 12:38:16 imro kernel: Oops: 0000
Dec 13 12:38:16 imro kernel: via82cxxx_audio ac97_codec uart401 sound 
soundcore r128 agpgart parport_pc lp parport nlvcard mishim autofs 
iptable_filter ip_tables sis900 microcode usb-stor
Dec 13 12:38:16 imro kernel: CPU:    0
Dec 13 12:38:16 imro kernel: EIP:    0060:[<c015bb2a>]    Tainted: P 
Dec 13 12:38:16 imro kernel: EFLAGS: 00010296
Dec 13 12:38:17 imro kernel: 
Dec 13 12:38:17 imro kernel: EIP is at dnotify_flush [kernel] 0x1a 
(2.4.22-1.2129.nptl)
Dec 13 12:38:17 imro kernel: eax: 9a005f00   ebx: dc428800   ecx: e1ff3000   
edx: 00000000
Dec 13 12:38:17 imro kernel: esi: e2286280   edi: dc428800   ebp: 00000001   
esp: e1ff1dac
Dec 13 12:38:17 imro kernel: ds: 0068   es: 0068   ss: 0068
Dec 13 12:38:17 imro kernel: Process X (pid: 3625, stackpage=e1ff1000)
Dec 13 12:38:17 imro kernel: Stack: e449a980 dc428700 dc428800 e2286280 
00000000 c014329a dc428800 e2286280 
Dec 13 12:38:17 imro kernel:        00000003 00000017 e2286280 c011fa3c 
dc428800 e2286280 e1ff0000 e7757e80 
Dec 13 12:38:17 imro kernel:        e7757ea4 e1ff0000 0000000b c01205d0 
e2286280 e7757ea4 e1ff1ee0 e7757ea4 
Dec 13 12:38:17 imro kernel: Call Trace:   [<c014329a>] filp_close [kernel] 
0x3a (0xe1ff1dc0)
Dec 13 12:38:18 imro kernel: [<c011fa3c>] put_files_struct [kernel] 0x8c 
(0xe1ff1dd8)
Dec 13 12:38:18 imro kernel: [<c01205d0>] do_exit [kernel] 0x100 (0xe1ff1df8)
Dec 13 12:38:18 imro kernel: [<c0109e20>] do_divide_error [kernel] 0x0 
(0xe1ff1e14)
Dec 13 12:38:18 imro kernel: [<c0117da4>] do_page_fault [kernel] 0x2a4 
(0xe1ff1e28)
Dec 13 12:38:18 imro kernel: [<c0258eb5>] unix_stream_sendmsg [kernel] 0x205 
(0xe1ff1e48)
Dec 13 12:38:18 imro kernel: [<c011948b>] schedule [kernel] 0x2bb (0xe1ff1eb0)
Dec 13 12:38:18 imro kernel: [<c013bdeb>] __alloc_pages [kernel] 0x4b 
(0xe1ff1ebc)
Dec 13 12:38:18 imro kernel: [<c0117b00>] do_page_fault [kernel] 0x0 
(0xe1ff1ecc)
Dec 13 12:38:18 imro kernel: [<c0109838>] error_code [kernel] 0x34 
(0xe1ff1ed4)
Dec 13 12:38:18 imro kernel: [<c020655e>] sock_poll [kernel] 0xe (0xe1ff1f08)
Dec 13 12:38:19 imro kernel: [<c015422e>] do_select [kernel] 0x21e 
(0xe1ff1f24)
Dec 13 H&:38:19 imro kernel: [<c01545be>] sys_select [kernel] 0x34e 
(0xe1ff1f60)
Dec 13 12:38:19 imro kernel: [<c0108c38>] restore_sigcontext [kernel] 0x128 
(0xe1ff1f7c)
Dec 13 12:38:19 imro kernel: [<c0109747>] system_call [kernel] 0x33 
(0xe1ff1fc0)
Dec 13 12:38:19 imro kernel: 
Dec 13 12:38:19 imro kernel: 

6. EXAMPLE PROGRAM
- ------------------

None.

7. ENVIRONMENT
- --------------
HOSTNAME=imro.klifton.sk
SHELL=/bin/bash
TERM=xterm
HISTSIZE=1000
QTDIR=/usr/lib/qt-3.1
OLDPWD=/root
USER=root
LS_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:
USERNAME=root
MAIL=/var/spool/mail/root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/root/bin
INPUTRC=/etc/inputrc
PWD=/var/log
LANG=en_US.UTF-8
SSH_ASKPASS=/usr/libexec/openssh/gnome-ssh-askpass
SHLVL=1
HOME=/root
BASH_ENV=/root/.bashrc
LOGNAME=root
LESSOPEN=|/usr/bin/lesspipe.sh %s
DISPLAY=:0.0
G_BROKEN_FILENAMES=1
XAUTHORITY=/root/.xauthTWrmUW
_=/bin/env

7. SOFTWARE
- -----------
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux imro.klifton.sk 2.4.22-1.2129.nptl #1 Mon Dec 1 08:36:24 EST 2003 i686 
i686 i386 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.3
reiserfsprogs          3.6.8
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         ppp_deflate ppp_async ppp_generic slhc via82cxxx_audio 
ac97_codec uart401 sound soundcore r128 agpgart parport_pc lp parport autofs 
iptable_filter ip_tables sis900 microcode floppy sg usb-storage keybdev 
mousedev hid input usb-uhci usbcore ext3 jbd aic7xxx sd_mod scsi_mod

8. PROCESSOR
- ------------
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 851.944
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse
bogomips        : 1697.38

9. MODULES
- ----------

ppp_deflate             4248   0 (autoclean)
ppp_async               8192   0 (autoclean)
ppp_generic            23996   0 (autoclean) [ppp_deflate ppp_async]
slhc                    6756   0 (autoclean) [ppp_generic]
via82cxxx_audio        23992   0 (autoclean)
ac97_codec             16712   0 (autoclean) [via82cxxx_audio]
uart401                 7972   0 (autoclean) [via82cxxx_audio]
sound                  72276   0 (autoclean) [via82cxxx_audio uart401]
soundcore               6468   5 (autoclean) [via82cxxx_audio sound]
r128                   92504  15
agpgart                55492   3
parport_pc             18756   1 (autoclean)
lp                      8580   0 (autoclean)
parport                37056   1 (autoclean) [parport_pc lp]
autofs                 12084   0 (autoclean) (unused)
iptable_filter          2444   0 (autoclean) (unused)
ip_tables              15008   1 [iptable_filter]
sis900                 15756   1
microcode               4188   0 (autoclean)
floppy                 57308   0 (autoclean)
sg                     35436   0 (autoclean)
usb-storage            70624   1
keybdev                 2656   0 (unused)
mousedev                5268   1
hid                    23908   0 (unused)
input                   5888   0 [keybdev mousedev hid]
usb-uhci               26124   0 (unused)
usbcore                78752   1 [usb-storage hid usb-uhci]
ext3                   71300   4
jbd                    51052   4 [ext3]
aic7xxx               165584   0 (unused)
sd_mod                 13388   2
scsi_mod              110248   4 [sg usb-storage aic7xxx sd_mod]

10. DRIVERS and HARDWARE
- -------------------------

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
a000-a00f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC 
Bus Master IDE
  a000-a007 : ide0
  a008-a00f : ide1
a400-a41f : VIA Technologies, Inc. USB
  a400-a41f : usb-uhci
a800-a81f : VIA Technologies, Inc. USB (#2)
  a800-a81f : usb-uhci
ac00-acff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  ac00-acff : via82cxxx_audio
b000-b003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  b000-b003 : via82cxxx_audio
b400-b403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  b400-b403 : via82cxxx_audio
bc00-bcff : Adaptec AHA-2940/2940W / AIC-7871
c000-c0ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  c000-c0ff : sis900

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-27ffffff : System RAM
  00100000-0026f97d : Kernel code
  0026f97e-00381c67 : Kernel data
d0000000-d7ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
d8000000-dbffffff : PCI Bus #01
  d8000000-dbffffff : ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
dc000000-ddffffff : PCI Bus #01
  dd000000-dd003fff : ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
df000000-df000fff : Adaptec AHA-2940/2940W / AIC-7871
  df000000-df000fff : aic7xxx
df001000-df001fff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  df001000-df001fff : sis900
ffff0000-ffffffff : reserved

11. PCI
- --------
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a30
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d8000000-dbffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a30
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at a000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at a400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a30
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 50)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a30
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 9
        Region 0: I/O ports at ac00 [size=256]
        Region 1: I/O ports at b000 [size=4]
        Region 2: I/O ports at b400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Adaptec AHA-2940/2940W / AIC-7871 (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at bc00 [disabled] [size=256]
        Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet 
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c000 [size=256]
        Region 1: Memory at df001000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x 
TMDS (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 5446
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


12. SCSI
- --------

Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: HITACHI_ Model: DK239A-65B       Rev: 0811
  Type:   Direct-Access                    ANSI SCSI revision: 02

13. OTHER
- ---------

- -- 
Marian Stepka mailto:mstepka@orangemail.sk
*GEEK BY NATURE LINUX BY CHOICE*

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/3FdlAzij4w6aVFERAiSNAKDIjusTcZWWSffNUvya46qR00RTtwCgx7l4
WK/GSkIyEPpMs4CLsjF9wwY=
=YGCj
-----END PGP SIGNATURE-----

