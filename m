Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310873AbSCHOU6>; Fri, 8 Mar 2002 09:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310874AbSCHOUg>; Fri, 8 Mar 2002 09:20:36 -0500
Received: from Expansa.sns.it ([192.167.206.189]:43268 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S310873AbSCHOUd>;
	Fri, 8 Mar 2002 09:20:33 -0500
Date: Fri, 8 Mar 2002 15:20:33 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: linux-kernel@vger.kernel.org
Subject: 2.5.6 IDE oops with i810 chipset
Message-ID: <Pine.LNX.4.44.0203081514430.28035-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

It is almost impossible to boot 2.5.6 with IDE disk with
chipset :

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
[Master])
        Subsystem: Intel Corporation 82801AA IDE
        Flags: bus master, medium devsel, latency 0
        I/O ports at 2460 [size=16]


I get an oops with every configuration I tried.
Of course I have no way to save log this oops,
and I had no time to write it down. Anyway it is the usual
"attemped to kill init" message.

Apart of this there is the old OSS driver with still
a virt_to_bus() in dma.c file,
and drm/i810.c has the same problem too, also if a trivial
(and of course wrong, also if it works temporally) fix
is quite fast.


I am willing to test any patch

Luigi


