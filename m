Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTFTNwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFTNwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:52:31 -0400
Received: from nobody.lpr.e-technik.tu-muenchen.de ([129.187.151.1]:41427 "EHLO
	nobody.lpr.e-technik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262093AbTFTNw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:52:28 -0400
Message-ID: <3EF314E4.6090201@lpr.e-technik.tu-muenchen.de>
Date: Fri, 20 Jun 2003 16:06:28 +0200
From: Uygur Savasar Sinan <uygur@lpr.e-technik.tu-muenchen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Need help!: Writing raw data with IDE PIO
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers,

I am a student working in a realtime systems project at the Technical 
University of
Munich. In the time being i have to be able to write a certain data of 
one sector on
a certain CHS (actually LBA) on the hard disk. I am trying to do it with 
inserting and
removing a module which i write in C.

Please send your comments or reference codes regarding to the info given 
below.

Kindly regards.

Sinan UYGUR


My uname -a is
 >>Linux bert 2.4.21-rthal5 #2 SMP Tue May 27 16:15:22 CEST 2003 i686 
unknown
in Red Hat Linux

My IDE interface after lspci -vxx is:
00:01.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] 
(prog-if 80 [Master])
       Flags: bus master, medium devsel, latency 32
       I/O ports at e800 [size=16]
00: 86 80 10 70 05 00 80 0a 00 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


bert:~# cat /proc/ide/ide1/hdc/model
ST51080A


and my hard disk settings via
bert:~# cat /proc/ide/ide1/hdc/settings are:
name                    value           min             max             
mode
----                         -----              ---                
---                ----
acoustic                   0                 0                254        
      rw
address                    0                 0                  2       
         rw
bios_cyl               2100              0               
65535            rw
bios_head               16                0                255       
      rw
bios_sect                63                0                 63        
      rw
breada_readahead   8                 0                255               rw
bswap                      0                 0                  
1                 r
current_speed        34                0                 
70               rw
failures                   0                  0               
65535           rw
file_readahead      124               0               16384           rw
init_speed              34                 0                  
70              rw
io_32bit                  0                  0                   
3               rw
keepsettings            0                  0                   
1               rw
lun                           0                 0                    
7               rw
max_failures          1                  0                
65535           rw
max_kb_per_request     128        1               255         rw
multcount               0                  0                  
32              rw
nice1                       1                  0                  
1               rw
nowerr                    0                  0                   
1               rw
number                   2                  0                   
3               rw
pio_mode          write-only        0                 255              w
slow                        0                  0                   
1               rw
unmaskirq              0                   0                  1  
             rw
using_dma              0                  0                   
1               rw
wcache                    0                  0                   
1               rw

and finally my

bert:~# hdparm -v /dev/hdc
/dev/hdc:
multcount    =  0 (off)
I/O support  =  0 (default 16-bit)
unmaskirq    =  0 (off)
using_dma    =  0 (off)
keepsettings =  0 (off)
nowerr       =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 2100/16/63, sectors = 2116800, start = 0
busstate     =  1 (on)
bert:~#




