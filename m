Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270321AbRHSJtt>; Sun, 19 Aug 2001 05:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270319AbRHSJta>; Sun, 19 Aug 2001 05:49:30 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:3288 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S270326AbRHSJtT>; Sun, 19 Aug 2001 05:49:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: RAPHEAD <raphead@dimensions.de>
Organization: DIMENSIONS e.V.
To: linux-kernel@vger.kernel.org
Subject: System Freeze after booting the kernel
Date: Sun, 19 Aug 2001 11:51:40 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081911514000.00854@raphead>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--->My Hardware:

P200, 128 Meg Ram, 128 KB Cache on a SuperMicro Board.
Seagate IDE Drive with 13Gig

                                                  
--->Detailed Report

[1.] Linux freezes after Uncompressing Linux... OK, booting the kernel (no 
numlock posssible)

[2.] Wheter I boot with initrd or without, with incompiled reiserfs or as 
module or in the initrd I've tried everything
the system freezes after the above given line. I've the same system as 
desktop system (the problem occurs on the 'server')
which works fine (Celeron 400 on a Siemens Board with BX440 Chipset, SCSI, 
197 Meg RAM)

So what can I do?

[4.] Kernel version (from /proc/version):
!!!!!!! Bootet with an other Kernel!!!!!!! as I can't boot with the 2.4.9
Linux version 2.4.4-4GB (root@Pentium.suse.de) (gcc version 2.95.3 20010315 
(Su1

[7.] 
SuSE 7.2 i386

[7.1.] 
Gnu C                  2.95.3                                                 
Gnu make               3.79.1                                                 
binutils               2.10.91.0.4                                            
util-linux             2.11b                                                  
mount                  2.11b                                                  
modutils               2.4.5                                                 
e2fsprogs              1.19                                                   
reiserfsprogs          3.x.0j                                                 
pcmcia-cs              3.1.25                                                 
PPP                    2.4.0                                                  
isdn4k-utils           3.1pre1a                                               
Linux C Library        x    1 root     root      1343073 May 11 16:50 
/lib/libc6
Dynamic linker (ldd)   2.2.2                                                  
Procps                 2.0.7                                                  
Net-tools              1.60                                                   
Kbd                    1.04                                                   
Sh-utils               2.0  

[7.2.] 

processor       : 0                                                         
vendor_id       : GenuineIntel                                              
cpu family      : 5                                                         
model           : 2                                                         
model name      : Pentium 75 - 200                                          
stepping        : 12                                                        
cpu MHz         : 199.433                                                   
fdiv_bug        : no                                                        
hlt_bug         : no                                                        
f00f_bug        : yes                                                       
coma_bug        : no                                                        
fpu             : yes                                                       
fpu_exception   : yes                                                       
cpuid level     : 1                                                         
wp              : yes                                                       
flags           : fpu vme de pse tsc msr mce cx8                            
bogomips        : 398.13                                                     

[7.3.] 

server1:/usr/src/linux/scripts # cat /proc/modules         
ppp_async               6480   0 (autoclean) (unused)      
ppp_generic            14416   0 (autoclean) [ppp_async]   
nfsd                   67280   4 (autoclean)               
ipv6                  126272  -1 (autoclean)               
tulip                  37184   2 (autoclean)               
reiserfs              156432   1                           


[7.4.] 

00000000-0009fbff : System RAM                          
0009fc00-0009ffff : reserved                            
000a0000-000bffff : Video RAM area                      
000c0000-000c7fff : Video ROM                           
000f0000-000fffff : System ROM                          
00100000-07ffffff : System RAM                          
  00100000-002327d1 : Kernel code                       
  002327d2-0031bdcb : Kernel data                       
80000000-807fffff : PCI device 5333:8811                
febffe00-febffeff : PCI device 11ad:0002                
  febffe00-febffeff : tulip                             
febfff80-febfffff : PCI device 1011:0009                
  febfff80-febfffff : tulip                             
fec00000-fec00fff : reserved                            
fee00000-fee00fff : reserved                            
fffe0000-ffffffff : reserved                            
server1:/usr/src/linux/scripts # cat /proc/ioports      
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
0376-0376 : ide1                                        
03c0-03df : vga+                                        
03f6-03f6 : ide0                                        
03f8-03ff : serial(auto)                                
0cf8-0cff : PCI conf1                                   
e800-e8ff : PCI device 11ad:0002                        
  e800-e8ff : tulip                                     
ec80-ecff : PCI device 1011:0009                        
  ec80-ecff : tulip                                     
ffa0-ffaf : PCI device 8086:7010                        
  ffa0-ffa7 : ide0                                      
  ffa8-ffaf : ide1                                      
  
[7.5.] 

00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 
03) 
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Ste-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbor-
        Latency: 32                                                           
  
                                                                              
  
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] 
(rev)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Ste-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbor-
        Latency: 0                                                            
  
                                                                              
  
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] 
()
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Ste-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbor-
        Latency: 32                                                           
  
        Region 4: I/O ports at ffa0 [size=16]                                 
  
                                                                              
  
00:11.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)     
  
        Subsystem: Kingston Technologies: Unknown device f002                 
  
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Ste-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbor-
        Latency: 64                                                           
  
        Interrupt: pin A routed to IRQ 9                                      
  
        Region 0: I/O ports at e800 [size=256]                                
  
        Region 1: Memory at febffe00 (32-bit, non-prefetchable) [size=256]    
  
        Expansion ROM at feb40000 [disabled] [size=256K]                      
  
                                                                              
  
00:12.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] 
(prog-if)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Ste-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbor-
        Interrupt: pin A routed to IRQ 11                                     
  
        Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=8M]     
  
        Expansion ROM at 7f000000 [disabled] [size=64K]                       
  
                                                                              
  
00:13.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[Faste)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Ste-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbor-
        Latency: 64 (5000ns min, 10000ns max), cache line size 08             
  
        Interrupt: pin A routed to IRQ 10                                     
  
        Region 0: I/O ports at ec80 [size=128]                                
  
        Region 1: Memory at febfff80 (32-bit, non-prefetchable) [size=128]    
  
        Expansion ROM at feb80000 [disabled] [size=256K]                      
  
                                                                              
  

[7.7.] I think it is a standard system it worked over 4 years now :)
I've made a memory check which has brought no relevant results :(

Salutations Thomas Hoppe

P.s. I've tried no other kernels before, just the SuSE standard 2.4.4 Kernel,
which still works.
