Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbQLHHRs>; Fri, 8 Dec 2000 02:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbQLHHRj>; Fri, 8 Dec 2000 02:17:39 -0500
Received: from pD9040D1E.dip.t-dialin.net ([217.4.13.30]:28430 "HELO
	grumbeer.hjb.de") by vger.kernel.org with SMTP id <S129896AbQLHHRc>;
	Fri, 8 Dec 2000 02:17:32 -0500
Subject: 2.4.0test10: 3c59x: Transmit timed out
To: linux-kernel@vger.kernel.org
Date: Fri, 8 Dec 2000 07:47:29 +0100 (CET)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001208064729.0857242544F@grumbeer.hjb.de>
From: hjb@pro-linux.de (Hans-Joachim Baader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following timeout on an SMP system:

3c59x.c:LK1.1.9  2 Sep 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.38 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xa800,  00:60:97:b0:c2:25, IRQ 10
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/10base2 interface.
    Enabling bus-master transmits and whole-frame receives.


NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
Flags; bus-master 1, full 1; dirty 8031(15) current 8047(15).
Transmit list 05d802f0 vs. c5d802f0.
0: @c5d80200  length 8000002a status 0000002a
1: @c5d80210  length 8000002a status 0000002a
2: @c5d80220  length 8000002a status 0000002a
3: @c5d80230  length 8000002a status 0000002a
4: @c5d80240  length 8000002a status 0000002a
5: @c5d80250  length 8000002a status 0000002a
6: @c5d80260  length 8000002a status 0000002a
7: @c5d80270  length 8000002a status 0000002a
8: @c5d80280  length 8000002a status 0000002a
9: @c5d80290  length 8000002a status 0000002a
10: @c5d802a0  length 8000002a status 0000002a
11: @c5d802b0  length 8000002a status 0000002a
12: @c5d802c0  length 8000002a status 0000002a
13: @c5d802d0  length 8000002a status 8000002a
14: @c5d802e0  length 8000002a status 8000002a
15: @c5d802f0  length 8000002a status 0000002a


# cat /proc/interrupts (after reloading the driver)
           CPU0       CPU1       
0:      1713215    1742004    IO-APIC-edge  timer
1:            0          2    IO-APIC-edge  keyboard
2:            0          0          XT-PIC  cascade
3:            1          4    IO-APIC-edge  serial
4:        78236      81425    IO-APIC-edge  serial
5:            1          0    IO-APIC-edge  soundblaster
8:            0          3    IO-APIC-edge  rtc
9:       177420     177907   IO-APIC-level  sym53c8xx
10:        3277       3323   IO-APIC-level  eth0
11:           0          0    IO-APIC-edge  mcdx
12:       50650      49080   IO-APIC-level  eth1
13:           0          0          XT-PIC  fpu
NMI:    3455146    3455146 
LOC:    3454715    3454709 
ERR:          0

Regards,
hjb
-- 
http://www.pro-linux.de/ - Germany's largest volunteer Linux support site
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
