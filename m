Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262356AbSJEOxK>; Sat, 5 Oct 2002 10:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbSJEOxK>; Sat, 5 Oct 2002 10:53:10 -0400
Received: from 62-190-217-225.pdu.pipex.net ([62.190.217.225]:53508 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262356AbSJEOxH>; Sat, 5 Oct 2002 10:53:07 -0400
Date: Sat, 5 Oct 2002 16:06:45 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210051506.g95F6jfL000423@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.x and 8250 UART problems
Cc: rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that 8250 UART based serial port performance is poorer in 2.5.x than 2.4.x and 2.2.x, on a couple of my machines.

The 486 SX-20 with 4 MB RAM, running 2.2.21 reliably achieves about 650 BPS download from another machine, with the port runnnig at 9600 bps.  With 2.5.40, many characters are lost at 9600, making, e.g. a ZModem transfer retry for almost every block.

A 486 SX-25 with 8 MB RAM, running 2.4.19 manages about 950 BPS reliably with the port set at 9600 bps.  With 2.5.40, there are again a lot of lost characters.

I know these are ancient machines, with rediculously low amounts of memory, but surely 9600 bps should be reliable, even if performance drops to 600-700 BPS, or even lower.

I originally thought that the new kernel was using up memory that was previously available to be used as a buffer, and that extra hard disk access was causing the lost characters, but this doesn't seem to be the case.

Any idea what's causing this?  I can send more info and do more tests as required.

John.
