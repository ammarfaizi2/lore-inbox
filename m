Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSGBTUI>; Tue, 2 Jul 2002 15:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSGBTUH>; Tue, 2 Jul 2002 15:20:07 -0400
Received: from h64-251-67-69.bigpipeinc.com ([64.251.67.69]:21772 "HELO
	kelownamail.packeteer.com") by vger.kernel.org with SMTP
	id <S316884AbSGBTUG>; Tue, 2 Jul 2002 15:20:06 -0400
From: "Stephane Charette" <scharette@packeteer.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 02 Jul 2002 12:22:34 -0700
Reply-To: "Stephane Charette" <scharette@packeteer.com>
X-Mailer: PMMail 2000 Standard (2.20.2502) For Windows 2000 (5.0.2195;2)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: performance impact of using noapic
Message-Id: <20020702192006Z316884-686+254@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was reading through "FreeBSD Versus Linux Revisited" by Moshe Bar at "http://www.byte.com/documents/s=1794/byt20011107s0001/1112_moshe.html".

One paragraph in particular caught my eye:

   On the Linux side, I attached all interrupts coming
   from the network adaptor to one CPU. With the new
   TCP/IP stack in the 2.4 kernels this really becomes
   necessary. Otherwise, you might find the incoming
   packets arranged out of order, because later interrupts
   are serviced (on another CPU) before earlier ones, thus
   requiring a reordering further down the handling layers.

Is this a widely-known issue?  Or is this simply theory?  I'd never heard this mentionned until I read the article.

I ran some web-based performance tests with the 2.4.19-pre9-SMP kernel on a dual-CPU Athlon 1600MHz box, and found that running with "noapic" actually improved network performance.  (Negligable -- only 1% improvement in the small webstone-based test I ran.)

As I wrote in another post concerning performance from earlier today, the actual values of my performance tests are not important -- the trend is what I wish to higlight.

My questions are:

1) am I right in thinking that "noapic" will force all interrupts to be handled by 1 CPU?

2) how would you force all interrupts from only 1 hardware device (and not all devices) to be handled by 1 processor, as hinted in the paragraph quoted above?

Thanks,

Stephane Charette


