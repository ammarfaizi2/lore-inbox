Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSE2W3W>; Wed, 29 May 2002 18:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSE2W3V>; Wed, 29 May 2002 18:29:21 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:30181
	"EHLO awak") by vger.kernel.org with ESMTP id <S315607AbSE2W3V>;
	Wed, 29 May 2002 18:29:21 -0400
Subject: 2.4.19-pre7-ac2 USBnet with iPaq freezes host
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 May 2002 00:29:09 +0200
Message-Id: <1022711350.1087.13.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've compiled-in (i.e. not as a module) usbnet to talk to my ipaq
through usb0. It works well, mostly, except that sometimes it lockups my
desktop completely (not the pda).

I got bored today and copied the console message on a shit a paper and
retyped it through ksymoops:

wait_on_irq, CPU0
irq: 1 [ 0 1 ]
bh: 0 [ 0 0 ]
stack dumps:
cpu 1: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
cpu 0: c19d3f54 c02cb45d 00000000 00000000 00000000 c0109e9d c02cb472 c0349e64
       d5dca000 00000001 c01b854d c0349e64 c19d3fa4 c19d3fe0 c19d2000 d5dca168
       c0120400 d5dca000 c19d2654 ffffffff d5dca130 c0349e64 c01287f7 c0343900
call trace: [<c0109e9d3>] [<c01b854d>] [<c0120400>] [<c01287f7>] [<c0106fd4>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 0000000c0109e9d3 <END_OF_CODE+b106241f4/????>
Trace; c01b854d <flush_to_ldisc+d5/11c>
Trace; c0120400 <__run_task_queue+60/6c>
Trace; c01287f7 <context_thread+137/1d0>
Trace; c0106fd4 <kernel_thread+28/38>



