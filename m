Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUDTPlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUDTPlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUDTPlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:41:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262932AbUDTPlO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:41:14 -0400
Date: Tue, 20 Apr 2004 11:41:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Axel =?iso-8859-15?q?Wei=DF?= <aweiss@informatik.hu-berlin.de>
cc: John Que <qwejohn@hotmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: NIC inerrupt
In-Reply-To: <200404201604.17238.aweiss@informatik.hu-berlin.de>
Message-ID: <Pine.LNX.4.53.0404201138380.568@chaos>
References: <BAY14-F34eqdGSyMp690005e9f6@hotmail.com>
 <200404201604.17238.aweiss@informatik.hu-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004, Axel [iso-8859-15] Weiß wrote:

> Am Montag, 19. April 2004 14:46 schrieb John Que:
> > Hello,
> >
> > I want to count the number of times I reach an NIC receive
> > interrupt.
> >
> > I added a global static variable of type int , and initialized
> > it to 0 ; each time I am in the rx_interrupt of the card I incerement
> > it by one;
> > I got large , non sensible numbers after one or two seconds;
> >
> > So  for debug I added printk each time I increment it in rx_interrupt.
> >
> > What I see is that there are  unreasonable jumps in the number
> >
> > for instance , it inceremnts sequntially from 1 to 80,then jums to 4500,
> > increments a little sequentially to 4580, and the jums again to
> > 11000 ;
> >
> > Is it got to do with it that this is in interrupt?
> > Any idea what it can be ?
> >
> >
> > (I also tried to declare it as static in the rx_interrupt method
> > and the same happened)
>
> Probably you didn't declare your count variable 'volatile'?
>
> Axel
>
> --
> Humboldt-Universität zu Berlin
> Institut für Informatik
> Signalverarbeitung und Mustererkennung
> Dipl.-Inf. Axel Weiß
> Rudower Chaussee 25
> 12489 Berlin-Adlershof
> +49-30-2093-3050

How about `cat /proc/interrupts`. That should tell him how
many interrupts the NIC got..

           CPU0
  0:     123073    IO-APIC-edge  timer
  1:       1131    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
 17:      18550   IO-APIC-level  BusLogic BT-958
 18:      69272   IO-APIC-level  eth0	<----------
NMI:          0
LOC:     123029
ERR:          0
MIS:          0

Do the simple stuff first. Only get compilcated if necessary.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5596.77 BogoMips).
            Note 96.31% of all statistics are fiction.


