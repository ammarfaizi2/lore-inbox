Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbRBEXsQ>; Mon, 5 Feb 2001 18:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbRBEXr4>; Mon, 5 Feb 2001 18:47:56 -0500
Received: from rak.isternet.sk ([195.72.0.6]:33036 "EHLO rak.isternet.sk")
	by vger.kernel.org with ESMTP id <S129775AbRBEXrx>;
	Mon, 5 Feb 2001 18:47:53 -0500
Date: Tue, 6 Feb 2001 00:46:42 +0100
From: Juraj Bednar <juraj@bednar.sk>
To: acpi@phobos.fachschaften.tu-muenchen.de
Cc: linux-kernel@vger.kernel.org
Subject: acpi breaks async interface
Message-ID: <20010206004642.A24599@rak.isternet.sk>
Reply-To: Juraj Bednar <juraj@bednar.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


 I just found a strange thing in 2.4.1 (don't know, if the same
occured in 2.4.0) and 2.4.1-ac3. When I enable ACPI, my serial
port starts to drop some characters. When making ppp over this
and doing ping, it causes great packet losts. If I turn ACPI in
this configuration off, it works with no problems. I tried to
switch serial port IRQ to other one (was 4, switched to 3 and
tested) and it didn't help. Maybe something's broken.

 ACPI related boot messages:

Feb  4 23:21:58 idoru kernel: ACPI: Core Subsystem version [20010125]
Feb  4 23:21:58 idoru kernel: ACPI: Subsystem enabled
Feb  4 23:21:58 idoru kernel: ACPI: System firmware supports: C2 C3
Feb  4 23:21:58 idoru kernel: ACPI: System firmware supports: S0 S1 S4 S5

[root@idoru log]# cat /proc/interrupts 
           CPU0       
  0:      57278          XT-PIC  timer
  1:       2658          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:      49530          XT-PIC  serial
  5:          1          XT-PIC  soundblaster
 10:         15          XT-PIC  aha152x
 11:         60          XT-PIC  eth0
 12:      27772          XT-PIC  PS/2 Mouse
 14:     213118          XT-PIC  ide0
 15:       3298          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0





           Have a nice day,
                  Juraj.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
