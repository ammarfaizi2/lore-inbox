Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155256AbPFQIax>; Thu, 17 Jun 1999 04:30:53 -0400
Received: by vger.rutgers.edu id <S154989AbPFQIac>; Thu, 17 Jun 1999 04:30:32 -0400
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:61059 "EHLO rrzs2.rz.uni-regensburg.de") by vger.rutgers.edu with ESMTP id <S155104AbPFQIaT>; Thu, 17 Jun 1999 04:30:19 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.rutgers.edu
Date: Thu, 17 Jun 1999 10:29:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: tracing "lost_ticks" in 2.2.9 on a slow machine
X-mailer: Pegasus Mail for Windows (v3.01d)
Message-ID: <166B49CD5B5A@rkdvmks1.ngate.uni-regensburg.de>
Sender: owner-linux-kernel@vger.rutgers.edu

Hello,

I'm seeking for some advice: I run my old PC (a 16MHz 386/SX, 
possibly the absolute low-end until I disable the "turbo") with Linux 
2.2.9 as a time server (my boss won't donate a machine). With ntpd-
4.0.92 and a DCF77 reference clock the machine can keep time within 
2ms (in the last two weeks).

Unfortunately some debugging code from PPSkit-0.7.0 indicates that
``ticks'' in update_wall_time() is 2 quite frequently, even if the 
machine is idle. Running one program I saw a value of "4"...

This is not very encouraging.  I'd like to find out what parts of the 
kernel disable interrupt processing for that long, but I'm not good 
enough with the assembler facts:

I'd like to modify the interrupt enabling code (restore_flags) to 
check the value of the lost_ticks, and if it's high, it should 
display the address where the instruction pointer is.

Can anybody tell me how to do that?

(I'm not subscribed to the list, so please CC: any replies, please)

Regards,
Ulrich


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
