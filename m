Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276118AbRJYT4S>; Thu, 25 Oct 2001 15:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276132AbRJYT4I>; Thu, 25 Oct 2001 15:56:08 -0400
Received: from mx10.port.ru ([194.67.57.20]:9206 "EHLO mx10.port.ru")
	by vger.kernel.org with ESMTP id <S276118AbRJYTzu>;
	Thu, 25 Oct 2001 15:55:50 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200110251930.f9PJUJl26883@vegae.deep.net>
Subject: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
To: alan@lxorguk.ukuu.org.uk
Date: Thu, 25 Oct 2001 23:30:18 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       Hello folks...

	Host A: p166, ISA NE2K, linux-2.4.12-ac4
	Host B: p2-400, rtl-8129, WinXP (heh, not my box though ;)

	Load: smbmount connection from host A to the host B, and getting
     large files.

	Result: 
		a) modem dies completely - drops ppp packets at the rate of 75%,
		irqtune doesnt affect this behaviour at all
		
		b) mpg123 sound becomes corrupted, as if its interrupted
		with rate of 100Hz for a very little amount of time, 
		irqtune doesnt affect this behaviour at all
		
		c) CPU load does not depend on whether mpg123 is started,
		ie at the moment mpg123 exits, system cpu usage pops up.
		
		d) complete stopping sound (killing esd which leads to
		the fact that soundcard stops to emit interrupts), increases
		network copy performance by the factor of 1.2

		e) renicing ksoftirqd doesnt affect the behaviour at all

		f) renicing mc increases copy performance my the factor of 1.2


	Now i`m compiling the 2.4.13-linus to test it either...

cheers, Samium Gromoff
