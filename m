Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269919AbRHJFxa>; Fri, 10 Aug 2001 01:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269916AbRHJFxV>; Fri, 10 Aug 2001 01:53:21 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:34309 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S269915AbRHJFxH>; Fri, 10 Aug 2001 01:53:07 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 10 Aug 2001 07:53:04 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.7: random.c - potential security problem
Message-ID: <3B7392DF.231.5D8E1@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/3.47+2.4+2.03.072+02 July 2001+64930@20010810.054219Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

maybe some of you find this interesting: Yesterday I was grepping for 
some variable in the source tree when I ended up in 
drivers/char/random.c. There I noticed that the driver uses wall time 
to re-seed the TCP sequence numbers for example. This means that no re-
seeding takes place if the clock is set back a significant amount of 
time, e.g. if the CMOS clock failed or was completely off.

I don't know if the problem is severe, but I thought I tell you.

Regards,
Ulrich
P.S. Not subscribed to this list

