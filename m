Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUJGT6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUJGT6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUJGT54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:57:56 -0400
Received: from [65.37.126.18] ([65.37.126.18]:28544 "EHLO the-penguin.otak.com")
	by vger.kernel.org with ESMTP id S267595AbUJGTzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:55:55 -0400
Date: Thu, 7 Oct 2004 12:55:48 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: opps 2.6.9-r3-mm3
Message-ID: <20041007195548.GA4425@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.9-rc3n on an i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I had repeated oops after boot-up. Looked like scheduler stuff.
Not sure what else is needed this is a all scsi system if that is any
help for debuging.

As always I'm willing to try patches or give any additional information
as needed.



Included decoded oops, ver_linux, and lspci -vvv


ksymoops 2.4.9 on i686 2.6.9-rc3-mm3n.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9-rc3-mm3n/ (default)
     -m /System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oct  7 09:34:10 the-penguin kernel: Unable to handle kernel paging request at virtual address 0001530c
Oct  7 09:34:10 the-penguin kernel: c0116f21
Oct  7 09:34:10 the-penguin kernel: *pde = 00000000
Oct  7 09:34:10 the-penguin kernel: Oops: 0002 [#1]
Oct  7 09:34:10 the-penguin kernel: CPU:    0
Oct  7 09:34:10 the-penguin kernel: EIP:    0060:[profile_hit+33/48]    Not tainted VLI
Oct  7 09:34:10 the-penguin kernel: EFLAGS: 00010086   (2.6.9-rc3-mm3n)
Oct  7 09:34:10 the-penguin kernel: eax: 00000000   ebx: eebaa0a0   ecx: 00000000   edx: 0001530c
Oct  7 09:34:10 the-penguin kernel: esi: ffffffea   edi: 00000000   ebp: eebc7fbc   esp: eebc7f98
Oct  7 09:34:10 the-penguin kernel: ds: 007b   es: 007b   ss: 0068
Oct  7 09:34:10 the-penguin kernel: Stack: c0113c5a c046be60 f69c5820 b8000c00 00000086 00000000 00000d62 00000001
Oct  7 09:34:10 the-penguin kernel:        b7a0d2a0 eebc6000 c01056eb 00000d62 00000000 bffff458 00000001 b7a0d2a0
Oct  7 09:34:10 the-penguin kernel:        bffff458 0000009c 0000007b 0000007b 0000009c b7b17504 00000073 00000246
Oct  7 09:34:10 the-penguin kernel: Call Trace:
Oct  7 09:34:10 the-penguin kernel: Code: 00 00 00 8d bc 27 00 00 00 00 8b 0d ec 10 47 c0 a1 e8 10 47 c0 81 ea 28 02 10 c0 d3 ea 48 39 d0 0f 46 d0 a1 e4 10 47 c0 8d 14 90 <ff> 02 c3 8d b6 00 00 00 00 8d bf 00 00 00 00 b8 da ff ff ff c3
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; eebaa0a0 <pg0+2e7230a0/3fb77400>
>>esi; ffffffea <__kernel_rt_sigreturn+1baa/????>
>>ebp; eebc7fbc <pg0+2e740fbc/3fb77400>
>>esp; eebc7f98 <pg0+2e740f98/3fb77400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   00 00                     add    %al,(%eax)
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   00 8d bc 27 00 00         add    %cl,0x27bc(%ebp)
Code;  ffffffdd <__kernel_rt_sigreturn+1b9d/????>
   8:   00 00                     add    %al,(%eax)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   8b 0d ec 10 47 c0         mov    0xc04710ec,%ecx
Code;  ffffffe5 <__kernel_rt_sigreturn+1ba5/????>
  10:   a1 e8 10 47 c0            mov    0xc04710e8,%eax
Code;  ffffffea <__kernel_rt_sigreturn+1baa/????>
  15:   81 ea 28 02 10 c0         sub    $0xc0100228,%edx
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   d3 ea                     shr    %cl,%edx
Code;  fffffff2 <__kernel_rt_sigreturn+1bb2/????>
  1d:   48                        dec    %eax
Code;  fffffff3 <__kernel_rt_sigreturn+1bb3/????>
  1e:   39 d0                     cmp    %edx,%eax
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   0f 46 d0                  cmovbe %eax,%edx
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   a1 e4 10 47 c0            mov    0xc04710e4,%eax
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8d 14 90                  lea    (%eax,%edx,4),%edx
Code;  00000000 Before first symbol
  2b:   ff 02                     incl   (%edx)
Code;  00000002 Before first symbol
  2d:   c3                        ret    
Code;  00000003 Before first symbol
  2e:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  00000009 Before first symbol
  34:   8d bf 00 00 00 00         lea    0x0(%edi),%edi
Code;  0000000f Before first symbol
  3a:   b8 da ff ff ff            mov    $0xffffffda,%eax
Code;  00000014 Before first symbol
  3f:   c3                        ret    


1 error issued.  Results may not be reliable.


If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux the-penguin 2.6.9-rc3n #3 Thu Oct 7 09:44:18 PDT 2004 i686 GNU/Linux
 
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
quota-tools            3.12.
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.3
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         nls_cp850 smbfs deflate zlib_inflate aes_i586 esp6 ah6 ipcomp esp4 ah4 xfrm_user wp512 twofish tea sha512 sha256 sha1 serpent md5 md4 khazad des crypto_null cast6 cast5 blowfish zlib_deflate binfmt_misc ipv6 ehci_hcd uhci_hcd 3c59x mii snd_cmipci snd_opl3_lib snd_hwdep snd_mpu401_uart snd_rawmidi nls_iso8859_15 nls_utf8 nls_iso8859_1 nls_cp437 nls_cp950 radeon via_agp agpgart sg sr_mod cdrom


0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Subsystem: Asustek Computer, Inc. A7V333 Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: de800000-df6fffff
	Prefetchable memory behind bridge: dff00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at b800 [size=256]
	Capabilities: <available only to root>

0000:00:06.0 RAID bus controller: Promise Technology, Inc. PDC20276 (MBFastTrak133 Lite) (rev 01) (prog-if 85)
	Subsystem: Asustek Computer, Inc.: Unknown device 807e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a000 [size=16]
	Region 5: Memory at de000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

0000:00:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 35 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at dd800000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

0000:00:09.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 4: I/O ports at 9800 [size=32]
	Capabilities: <available only to root>

0000:00:09.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 16
	Region 4: I/O ports at 9400 [size=32]
	Capabilities: <available only to root>

0000:00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 17
	Region 0: Memory at dc800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:0c.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2W
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (7500ns min, 16000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at db800000 (32-bit, non-prefetchable) [size=4K]

0000:00:0e.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1060
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 8800 [size=256]
	Region 1: Memory at db000000 (64-bit, non-prefetchable) [size=64K]
	Region 3: Memory at da800000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 8400 [size=128]
	Region 1: Memory at da000000 (32-bit, non-prefetchable) [size=128]
	Capabilities: <available only to root>

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc. A7V8X motherboard
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 8000 [disabled] [size=16]
	Capabilities: <available only to root>

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. VT6202 USB2.0 4 port controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 21
	Region 4: I/O ports at 7800 [size=32]
	Capabilities: <available only to root>

0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. VT6202 USB2.0 4 port controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 21
	Region 4: I/O ports at 7400 [size=32]
	Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon 8500 LE] (prog-if 00 [VGA])
	Subsystem: PC Partner Limited Radeon R200 QL [Sapphire Radeon 8500 LE]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at de800000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


