Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbUAIRib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbUAIRib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:38:31 -0500
Received: from [193.138.115.2] ([193.138.115.2]:12046 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263303AbUAIRi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:38:26 -0500
Date: Fri, 9 Jan 2004 18:35:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: lkml@nitwit.de
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: The hardware reports a non fatal, correctable incident
 occured on CPU 0.
In-Reply-To: <200401091748.10859.lkml@nitwit.de>
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC0751591E@difpst1a.dif.dk>
References: <200401091748.10859.lkml@nitwit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jan 2004 lkml@nitwit.de wrote:

> Hi!
>
> I did have some very scary issues today playing with 2.6. The system was
> booted and ran several times today, the longtest uptime was approximately
> about an hour.
>
> But then shortly after having booted 2.6 I got syslog messages:
>
> The hardware reports a non fatal, correctable incident occured on CPU 0.
>
> I shut down the machine. After this my Athlon XP 2200+ showed up as 1050MHz in
> BIOS an indeed the bus frequency was set to 100 instead of 133 MHz (how can
> an OS change the BIOS?!)

It's nothing to do with the OS most likely. Some BIOS's modify the FSB
speed and other settings as a way to provide a sort of "fail safe" boot
mode if a problem was detected.

The BIOS on my board will do that if the system fails to POST and I've
also seen it happen sometimes after a crash.

It's even documented in the motherboard manual that it will behave this
way when running in JumperFree mode (this is an ASUS A7M266 board btw).
The exact text from my motherboard manual is :

"Notes for JumperFree Mode
 System Hangup

 If your system crashes or hangs due to improper frequency settings, power
 OFF your system and restart. The system will start up in safe mode
 running at a DRAM-to-CPU frequency ratio of 3:3 and a bus speed of
 100MHz. You will then be led to BIOS setup to adjust the configurations."


-- Jesper Juhl

