Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTDGPhb (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTDGPhb (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:37:31 -0400
Received: from smtp03.web.de ([217.72.192.158]:7177 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263499AbTDGPh3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:37:29 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: root@chaos.analogic.com
Subject: Re: modifying line state manually on ttyS
Date: Mon, 7 Apr 2003 17:48:50 +0200
User-Agent: KMail/1.5
References: <200304071702.08114.freesoftwaredeveloper@web.de> <Pine.LNX.4.53.0304071139390.18753@chaos>
In-Reply-To: <Pine.LNX.4.53.0304071139390.18753@chaos>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304071748.50910.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 17:51, Richard B. Johnson wrote:
> This means that you can't control TxD directly. I suggest that
> you use the parallel printer-port. This port allows you to set

That's my problem. parallel-port is used by a printer and I don't
wanna by an expensive extension card for second parport. :)

> Now, if you really need the +/- 12 volts that you think you
> will get out of a UART, please measure it first. Many new computers
> use I/O chips that only provide +/- 5 volts! Anyway, you can use the

That's no problem, because I "down-volt" it to 4.7V before using it.

> calls. You probably want to disable the SIGHUP signal before
> you muck with those bits. Some versions of Linux will send the
> hangup signal to the TTY owner even though it's not the controlling
> terminal for the process. This could cause your program to exit
> for "unknown" reasons; signal(SIGHUP, SIG_IGN) prevents such problems.

Thanks for this important information.

Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

