Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275694AbRJAW4K>; Mon, 1 Oct 2001 18:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275695AbRJAW4A>; Mon, 1 Oct 2001 18:56:00 -0400
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:26347 "EHLO
	smtprelay2.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S275694AbRJAWzz>; Mon, 1 Oct 2001 18:55:55 -0400
Message-ID: <3BB8F490.4638A81E@adelphia.net>
Date: Mon, 01 Oct 2001 18:56:16 -0400
From: "Rinaldi J. Montessi" <rinaldij@adelphia.net>
Organization: http://www.Federalist.com/
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: <<=?iso-8859-1?Q?=A5?=>>
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: APIC revisited
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize that this is a FAQ item, but the information contained therein
is a bit sparse.  I have an Abitbp6 motherboard with dual celerons 533's
not overclocked.  The bus is 66mhz.

My boot params are (from dmesg)

Kernel command line: BOOT_IMAGE=linux2410 ro root=2203
BOOT_FILE=/boot/vmlinuz-2.4.10 hdc=ide-scsi noapic

The BIOS is set for MPS 1.1

These are both recommended in the FAQ (as is trashing the Abit mobo, but
that is not feasible at the present time).

I am of the impression that with the noapic parameter all calls are to
be handled via CPU0, yet I am getting several errors on CPU1 as well. 

uptime
4:28pm  up 4 days, 17:50,  4 users,  load average: 0.00, 0.00, 0.00

/proc/interrupts

           CPU0       CPU1       
  0:   40989069          0          XT-PIC  timer
  1:      64603          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  3:     663114          0          XT-PIC  eth1
  7:     230556          0          XT-PIC  soundblaster
  8:          1          0          XT-PIC  rtc
  9:       2735          0          XT-PIC  eth0
 10:     720950          0          XT-PIC  ide2, ide3
 12:    2096913          0          XT-PIC  PS/2 Mouse
 14:     705487          0          XT-PIC  ide0
 15:          5          0          XT-PIC  ide1
NMI:          0          0 
LOC:   40988011   40988007 
ERR:         97
MIS:          0

The errors are fairly divided between CPU0 and CPU1 54/43 per dmesg,
although this seems to indicate otherwise.

The last series of errors is fairly representative:

APIC error on CPU0: 02(04)
APIC error on CPU1: 04(08)
APIC error on CPU1: 08(08)
APIC error on CPU0: 04(04)
APIC error on CPU0: 04(02)
APIC error on CPU0: 02(02)

Can I assume there is no kernel solution to this problem; and is there a
way for me to quantify potential/probable file corruption?

Thanks,

Rinaldi
-- 
By all means marry. If you get a good wife you will become happy, 
and if you get a bad one you will become a philosopher. --Socrates
