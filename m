Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288255AbSA0Rir>; Sun, 27 Jan 2002 12:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288262AbSA0Ri3>; Sun, 27 Jan 2002 12:38:29 -0500
Received: from mx0.gmx.de ([213.165.64.100]:5553 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S288255AbSA0RiK>;
	Sun, 27 Jan 2002 12:38:10 -0500
Date: Sun, 27 Jan 2002 18:38:02 +0100 (MET)
From: Philipp Benner <philipp_benner@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: PROBLEM: My USB controller dosn't work correctly
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005738059@gmx.net
X-Authenticated-IP: [217.226.220.157]
Message-ID: <1702.1012153082@www40.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] My USB controller dosn't work correctly
[2.] I've the Logitech MiniWheel Mouse USB. After booting linux it works
correctly, but some hours or days later
     i can't move the curser any longer. There is an error message like this
at tty1: 

usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)

     If i reconnect the mouse the same error message comes again. After
rebooting it works...
[3.]  <*> Support for USB 
       [*]   USB verbose debug messages
       --- Miscellaneous USB options
       [*]   Preliminary USB device filesystem
       [ ]   Enforce USB bandwidth allocation (EXPERIMENTAL)
       [ ]   Long timeout for slow-responding devices (some MGE Ellipse
UPSes) (Same problem with this option enabled)
       --- USB Controllers
       <*>   UHCI Alternate Driver (JE) support
       < >   OHCI (Compaq, iMacs, OPTi, SiS, ALi, ...) support
       --- USB Device Class drivers
       < >   USB Audio support
       < >   USB Bluetooth support (EXPERIMENTAL)
       < >   USB Mass Storage support
       < >   USB Modem (CDC ACM) support
       < >   USB Printer support 
       --- USB Human Interface Devices (HID)
       < >   USB Human Interface Device (full HID) support  (Same problem
with this option enabled)
       < >   USB HIDBP Keyboard (basic) support
       <*>   USB HIDBP Mouse (basic) support
       <*>   Wacom Intuos/Graphire tablet support       (Same problem
without this option enabled)
       --- USB Imaging devices
       < >   USB Kodak DC-2xx Camera support
       < >   USB Mustek MDC800 Digital Camera support (EXPERIMENTAL)
       < >   USB Scanner support
       < >   Microtek X6USB scanner support 
       < >   HP53xx USB scanner support (EXPERIMENTAL)                      
         
       --- USB Multimedia devices                                           
                        
       < >   USB IBM (Xirlink) C-it Camera support                          
                    
       < >   USB OV511 Camera support                                       
                    
       < >   USB Philips Cameras               
       < >   USB SE401 Camera support 
       < >   D-Link USB FM radio support (EXPERIMENTAL) 
       < >   DABUSB driver 
       --- USB Network adaptors                                             
                         
       < >   USB ADMtek Pegasus-based ethernet device support (EXPERIMENTAL)
                                        < >   USB KLSI KL5USB101-based
ethernet device support (EXPERIMENTAL)                                         < >
  USB CATC NetMate-based Ethernet device support (EXPERIMENTAL) 
       < >   USB Communication Class Ethernet device support (EXPERIMENTAL) 

       < >   USB-to-USB Networking cable device support (EXPERIMENTAL)
       --- USB port drivers
       < >   USS720 parport driver

[4.] cat /proc/version
     Linux version 2.4.17 (root@warlock) (gcc version 2.95.4 20011006
(Debian prerelease)) #4 Son Dez 23 14:16:58 CET 2001

[5.] cat /proc/cpuinfo
     processor       : 0
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 7
     model name      : Pentium III (Katmai)
     stepping        : 2
     cpu MHz         : 501.178
     cache size      : 512 KB
     fdiv_bug        : no
     hlt_bug         : no
     f00f_bug        : no
     coma_bug        : no
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 2
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
     bogomips        : 999.42

[6.] lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
(rev 06)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 16
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev
07)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at d000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
        Subsystem: Creative Labs CT4850 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.1 Input device controller: Creative Labs SB Live! (rev 01)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA
push (rev 12)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at ee000000 (32-bit, prefetchable) [size=4K]

00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e000 [size=32]

00:14.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)
        Subsystem: Allied Telesyn International: Unknown device 2503
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at e400 [size=256]
        Region 1: Memory at ee001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
(rev a1) (prog-if 00 [VGA])
        Subsystem: Elsa AG: Unknown device 0c60
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at ed000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=7 SBA- AGP+ 64bit- FW- Rate=x2

[7.] cat /proc/driver/uhci/hc0
     HC status
       usbcmd    =     00c1   Maxp64 CF RS 
       usbstat   =     0000   
       usbint    =     000f
       usbfrnum  =   (0)21c
       flbaseadd = 17ef0000
       sof       =       40
       stat1     =     05a5   LowSpeed PortEnabled PortConnected 
       stat2     =     0580   LowSpeed 
     Frame List
     Skeleton TD's
     - skel_term_td
         [d7ef51b0] link (17ef51b0) e0 IOC Length=0 MaxLen=7ff DT0 EndPt=0
Dev=7f, PID=69(IN) (buf=00000000)
     Skeleton QH's

[8.] cat /proc/bus/usb/devices
     T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
     B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
     D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
     P:  Vendor=0000 ProdID=0000 Rev= 0.00
     S:  Product=USB UHCI-alt Root Hub
     S:  SerialNumber=d400
     C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
     I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
     E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms

[9.] cat /proc/bus/usb/drivers
         usbdevfs
         hub
         usb_mouse
         wacom

Thanks for your help!

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

