Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132435AbRCZNT2>; Mon, 26 Mar 2001 08:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132436AbRCZNTS>; Mon, 26 Mar 2001 08:19:18 -0500
Received: from danielle.hinet.hr ([195.29.254.157]:36875 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S132435AbRCZNTL>; Mon, 26 Mar 2001 08:19:11 -0500
Date: Mon, 26 Mar 2001 15:22:43 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: kernel 243p8 problems
Message-ID: <20010326152243.A10386@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1st :

# depmod -a 2.4.3-pre8
depmod: *** Unresolved symbols in /lib/modules/2.4.3-pre8/kernel/drivers/net/dummy.o
depmod: *** Unresolved symbols in /lib/modules/2.4.3-pre8/kernel/drivers/net/eepro100.o

the rest :

it's Compaq PL 6500 with 4 penguins and 2 gig RAM
Compaq SMART2 hardware RAID and DLT are also bundled ! :)

Well, there is a problem with cpqarray driver. If I boot without noapic
it hangs right after

cpqarray: Device e11 has been found at 5 0
Compaq SMART2 Driver (v 2.4.2)
Found 1 controller(s)
cpqarray: Finding drives on ida0 (Smart Array 3200)
cpqarray ida/c0d0: blksz=512 nr_blks=17764320
cpqarray ida/c0d1: blksz=512 nr_blks=17764320
Partition check:
 ida/c0d0

but if I put noapic I get only _one_ CPU usable ->

]# cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  0:     926630          0          0          0          XT-PIC  timer
  1:         11          0          0          0          XT-PIC  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  8:          1          0          0          0          XT-PIC  rtc
  9:         34          0          0          0          XT-PIC  sym53c8xx
 10:         30          0          0          0          XT-PIC  sym53c8xx
 11:       2522          0          0          0          XT-PIC  ida0
 14:          3          0          0          0          XT-PIC  ide0
 15:       7547          0          0          0          XT-PIC  eth1
NMI:          0          0          0          0 
LOC:     926548     926547     926546     926545 
ERR:          0


any patches to take/patch/slap !?

ps
	any other required info available on request

-- 
Mario Mikoèeviæ (Mozgy)
My favourite FUBAR ...
