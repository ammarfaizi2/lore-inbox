Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265934AbRFZHvO>; Tue, 26 Jun 2001 03:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265937AbRFZHvE>; Tue, 26 Jun 2001 03:51:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:38664 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265934AbRFZHuw>; Tue, 26 Jun 2001 03:50:52 -0400
Date: Tue, 26 Jun 2001 03:17:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Tim Waugh <twaugh@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: parport_pc tries to load parport_serial automatically 
Message-ID: <Pine.LNX.4.21.0106260308100.1730-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 


parport_pc is now trying to load parport_serial.o at init_module() time.
~
If the initialization of parport_serial fails, we obviously get an error
message, which is really annoying:

0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: irq 7 detected
insmod: /lib/modules/2.4.5-5cl/kernel/drivers/parport/parport_serial.o: init_module: No such device
insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters

Why it tries to load parport_serial ? 

