Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269188AbUINHlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269188AbUINHlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269189AbUINHlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:41:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:3131 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S269188AbUINHll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:41:41 -0400
Message-ID: <4146A09A.9010207@zensonic.dk>
Date: Tue, 14 Sep 2004 09:41:14 +0200
From: "Thomas S. Iversen" <zensonic@zensonic.dk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Losing too many ticks! .... on a VIA epia board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There

I have just hooked up my new via mainboard 
(http://www.viaembedded.com/product/epia_ms_spec.jsp?motherboardId=281)

and installed the latest linux kernel on the system (2.6.8). 
Unfortiunatly something is misbehaving with the timer/kernel interaction.

A snippet from dmesg:

agpgart: Detected VIA CLE266 chipset
agpgart: Maximum main memory to use for agp memory: 424M
agpgart: AGP aperture is 4M @ 0xe7000000
Losing some ticks... checking if CPU frequency changed.
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 17
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Losing some ticks... checking if CPU frequency changed.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0340d60(lo)
IPv6 over IPv4 tunneling driver
Losing some ticks... checking if CPU frequency changed.
eth0: no IPv6 routers present
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
mtrr: 0xe0000000,0x1000000 overlaps existing 0xe0000000,0x800000
Losing some ticks... checking if CPU frequency changed.
padlock: Using VIA PadLock ACE for AES algorithm (multiblock).
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
.....
and then finally

Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing too many ticks!
TSC cannot be used as a timesource. 
Possible reasons for this are:
  You're running with Speedstep,
  You don't have DMA enabled for your hard disk (see hdparm),
  Incorrect TSC synchronization on an SMP system (see dmesg).
Falling back to a sane timesource now.


Furthermore editors like jed and emacs takes forever to start. A "strace 
emacs /somefile" shows that it hangs in a poll right after gettimeofday.

Any clues to what is wrong and how I go about fixing it?!

Regards Thomas, Denmark

