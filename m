Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130480AbQL0Ca7>; Tue, 26 Dec 2000 21:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbQL0Cat>; Tue, 26 Dec 2000 21:30:49 -0500
Received: from quechua.inka.de ([212.227.14.2]:31842 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130480AbQL0Cah>;
	Tue, 26 Dec 2000 21:30:37 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: TCP keepalive seems to send to only one port
Message-Id: <E14B5su-0003RP-00@calista.inka.de>
Date: Wed, 27 Dec 2000 03:00:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001225224654.A2080@flower.cesarb> you wrote:
> Well, consider the scenario of an application which opens a control connection
> and a data connection, and the data connection remains idle for some hours
> while you get to the beginning of the queue, and then the transfer starts. The
> data connection is not open forever, and the timeout (and the periodic pings)
> is on the control connection.

The other way around (idle control connection) is trapped by Linux FTP
Masquerading, it will make sure the control connection does not time out, as
long as the Data connection is transmitting Data. This is even done in PASV
mode (thats why the FTP Masq mdule is uefull even in PASV mode).

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
