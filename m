Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262856AbRFJU6m>; Sun, 10 Jun 2001 16:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262629AbRFJU6W>; Sun, 10 Jun 2001 16:58:22 -0400
Received: from mail.mediaways.net ([193.189.224.113]:32887 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S262355AbRFJU6V>; Sun, 10 Jun 2001 16:58:21 -0400
Date: Sun, 10 Jun 2001 22:20:25 +0200
From: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: oops with 2.4.5-ac12
Message-ID: <20010610222025.A15817@frodo.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops with 2.4.5-ac12 after I issued "rmmod -a"
twice. I only notices the oops after I issued "rmmod -a" once which
might explan that ksymoops cannot name the module which caused the oops.

This is possibly ALSA-related (although I never had problems with
unloading alsa modules befode).

Walter





WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from ftp://ftp.ocs.com.au/pub/ksymoops
Options used: -V (default)
              -o /lib/modules/2.4.5-ac12/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /usr/src/linux/System.map (default)
              -c 1 (default)

You did not tell me where to find symbol information.  I will assume
that the log matches the kernel and modules that are running right now
and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address c8d92ae0
c017f7de
*pde = 012db067
Oops: 0002
CPU:    0
EIP:    0010:[<c017f7de>]
EFLAGS: 00010202
eax: c01fc810   ebx: c8dc89dc   ecx: c01f6338   edx: c8d92ae0
esi: c8dc7d60   edi: c8dc89c0   ebp: c8dc88dc   esp: c4c6ff78
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 14454, stackpage=c4c6f000)
Stack: c8dc89dc 00000008 c8dc30dc c8dc7d60 c8dbe000 c8dbe000 00000001 bfffe044 
       c0116e07 c8dbe000 c8db6000 00000001 c0116332 c8dbe000 00000001 c4c6e000 
       08059a14 00000061 c0106af3 00000000 00000000 00000028 08059a14 00000061 
Call Trace: [<c8dc89dc>] [<c8dc30dc>] [<c8dc7d60>] [<c8dbe000>] [<c8dbe000>] 
   [<c0116e07>] [<c8dbe000>] [<c8db6000>] [<c0116332>] [<c8dbe000>] [<c0106af3>] 
Code: 89 02 8b 1d 08 c8 1f c0 81 fb 08 c8 1f c0 74 25 89 f6 39 73 

>>EIP: c017f7de <pci_unregister_driver+e/48>
Trace: c8dc89dc <END_OF_CODE+1af70/????>
Trace: c8dc30dc <END_OF_CODE+15670/????>
Trace: c8dc7d60 <END_OF_CODE+1a2f4/????>
Trace: c8dbe000 <END_OF_CODE+10594/????>
Trace: c8dbe000 <END_OF_CODE+10594/????>
Trace: c0116e07 <free_module+1b/9c>
Code:  c017f7de <pci_unregister_driver+e/48>   00000000 <_EIP>: <===
Code:  c017f7de <pci_unregister_driver+e/48>      0:	89 02                	movl   %eax,(%edx) <===
Code:  c017f7e0 <pci_unregister_driver+10/48>     2:	8b 1d 08 c8 1f c0    	movl   0xc01fc808,%ebx
Code:  c017f7e6 <pci_unregister_driver+16/48>     8:	81 fb 08 c8 1f c0    	cmpl   $0xc01fc808,%ebx
Code:  c017f7ec <pci_unregister_driver+1c/48>     e:	74 25                	je      c017f813 <pci_unregister_driver+43/48>
Code:  c017f7ee <pci_unregister_driver+1e/48>    10:	89 f6                	movl   %esi,%esi
Code:  c017f7f0 <pci_unregister_driver+20/48>    12:	39 73 00             	cmpl   %esi,0x0(%ebx)


95 warnings and 12 errors issued.  Results may not be reliable.

/proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge (rev 3).
      Master Capable.  Latency=32.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=11.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 1).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 15.
      Master Capable.  Latency=32.  
      I/O at 0x6e00 [0x6e1f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 1).
      IRQ 9.
  Bus  0, device   9, function  0:
    Multimedia audio controller: S3 Inc. SonicVibes (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0x6800 [0x680f].
      I/O at 0x6900 [0x690f].
      I/O at 0x6a00 [0x6a03].
      I/O at 0x6b00 [0x6b03].
      I/O at 0x6c00 [0x6c07].
  Bus  0, device  10, function  0:
    Ethernet controller: Winbond Electronics Corp W89C940 (rev 0).
      IRQ 9.
      I/O at 0x6d00 [0x6d1f].
  Bus  0, device  12, function  0:
    SCSI storage controller: Adaptec AIC-7880U (rev 0).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0x6400 [0x64ff].
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe4000fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] AGP (rev 0).
      IRQ 9.
      Master Capable.  Latency=128.  
      Prefetchable 32 bit memory at 0xa8000000 [0xa8ffffff].
      Non-prefetchable 32 bit memory at 0xd8800000 [0xd8803fff].
      Non-prefetchable 32 bit memory at 0xd8000000 [0xd87fffff].
