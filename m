Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271368AbTHFSTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271373AbTHFSTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:19:38 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.92.226.49]:53633 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S271368AbTHFSTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:19:34 -0400
Subject: Kernel Panic on 2.6 and Dual AMD Athlon MP
From: Jason Williams <jwilliams@project-lace.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-h4RO64BZQgcS7Go/bsdq"
Message-Id: <1060193971.1824.11.camel@big-blue.project-lace.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 06 Aug 2003 14:19:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h4RO64BZQgcS7Go/bsdq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I downloaded 2.6.0-test2 to see if I could get it running on my dual
Athlon MP box (which runs 2.4 series just wonderfully).  I have a Tyan
S2466 motherboard which runs the AMD 760 MPX chipset.  2.6.0-test2
compiles just fine, but when I go to run it, I get the output detailed
in the attachment kp-2.6 to this message. Please note, I had to copy
this by hand since I couldn't get any serial output from the machine. 
In short, I get a machine check execption and the kernel panics saying
the CPU context is corrupt.

So I got the neat little parsemce program by Dave Jones and the output
from that is in the attachment mce-output also attached to this message.
(If they don't come through correctly, let me know and I can forward
them to the necessary people.)

I need someone to help me to understand why this is happening with the
2.6 kernel.  And what direction I might be able to take to try to get
the 2.6 kernel to run. Also, I had previously tried 2.5.70 and this
didn't happen.  


-- 
Jason Williams
Project-Lace.org
                                                                                
There are only 10 types of people in the world: Those who understand
binary, and those who don't


--=-h4RO64BZQgcS7Go/bsdq
Content-Disposition: attachment; filename=kp-2.6
Content-Type: text/x-troff-man; name=kp-2.6; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Intel machine check architecture aupported
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (6610.94 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the physical_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: VECTOR=0x31 pin1=2 pin2=0
testing the IO APIC .......................
................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU Clock speed is 1666.0530 MHz.
..... host bus clock speed is 266.0644 MHz.
checking TSC syncronization across 2 CPUS: passed
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Initializing RT netlink socket
CPU 0: Machine Check Exception 0000000000000004
Bank 0: f601a00000000833 at 00000000000e4040
Kernel panic: CPU context corrupt
 

--=-h4RO64BZQgcS7Go/bsdq
Content-Disposition: attachment; filename=mce-output
Content-Type: text/plain; name=mce-output; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

./parsemce -e 0000000000000004 -b 0 -s f601a00000000833 -a 00000000000e4040

Status: (4) Machine Check in progress.
Restart IP invalid.
parsebank(0): f601a00000000833 @ e4040
        External tag parity error
        Uncorrectable ECC error
        CPU state corrupt. Restart not possible
        Address in addr register valid
        Error enabled in control register
        Error not corrected.
        Error overflow
        Bus and interconnect error
        Participation: Local processor originated request
        Timeout: Request did not timeout
        Request: Generic error
        Transaction type : Instruction
        Memory/IO : Other


--=-h4RO64BZQgcS7Go/bsdq--

