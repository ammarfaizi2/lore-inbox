Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUBQOOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 09:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUBQOOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 09:14:23 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:47497 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266192AbUBQOOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 09:14:12 -0500
Message-ID: <20040217061400.z9r4gss0gsockws4@carlthompson.net>
X-Priority: 3 (Normal)
Date: Tue, 17 Feb 2004 06:14:00 -0800
From: Carl Thompson <cet@carlthompson.net>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard lock using combination of devices
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net>
	<200402170854.22973.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040216231401.3ig4kksk4k8g8440@carlthompson.net>
	<200402171149.49985.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200402171149.49985.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=_zhyprd6qn4w"
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.0.156
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

--=_zhyprd6qn4w
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Quoting vda <vda@port.imtp.ilyichevsk.odessa.ua>:

> On Tuesday 17 February 2004 09:14, Carl Thompson wrote:
>> Quoting vda <vda@port.imtp.ilyichevsk.odessa.ua>:
>> > ...
>> >
>> > Your box share IRQs in a big way :)
>>
>> Your point?
>
> While shared interrupts can in theory work right,
> lots of hardware and/or drivers do not handle
> that.

First, the two devices in question are not on the same interrupt.  Second, it
is very difficult in this day in age to build a system without interrupt
sharing.  While I agree that it's better to have as few devices sharing as
possible, there are simply too many devices in modern systems and too few
interrupts.  Interrupt sharing needs to work on modern hardware and needs to
work in Linux.  This notebook is pretty typical in its interrupt distribution
and I'm not certain that this is a problem.  In fact, while many devices on
this system use IRQ 11 the only one active at the time was the audio
controller.  And while IRQ 10 is shared between the CardBus adapters and the
video card the problems still occur if I don't run X and video interrupts
shouldn't be generated in console mode, right?

> I think you should try to reconfigure your
> system so that devices do not share same IRQ
> and see whether that 'fix' the problem.

There are no options in my notebook's BIOS to reconfigure interrupts or 
disable
devices.

> BTW, can you show your /proc/interrupts ?

Attached.

> --
> vda

Carl Thompson



--=_zhyprd6qn4w
Content-Type: text/plain; charset="UTF-8"; name="interrupts"
Content-Disposition: attachment; filename="interrupts"
Content-Transfer-Encoding: 7bit

           CPU0       
  0:   41027968          XT-PIC  timer
  1:      26061          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:       2020          XT-PIC  acpi
 10:    2187181          XT-PIC  yenta, driverloader
 11:        111          XT-PIC  ALI 5451
 12:    2399118          XT-PIC  i8042
 14:     169829          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:   41036749 
ERR:     275764
MIS:          0

--=_zhyprd6qn4w--

