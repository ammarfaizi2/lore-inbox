Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTJBQAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 12:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTJBQAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 12:00:41 -0400
Received: from main.gmane.org ([80.91.224.249]:61362 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263375AbTJBQAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 12:00:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet@andreas-s.net>
Subject: Extremely low disk performance on K7S5A Pro
Date: Thu, 2 Oct 2003 15:47:40 +0000 (UTC)
Message-ID: <slrnbnoi5i.3re.usenet@home.andreas-s.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-TCPA-ist-scheisse: yes
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since I replaced my Abit KT7 with an Elitegroup K7S5A Pro (SIS735), I've
got extremly low disk performance with every tested kernel version
(2.4.20, 2.6.0-test6-mm2):

# hdparm -tT /dev/hda                                                           
/dev/hda:                                                                       
 Timing buffer-cache reads:   824 MB in  2.00 seconds = 411.65 MB/sec           
 Timing buffered disk reads:   10 MB in  3.28 seconds =   3.05 MB/sec
                                                          ^^^^

DMA, 32bit etc. is activated (hdparm -d1 -c3 -u1 /dev/hda):

# hdparm -v -i /dev/hda                                                         
/dev/hda:                                                                       
 multcount    = 16 (on)                                                         
 IO_support   =  3 (32-bit w/sync)                                              
 unmaskirq    =  1 (on)                                                         
 using_dma    =  1 (on)                                                         
 keepsettings =  0 (off)                                                        
 readonly     =  0 (off)                                                        
 readahead    = 256 (on)                                                        
 geometry     = 65535/16/63, sectors = 117231408, start = 0                     
                                                                                
 Model=ST360021A, FwRev=3.10, SerialNo=3HR0E280                                 
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }           
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16                 
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=117231408             
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}               
 PIO modes:  pio0 pio1 pio2 pio3 pio4                                           
 DMA modes:  mdma0 mdma1 mdma2                                                  
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5                               
 AdvancedPM=no WriteCache=enabled                                               
 Drive conforms to: device does not report version:

Any hints how this problem could be solved?

-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net

