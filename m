Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSCKSrg>; Mon, 11 Mar 2002 13:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSCKSr2>; Mon, 11 Mar 2002 13:47:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12163 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288012AbSCKSrU>; Mon, 11 Mar 2002 13:47:20 -0500
Date: Mon, 11 Mar 2002 13:50:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Callout devices
Message-ID: <Pine.LNX.3.95.1020311134301.3421A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I ended up deleting the name of the person who asked...
/dev/cua0....4 devices have been obsolete for some time.
One is supposed to open a serial device as:

    if((fd = open(modem, O_RDWR|O_NDELAY, 0)) == FAIL)
        ERRORS;
    if((flags = fcntl(fd, F_GETFL, 0)) == FAIL)
        ERRORS;
    flags &= ~O_NDELAY;
    if(fcntl(fd, F_SETFL, flags) == FAIL)
        ERRORS;

This allows one to set whatever terminal parameters are necessary
for the modem line, typically "raw", no interpretation, no
echo, and hardware flow-control.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

	Bill Gates? Who?

