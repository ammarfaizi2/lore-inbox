Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbTBGSjX>; Fri, 7 Feb 2003 13:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbTBGSjX>; Fri, 7 Feb 2003 13:39:23 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:4565 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S266310AbTBGSjW> convert rfc822-to-8bit; Fri, 7 Feb 2003 13:39:22 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: SA <bullet.train@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: interrupt latency k2.4 / i386?
Date: Fri, 7 Feb 2003 18:47:36 +0000
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302071847.36646.bullet.train@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear list,

What latency should I expect for hardware interrupts under k2.4 / i386 ? 

ie how long should it take between the hardware signalling the interrupt and 
the interrupt handler being called?


I am wrting a driver which pace IO with interrupts, generating one interrupt 
for after every transfer is done.  Looking at the hardware schematics the 
interrupts should occur virtually instantly after each transfer but the 
driver is waiting ~1ms/ interrupt.  

I can use polling instead with busy waits but this seems a bit wasteful.


My interrupt is shared with my graphics card using the non-GPL nvidia driver - 
could this be responsible for the delay (any experience with this)?

cat /proc/interrupts
.....
 10:       3028          XT-PIC  eth0, VIA 82C686A
 11:    1117037          XT-PIC  nvidia, PI stage <-- my driver
 12:      14776          XT-PIC  usb-uhci, usb-uhci
.....

Thanks SA
