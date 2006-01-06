Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWAFTDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWAFTDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWAFTDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:03:23 -0500
Received: from mail.linicks.net ([217.204.244.146]:14723 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932440AbWAFTDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:03:21 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15 - possible serial port problem?
Date: Fri, 6 Jan 2006 19:03:05 +0000
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601061903.05733.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

First, this is most probably not a kernel issue, but I have exhausted all 
other avenues...

I have an (oldish) Olympic C-420L camera, that attaches via /dev/ttyS0 S1 etc.

The camera now isn't detected anymore, but I don't know when, as I don't use 
it much (maybe 10 times a year).  I have googled to no avail.  On my end, 
everything _appears_ to be working, but the camera isn't detected anymore, as 
it has been for the last 2 years:



nick@linuxamd:nick$ dmesg | grep serial
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A



nick@linuxamd:nick$ sudo /sbin/setserial /dev/ttyS0
/dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4
nick@linuxamd:nick$ sudo /sbin/setserial /dev/ttyS1
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3



nick@linuxamd:nick$ gphoto2 --list-ports
Devices found: 7
Path                             Description
--------------------------------------------------------------
serial:/dev/ttyS0                Serial Port 0
serial:/dev/ttyS1                Serial Port 1
serial:/dev/ttyS2                Serial Port 2
serial:/dev/ttyS3                Serial Port 3
usb:                             Universal Serial Bus
usb:002,004                      Universal Serial Bus
usb:002,003                      Universal Serial Bus

nick@linuxamd:nick$ gphoto2 --auto-detect
Model                          Port
----------------------------------------------------------



I have no other serial devices I can test with.  Is there anything I can 
run/test to check what is happening...

TIA,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
