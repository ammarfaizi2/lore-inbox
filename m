Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTLTAJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 19:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTLTAJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 19:09:23 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:13316 "EHLO ghost.cybernet.src")
	by vger.kernel.org with ESMTP id S263740AbTLTAJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 19:09:18 -0500
Date: Sat, 20 Dec 2003 01:09:27 +0100 (CET)
From: brain@artax.karlin.mff.cuni.cz
X-X-Sender: brain@ghost.cybernet.src
To: linux-kernel@vger.kernel.org
Subject: USB UHCI Apollo MVP3 BUG
Message-ID: <Pine.LNX.4.56.0312200054250.27351@ghost.cybernet.src>
X-Echelon: GRU Vatutinki Chodynka Khodinka Putin Suvorov USA Aquarium Russia Ladygin Lybia China Moscow missile reconnaissance agent spetsnaz security tactical target operation military nuclear force defense spy attack bomb explode tap MI5 IRS KGB CIA FBI NSA AK-47 MOSSAD M16 plutonium smuggle intercept plan intelligence war analysis president
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've got VIA Apollo MVP3 chipset, kernel 2.4.23. When I mount an USB disk and
write large amount of data to it, after filling memory buffers kernel says:

host/usb-uhci.c: interrupt, status 2, frame# 1628
host/usb-uhci.c: interrupt, status 2, frame# 1628
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:07.2-2 address 2
usb.c: USB disconnect on device 00:07.2-2 address 2
Device 08:01 not ready.
Device 08:01 not ready.
 I/O error: dev 08:01, sector 202605
 I/O error: dev 08:01, sector 202605
...
some filesystem errors, panics and so on
...
hub.c: new USB device 00:07.2-2, assigned address 3
hub.c: new USB device 00:07.2-2, assigned address 3
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3

So I'm not able to write to an USB disk. Synchronous mounting does the same.
Kernel 2.4.20 does the same.

Sometimes I get "unable to handle kernel paging request", sometimes system
crashes that only alt-sysrq-b helps, sometimes even alt-sysrq doesn't work.

What should I do?

BRain

--------------------------------
Petr `Brain' Kulhavy
<brain@artax.karlin.mff.cuni.cz>
http://artax.karlin.mff.cuni.cz/~brain
Faculty of Mathematics and Physics, Charles University Prague, Czech Republic

---
There's no future in time travel.
